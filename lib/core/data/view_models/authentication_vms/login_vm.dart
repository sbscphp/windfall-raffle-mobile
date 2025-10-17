import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/utilities/firebase_messaging_utils.dart';
import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/secure_storage_constants.dart';
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

  bool get isLoggedIn => user != null;



  //login
  login(
      {required String email, required String password}) async {
    setState(ViewState.busy);

    // final pwd = useBiometrics
    //     ? await SecureStorageUtils.retrievePassword()
    //     : password;

    final token = await FirebaseMessagingUtils.getFirebaseToken();


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

  initUserFromStorage({bool refreshUi = true})async{
    user = await SecureStorageUtils.retrieveUser();
    if(refreshUi)notifyListeners();
  }

  //clear user(user logged out)
  clearUser({bool refreshUi = true}){
    user = null;
    if(refreshUi)notifyListeners();
  }

  logOut() async {
    setSecondState(ViewState.busy);
    await _authDataProvider
        .logout().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      await SecureStorageUtils.deleteKey(key: SecuredStorageConstants.token);
      await SecureStorageUtils.deleteKey(key: SecuredStorageConstants.user);
      clearUser(refreshUi: false);
      setSecondState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setSecondState(ViewState.error);
    });
  }
}

final loginViewModel =
ChangeNotifierProvider.autoDispose<LoginVm>((ref) {
  return LoginVm();
});