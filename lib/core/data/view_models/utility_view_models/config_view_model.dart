// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:winit/core/constants/app_constants.dart';
// import 'package:winit/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
// import 'package:winit/core/data/enum/view_state.dart';
// import 'package:winit/core/data/models/registration_configuration.dart';
// import 'package:winit/core/data/states/base_state.dart';
// import 'package:winit/core/utilities/utilities.dart';
// import 'package:winit/locator.dart';
//
// class ConfigViewModel extends BaseState{
//
//   //utility data provider
//   final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();
//
//   //message
//   String _message = '';
//   String get message => _message;
//
//   //registration config
//   RegistrationConfiguration? _registrationConfig;
//
//   bool get useEmailVerification => _registrationConfig?.verifyEmailOtp ?? false;
//   bool get useLga => _registrationConfig?.useLga ?? true;
//   bool get useLgaArea => _registrationConfig?.useLgaArea ?? false;
//
//
//   //fetch config
//   fetchConfig() async {
//     setState(ViewState.busy);
//     await _utilityDp.fetchConfigs().then((response) async{
//       _message = response.message ?? defaultSuccessMessage;
//       _registrationConfig = response.data?.registrationConfiguration;
//       setState(ViewState.retrieved);
//     }, onError: (e) {
//       _message = Utilities.formatMessage(e.toString(), isSuccess: false);
//       setState(ViewState.error);
//     });
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// }
//
// final configViewModel = ChangeNotifierProvider<ConfigViewModel>((ref){
//   return ConfigViewModel();
// });