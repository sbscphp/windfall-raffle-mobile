import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:windfall/core/utilities/extensions/num_extension.dart';

import '../../../locator.dart';
import '../../constants/app_config.dart';
import '../../constants/named_routes.dart';
import '../../utilities/secure_storage/secure_storage_utils.dart';
import '../../utilities/utilities.dart';
import '../enum/request_type.dart';
import '../services/navigation_service.dart';

class NetworkManager {
  static final NetworkManager _instance = NetworkManager._internal();

  static BaseOptions options = BaseOptions(
    connectTimeout: const Duration(minutes: 5),
    receiveTimeout: const Duration(minutes: 5),
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      'Platform': 'mobile'
    },
  );

  late final Dio client;
  
  // Token refresh management
  bool _isRefreshing = false;
  final List<Completer<void>> _pendingRequests = [];

  factory NetworkManager() {
    return _instance;
  }

  NetworkManager._internal() {
    client = Dio(options);

    client.interceptors.clear();
    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          bool useAuth = options.extra["useAuth"] ?? true;
          bool useGuestToken = options.extra["useGuestToken"] ?? false;
          if (useAuth) {
            String? token = await SecureStorageUtils.retrieveToken();
            print('token:::$token>>>');
            if (token != null && token.isNotEmpty) {
              options.headers["Authorization"] = "Bearer $token";
            }
          }
          if (useGuestToken) {
            String? guestToken = await SecureStorageUtils.retrieveGuestToken();
            print('guest token:::$guestToken>>>');
            if (guestToken != null && guestToken.isNotEmpty) {
              options.headers["X-Guest-Cart-ID"] = guestToken;
            }
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          final response = error.response;
          final requestOptions = error.requestOptions;
          final useAuth = requestOptions.extra["useAuth"] ?? true;

          // Handle 401 Unauthorized errors
          if (useAuth && response?.statusCode == 401) {
            // Don't try to refresh if this its the refresh request
            if (requestOptions.path.contains('/auth/token/refresh')) {
              log("Refresh token request failed");
              await _handleSessionExpired();
              return handler.reject(error);
            }
            // If already refreshing, queue this request
            if (_isRefreshing) {
              log("Token refresh in progress, queuing request...");
              final completer = Completer<void>();
              _pendingRequests.add(completer);
              
              try {
                await completer.future;
                // Retry the request with new token
                final newToken = await SecureStorageUtils.retrieveToken();
                if (newToken != null && newToken.isNotEmpty) {
                  requestOptions.headers["Authorization"] = "Bearer $newToken";
                  final retryResponse = await client.fetch(requestOptions);
                  return handler.resolve(retryResponse);
                }
              } catch (e) {
                return handler.reject(error);
              }
            }

            // Start token refresh
            _isRefreshing = true;
            
            try {
              final refreshToken = await SecureStorageUtils.retrieveRefreshToken();
              log("REFRESH TOKEN::: $refreshToken");

              if (refreshToken == null || refreshToken.isEmpty) {
                throw Exception('No refresh token available');
              }

              final refreshResponse = await client.get(
                '${AppConfig.baseUrl}${dotenv.env['CUSTOMER']}/auth/token/refresh',
                queryParameters: {"refresh_token": refreshToken},
                options: Options(
                  // Use current token to authorize new token
                  sendTimeout: const Duration(seconds: 30),
                  receiveTimeout: const Duration(seconds: 30),
                ),
              );

              log("REFRESH RESPONSE::: ${refreshResponse.data}");

              if (refreshResponse.statusCode != 200) {
                log('Token refresh failed with status: ${refreshResponse.statusCode}');
                throw Exception('Token refresh failed with status: ${refreshResponse.statusCode}');
              }

              final newAccessToken = refreshResponse.data['data']['access_token'];
              final newRefreshToken = refreshResponse.data['data']['refresh_token'];

              
              if (newAccessToken == null || newAccessToken.isEmpty) {
                throw Exception('Invalid access token received');
              }

              // Save new tokens
              await SecureStorageUtils.saveToken(token: newAccessToken);
              await SecureStorageUtils.saveRefreshToken(refreshToken: newRefreshToken);
              log("New access token saved successfully");

              // Retry original request with new token
              requestOptions.headers["Authorization"] = "Bearer $newAccessToken";
              final clonedResponse = await client.fetch(requestOptions);

              // Resolve all pending requests
              for (var completer in _pendingRequests) {
                if (!completer.isCompleted) {
                  completer.complete();
                }
              }
              _pendingRequests.clear();
              _isRefreshing = false;

              return handler.resolve(clonedResponse);
              
            } catch (e) {
              log("Token refresh error: $e");
              
              // Reject all pending requests
              for (var completer in _pendingRequests) {
                if (!completer.isCompleted) {
                  completer.completeError(e);
                }
              }
              _pendingRequests.clear();
              _isRefreshing = false;

              // Handle session expired
              await _handleSessionExpired();
              
              return handler.reject(error);
            }
          }
          
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _handleSessionExpired() async {
    if (Utilities.unauthorizedFlag == false) {
      Utilities.unauthorizedFlag = true;
      
      // // Clear all tokens
      // await SecureStorageUtils.deleteAll();
      
      // Navigate to login
      try {
        NavigationService navigationService = locator<NavigationService>();
        navigationService.pushAndClearRoutes(
          routeName: NamedRoutes.login,
          clearRoute: NamedRoutes.onboarding,
        );
      } catch (e) {
        log("Navigation error in session expired: $e");
      }
    }
  }

  Future<Map<String, dynamic>> networkRequestManager(
      RequestType requestType,
      String requestUrl, {
        dynamic body,
        queryParameters,
        bool useAuth = true,
        bool useGuestToken = false,
        File? backFile,
        bool retrieveResponse = false,
        bool retrieveUnauthorizedResponse = false,
      }) async {
    Map<String, dynamic> apiResponse;
    final baseUrl = AppConfig.baseUrl;
    final url = '$baseUrl$requestUrl';

    print("Url: $url, Body: $body, Query: $queryParameters, useAuth: $useAuth");

    try {
      Response response;
      final options = Options(extra: {"useAuth": useAuth, "useGuestToken": useGuestToken});

      switch (requestType) {
        case RequestType.get:
          response = await client.get(url, queryParameters: queryParameters, options: options);
          break;
        case RequestType.post:
          response = await client.post(url, data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.multiPartPost:
          response = await client.post(url, data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.put:
          response = await client.put(url, data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.patch:
          response = await client.patch(url, data: body, queryParameters: queryParameters, options: options);
          break;
        case RequestType.delete:
          response = await client.delete(url, data: body, queryParameters: queryParameters, options: options);
          break;
        }

      apiResponse = response.data;
      log("${requestType.name} response: $apiResponse");
      return apiResponse;
    } on TimeoutException {
      throw ("Network timed out, please check your network connection and try again");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ("Network timed out, please check your network connection and try again");
      }

      if (e.type == DioExceptionType.unknown && e.message?.contains('SocketException') == true) {
        throw ("No internet connection, please check your network connection and try again");
      }

      debugPrint('code: ${e.response?.statusCode}');

      if (e.response != null) {
        final statusCode = e.response!.statusCode!;
        final responseData = e.response!.data;

        if (statusCode == 400) {
          if (retrieveResponse) return responseData;
          throw (responseData['message'] ?? 'Bad request');
        } else if (statusCode == 401) {
          // 401 is now handled by the interceptor
          if (retrieveUnauthorizedResponse) return responseData;
          throw (responseData['message'] ?? 'Unauthorized');
        } else if (statusCode == 403 || statusCode == 404) {
          throw (responseData['message'] ?? "Resource not available");
        } else if (statusCode.isBetween(402, 422)) {
          throw (responseData['message'] ?? "Invalid credentials");
        } else if (statusCode.isBetween(500, 599)) {
          if (statusCode == 502) {
            throw ("We are unable to process request at this time, please try again later");
          }
          throw (responseData['message'] ?? "Server error, please try again later");
        } else {
          throw ("Unable to process request, ${responseData['message'] ?? 'Unknown error'}");
        }
      } else {
        throw ("An unexpected error occurred");
      }
    } catch (e) {
      log("Network request error: $e");
      rethrow;
    }
  }
}

// Removed sessionExpired() global function - now handled internally