import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/date_utilitites.dart';
import '../../../utilities/firebase_messaging_utils.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/auth_data_provider/auth_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/user.dart';
import '../../states/base_state.dart';
import '../utility_view_models/config_view_model.dart';

class RegistrationVm extends BaseState {

  //auth data provider
  final AuthDataProvider _authDp = locator<AuthDataProvider>();

  String _message = '';
  String get message => _message;

  User? user;

  bool _isEmailVerified = false;
  bool get isEmailVerified => _isEmailVerified;
  set isEmailVerified(bool val) {
    _isEmailVerified = val;
    notifyListeners();
  }

  bool _isPhoneVerified = false;
  bool get isPhoneVerified => _isPhoneVerified;
  set isPhoneVerified(bool val) {
    _isPhoneVerified = val;
    notifyListeners();
  }

  bool _isLagResident = false;
  bool get isLagResident => _isLagResident;
  set isLagResident(bool val) {
    _isLagResident = val;
    notifyListeners();
  }

  bool _receiveEmailNotification = false;
  bool get receiveEmailNotification => _receiveEmailNotification;
  set receiveEmailNotification(bool val) {
    _receiveEmailNotification = val;
    notifyListeners();
  }

  bool _acceptTerms = false;
  bool get acceptTerms => _acceptTerms;
  set acceptTerms(bool val) {
    _acceptTerms = val;
    notifyListeners();
  }

  bool _is18yrs = false;
  bool get is18yrs => _is18yrs;
  set is18yrs(bool val) {
    _is18yrs = val;
    notifyListeners();
  }

  registration(
      {
        required String firstname,
        required String lastname,
        required String referral,
        required String email,
        required String phone,
        required String dob,
        required String? lga,
        required String? area,
        required String? hearAboutUs,
        required String pwd,
        required String confirmPwd,
        required bool passwordRequirementsPassed
      }) async {


    if (!_isEmailVerified) {
      _message = 'Kindly Verify your email to proceed';
      setState(ViewState.error);
      return;
    }

    // if (!_isPhoneVerified) {
    //   _message = 'Kindly Verify your phone number to proceed';
    //   setState(ViewState.error);
    //   return;
    // }

    if (dob.isEmpty) {
      _message = 'Kindly select your birthday to proceed';
      setState(ViewState.error);
      return;
    }

    // if (!_isLagResident) {
    //   _message = "Kindly confirm that you're a resident of lagos to proceed";
    //   setState(ViewState.error);
    //   return;
    // }

    if (lga == null) {
      _message = "Kindly select your LGA to proceed";
      setState(ViewState.error);
      return;
    }

    if (area == null) {
      _message = "Kindly select your area to proceed";
      setState(ViewState.error);
      return;
    }

    if(!passwordRequirementsPassed){
      _message = "Your password didn't pass the requirement";
      setState(ViewState.error);
      return;
    }

    if (pwd != confirmPwd) {
      _message = "Your passwords do not match";
      setState(ViewState.error);
      return;
    }

    // if (hearAboutUs == null) {
    //   _message = "Kindly select where you heard about us to proceed";
    //   setState(ViewState.error);
    //   return;
    // }

    if (!_acceptTerms) {
      _message = "Kindly accept the terms to proceed";
      setState(ViewState.error);
      return;
    }

    if (!_is18yrs) {
      _message = "Kindly confirm that you're at least 18 years of age to proceed";
      setState(ViewState.error);
      return;
    }



    setState(ViewState.busy);

    final token = await FirebaseMessagingUtils.getFirebaseToken();

    final details = {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "phone_number": phone,
      "password": pwd,
      "password_confirmation": confirmPwd,
      //"confirm_resident": _isLagResident,
      "lga": lga,
      "landmark": area,
      "optIn_exclusive_offer": _receiveEmailNotification,
      "date_of_birth": DateUtilities.reverseDate(dob),
      //"heard_from": hearAboutUs,
      "referral_code": referral,
      "fcm_token": token,
      "platform":"mobile"
    };


    await _authDp.register(details: details).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      user = response.data;
      //save token to secure storage
      //await SecureStorageUtils.saveToken(token: response.data?.accessToken ?? '');
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }
}


final registrationViewModel =
    ChangeNotifierProvider.autoDispose<RegistrationVm>((ref) {
  return RegistrationVm();
});
