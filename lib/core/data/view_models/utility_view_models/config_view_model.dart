import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/constants/app_constants.dart';
import 'package:windfall/core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'package:windfall/core/data/enum/view_state.dart';
import 'package:windfall/core/data/states/base_state.dart';
import 'package:windfall/core/utilities/utilities.dart';
import 'package:windfall/locator.dart';

import '../../models/responses/response_data/config_data.dart';

class ConfigViewModel extends BaseState{

  //utility data provider
  final UtilityDataProvider _utilityDp = locator<UtilityDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //registration config
  RegistrationConfiguration? _registrationConfig;

  //game config
  GameConfiguration? _gameConfig;



  //registration config value
  bool get useEmailVerification => _registrationConfig?.verifyEmailOtp ?? false;
  bool get useLga => _registrationConfig?.useLga ?? true;
  bool get useLgaArea => _registrationConfig?.useLgaArea ?? false;

  //game config values
  bool get usePromoCode => _gameConfig?.usePromoCode ?? false;
  bool get useReferralBonus => _gameConfig?.useReferralAmount ?? false;


  //fetch config
  fetchConfig() async {
    setState(ViewState.busy);
    await _utilityDp.fetchConfigs().then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      _registrationConfig = response.data?.registrationConfiguration;
      _gameConfig = response.data?.gameConfiguration;
      setState(ViewState.retrieved);
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }



















}

final configViewModel = ChangeNotifierProvider<ConfigViewModel>((ref){
  return ConfigViewModel();
});