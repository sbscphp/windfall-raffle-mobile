import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/utilities/secure_storage/secure_storage_utils.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/date_utilitites.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/profile_data_provider/profile_data_provider.dart';
import '../../enum/view_state.dart';
import '../../models/user.dart';
import '../../states/base_state.dart';



class ProfileVm extends BaseState{

  //profile data provider
  final ProfileDataProvider _profileDp = locator<ProfileDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //user
  User? _user;
  User? get user => _user;
  set user(User? val){
    _user = val;
    notifyListeners();
  }


  String get userId => _user?.uuid ?? '';
  String get uniqueId => _user?.uniqueId ?? '';
  String get email => _user?.email ?? '';
  String get firstname => _user?.firstname ?? '';
  String get lastname => _user?.lastname ?? '';
  String get phoneNumber => "+234 ${Utilities.formatSavedUserPhoneNumber(phoneNumber: _user?.phoneNumber ?? '')}";
  String get dob => DateUtilities.reverseDate(_user?.dateOfBirth?.toIso8601String().split('T')[0] ?? '');
  String? get lga => _user?.lga;
  String? get area => _user?.area;
  String get image => _user?.avatar ?? '';
  bool get hasImage => image.isNotEmpty;
  String get referralCode => _user?.referralCode ?? '';
  String get referralLink => _user?.referralLink ?? '';
  bool get biometricsEnabled => _user?.biometrics?.toLowerCase() == 'true';



  //fetch profile
  fetchProfile({bool showBusyState = true}) async {

    if(showBusyState)setThirdState(ViewState.busy);

    await _profileDp.fetchProfile().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _user = response.data;
      setThirdState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setThirdState(ViewState.error);
    });
  }

  //update profile
  updateProfile(
      {required Map<String, dynamic> details, bool isUpdatingBiometricsPref = false}) async {

    setState(ViewState.busy);

    await _profileDp.updateProfile(details: details).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _user = response.data;
      if(isUpdatingBiometricsPref){
        final _pref = details['biometrics'].toString().toLowerCase() == 'true';
        await SecureStorageUtils.saveBiometricsPref(value: _pref);
      }
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }

  //update password
  // updatePassword(
  //     {required String oldPwd, required String newPwd, required String confirmPwd, required bool passwordRequirementsPassed}) async {
  //
  //   if(!passwordRequirementsPassed){
  //     _message = "Your password didn't pass the requirement";
  //     setSecondState(ViewState.error);
  //     return;
  //   }
  //
  //   if (newPwd != confirmPwd) {
  //     _message = "Your passwords do not match";
  //     setSecondState(ViewState.error);
  //     return;
  //   }
  //
  //   setSecondState(ViewState.busy);
  //
  //   final details = {
  //     "old_password": oldPwd,
  //     "password": newPwd,
  //     "password_confirmation": confirmPwd
  //   };
  //
  //   await _profileDp.updatePassword(details: details).then((response) async{
  //     _message = response.message ?? defaultSuccessMessage;
  //     //clear token
  //     await SecureStorageUtils.deleteKey(key: SecuredStorageConstants.token);
  //     setSecondState(ViewState.retrieved);
  //   }, onError: (e) {
  //     _message = Utilities.formatMessage(e.toString(), isSuccess: false);
  //     setSecondState(ViewState.error);
  //   });
  // }



}

final profileViewModel = ChangeNotifierProvider.autoDispose<ProfileVm>((ref){
  return ProfileVm();
});