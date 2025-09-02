import 'dart:async';
import 'dart:convert';

import 'package:windfall/core/data/network_manager/network_manager.dart';

import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../models/responses/response_data/login_data.dart';
import '../../models/user.dart';




class AuthDataProvider{

  //register
  Future<ApiResponse<User>> register({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<User>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.register,
        useAuth: false,
        body: jsonEncode(details)
      );
      var result = ApiResponse<User>.fromJson(
          response,
            (data) => User.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //LOGIN
  Future<ApiResponse<LoginData>> login({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<LoginData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.login,
          useAuth: false,
          body: jsonEncode(details)
      );
      var result = ApiResponse<LoginData>.fromJson(
        response,
            (data) => LoginData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  // //reset password
  // Future<ApiResponse> resetPassword({Map<String, dynamic>? details}) async {
  //   var completer = Completer<ApiResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManagerWithTokenRefresh()
  //         .networkRequestManager(RequestType.post, ApiRoutes.resetPassword,
  //         useAuth: false,
  //         body: jsonEncode(details)
  //     );
  //     var result = ApiResponse.fromJson(response, null);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }

  Future<ApiResponse> createPassword({required Map<String, dynamic> details, required String? userId}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.createPassword(userId: userId),
          useAuth: false,
          body: jsonEncode(details)
      );
      var result = ApiResponse.fromJson(response, null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //update password
  Future<ApiResponse> updatePassword({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.updatePassword,
          useAuth: true,
          body: jsonEncode(details)
      );
      var result = ApiResponse.fromJson(response, null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }




}