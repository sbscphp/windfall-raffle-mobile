import 'dart:async';
import 'dart:convert';
import 'package:windfall/core/data/models/responses/api_response.dart';
import 'package:windfall/core/data/models/responses/response_data/cart_data.dart';
import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../network_manager/network_manager.dart';


class CartDataProvider{

  //fetch cart
  Future<ApiResponse<CartData>> fetchCart() async {
    var completer = Completer<ApiResponse<CartData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchCart,
          useAuth: true
      );
      var result = ApiResponse<CartData>.fromJson(
        response,
            (data) => CartData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //delete item
  Future<ApiResponse<CartData>> deleteItem({required String? gameId}) async {
    var completer = Completer<ApiResponse<CartData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.delete, ApiRoutes.deleteItem(gameId: gameId),
          useAuth: true
      );
      var result = ApiResponse<CartData>.fromJson(
        response,
            (data) => CartData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
  
  //add to cart
  Future<ApiResponse<CartData>> addToCart({required String? gameId, required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<CartData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.addToCart(gameId: gameId),
          useAuth: true,
        body: jsonEncode(details)
      );
      var result = ApiResponse<CartData>.fromJson(
        response,
            (data) => CartData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }








}