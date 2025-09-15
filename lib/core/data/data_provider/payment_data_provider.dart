import 'dart:async';
import 'dart:convert';
import 'package:windfall/core/data/models/payment_breakdown.dart';
import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
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
  // Future<InitiateCheckoutResponse> initiateCheckout({required Map<String, dynamic> details}) async {
  //   var completer = Completer<InitiateCheckoutResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.post, ApiRoutes.initiateCheckout,
  //         useAuth: true,
  //         body: jsonEncode(details)
  //     );
  //     var result = InitiateCheckoutResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }
  //
  // //fetch payment methods
  // Future<PaymentMethodsResponse> fetchPaymentMethods() async {
  //   var completer = Completer<PaymentMethodsResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.get, ApiRoutes.fetchPaymentMethods,
  //         useAuth: true,
  //     );
  //     var result = PaymentMethodsResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }




}