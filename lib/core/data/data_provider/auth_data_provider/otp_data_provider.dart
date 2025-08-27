import 'dart:async';
import 'dart:convert';

import 'package:windfall/core/data/models/otp_data.dart';

import '../../../constants/api_routes.dart';
import '../../enum/otp_type.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../network_manager/network_manager.dart';



class OtpDataProvider{

  //send otp
  Future<ApiResponse<OtpData>> sendOtp({required OtpType otpType, Map<String, dynamic>? details,  int? userId}) async {
    var completer = Completer<ApiResponse<OtpData>>();
    try {
      String apiRoute = '';
      if(otpType == OtpType.forgotPassword){
        //send otp for forgot password
        apiRoute = ApiRoutes.sendForgotPasswordOtp;
      }
      if(otpType == OtpType.verifyEmail){
        //send otp to verify email
        apiRoute = ApiRoutes.sendOtpVerifyEmail;
      }
      if(otpType == OtpType.verifyPhone){
        //send otp to verify phone
        apiRoute = ApiRoutes.sendOtpVerifyPhone;
      }
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, apiRoute,
          useAuth: isOtpUseAuth(otpType: otpType),
          body: details != null ? jsonEncode(details) : null
      );
      var result = ApiResponse<OtpData>.fromJson(
        response,
            (data) => OtpData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //resend otp
  Future<ApiResponse<OtpData>> resendOtp({required OtpType otpType, String? userId}) async {
    var completer = Completer<ApiResponse<OtpData>>();
    try {
      String apiRoute = '';
      if(otpType == OtpType.forgotPassword){
        //resend otp for forgot password
        apiRoute = ApiRoutes.resendForgotPasswordOtp(userId: userId);
      }
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, apiRoute,
        useAuth: isOtpUseAuth(otpType: otpType),
      );
      var result = ApiResponse<OtpData>.fromJson(
        response,
            (data) => OtpData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }


  //validate otp
  Future<ApiResponse> validateOtp({required OtpType otpType, required Map<String, dynamic> details, required String? userId}) async {
    var completer = Completer<ApiResponse>();
    try {
      String apiRoute = '';
      if(otpType == OtpType.forgotPassword){
        //validate otp for forgot password
        apiRoute = ApiRoutes.verifyForgotPasswordOtp(userId: userId);
      }
      if(otpType == OtpType.verifyEmail){
        //validate otp for email verification
        apiRoute = ApiRoutes.verifyOtpEmail;
      }
      if(otpType == OtpType.verifyPhone){
        //validate otp for phone verification
        apiRoute = ApiRoutes.verifyOtpPhone;
      }
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.post, apiRoute,
          useAuth: isOtpUseAuth(otpType: otpType),
          body:jsonEncode(details)
      );
      var result = ApiResponse.fromJson(response, null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  // returns flag for useAuth
  isOtpUseAuth({required OtpType otpType}) {
    switch (otpType) {
      case OtpType.forgotPassword:
      case OtpType.verifyEmail:
      case OtpType.verifyPhone:
        return false;
      default:
        return true;
    }
  }
}