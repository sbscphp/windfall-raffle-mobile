import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/secure_storage/secure_storage_utils.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/auth_data_provider/auth_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/user.dart';
import '../../states/base_state.dart';

class LoginVm extends BaseState {

  //authentication data provider
  final AuthDataProvider _authDataProvider = locator<AuthDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //user
  User? user;



  //login
  login(
      {required String email, required String password}) async {
    setState(ViewState.busy);

    // final pwd = useBiometrics
    //     ? await SecureStorageUtils.retrievePassword()
    //     : password;

    final token = await FirebaseMessaging.instance.getToken();


    final details = {
      "username": email,
      "remember_me": true,
      "password": password,
      "fcm_token": token,

    };
    await _authDataProvider.login(details: details).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      user = response.data?.user;
      await SecureStorageUtils.saveUserDetailsToStorage(
          response: response.data,
          password: password);
      Utilities.unauthorizedFlag = false;
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //clear user(user logged out)
  clearUser(){
    user = null;
    notifyListeners();
  }

  //logout
  // logout() async {
  //   await _authDataProvider.logout().then((response) async{
  //     await SecureStorageUtils.deleteKey(key: SecuredStorageConstants.token);
  //     Utilities.unauthorizedFlag = false;
  //     setState(ViewState.retrieved);
  //   }, onError: (e) {
  //   });
  // }
}

final loginViewModel =
ChangeNotifierProvider.autoDispose<LoginVm>((ref) {
  return LoginVm();
});