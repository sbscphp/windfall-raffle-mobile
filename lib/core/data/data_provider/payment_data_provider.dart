import 'dart:async';
import 'dart:convert';
import 'package:windfall/core/data/models/payment_breakdown.dart';
import 'package:windfall/core/data/models/payment_method.dart';
import 'package:windfall/core/data/models/responses/response_data/order_data.dart';
import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../models/checkout_credentials.dart';
import '../models/responses/api_response.dart';
import '../network_manager/network_manager.dart';





class PaymentDataProvider{

  //fetch payment breakdown
  Future<ApiResponse<PaymentBreakdown>> fetchPaymentBreakdown({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<PaymentBreakdown>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.fetchPaymentBreakdown,
          useAuth: true,
          body: jsonEncode(details)
      );
      var result = ApiResponse<PaymentBreakdown>.fromJson(
        response,
            (data) => PaymentBreakdown.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  // //initiate checkout(flutterwave or paystack)
  Future<ApiResponse<CheckoutCredentials>> initiateCheckout({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<CheckoutCredentials>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, ApiRoutes.initiateCheckout,
          useAuth: true,
          body: jsonEncode(details)
      );
      var result = ApiResponse<CheckoutCredentials>.fromJson(
        response,
            (data) => CheckoutCredentials.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch payment methods
  Future<ApiResponse<List<PaymentMethod>>> fetchPaymentMethods() async {
    var completer = Completer<ApiResponse<List<PaymentMethod>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchPaymentMethods,
          useAuth: true,
      );
      var result = ApiResponse<List<PaymentMethod>>.fromJson(
        response,
            (data) => (data as List<dynamic>)
            .map((e) => PaymentMethod.fromJson(
          e as Map<String, dynamic>,
        ))
            .toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch order details
  Future<ApiResponse<OrderData>> fetchOrderDetails({required String? orderId}) async {
    var completer = Completer<ApiResponse<OrderData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchOrderDetails(orderId: orderId),
          useAuth: true,
      );
      var result = ApiResponse<OrderData>.fromJson(
        response,
            (data) => OrderData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }




}