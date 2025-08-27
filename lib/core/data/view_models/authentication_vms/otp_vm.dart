import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/auth_data_provider/otp_data_provider.dart';
import '../../enum/otp_type.dart';
import '../../enum/view_state.dart';
import '../../states/base_state.dart';

class OtpVm extends BaseState {
  //otp data provider
  final OtpDataProvider _otpDataProvider = locator<OtpDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  String? userId;

  //send otp based on otp type
  sendOtp({
    required OtpType otpType,
    required String key,
    required String value,
  }) async {
    setState(ViewState.busy);
    final details = {
      key: value
    };
    await _otpDataProvider
        .sendOtp(otpType: otpType, details: details)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      if(otpType == OtpType.forgotPassword){
        userId = response.data?.userId;
      }
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //resends otp
  resendOtp({
    required OtpType otpType,
  }) async {
    setState(ViewState.busy);
    await _otpDataProvider
        .resendOtp(otpType: otpType, userId: userId)
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }



  //validate otp based on OtpType
  validateOtp(
      {required OtpType otpType,
      required String otp,
        String? key,
        String? value
      }) async {

    if(otp.length != 6){
      _message = 'Input a 6-digit otp to proceed';
      setSecondState(ViewState.error);
      return;
    }

    setSecondState(ViewState.busy);
    Map<String, dynamic> details = {};
    if(otpType == OtpType.forgotPassword){
      details = {"code": otp};
    }
    else{
      details = {
        key!: value,
        'otp': otp
      };
    }

    await _otpDataProvider
        .validateOtp(
            otpType: otpType,
            userId: userId,
            details: details
    )
        .then((response) {
      _message = response.message ?? defaultSuccessMessage;
      setSecondState(ViewState.retrieved);
    }, onError: (e) async{
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }


}

final otpViewModel = ChangeNotifierProvider.autoDispose<OtpVm>((ref) {
  return OtpVm();
});
