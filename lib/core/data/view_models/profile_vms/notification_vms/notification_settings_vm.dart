import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../locator.dart';
import '../../../../constants/app_constants.dart';
import '../../../../utilities/utilities.dart';
import '../../../data_provider/profile_data_provider/notification_data_provider.dart';
import '../../../enum/view_state.dart';
import '../../../models/notification_setting.dart';
import '../../../states/base_state.dart';



class NotificationSettingsVm extends BaseState{

  //notification data provider
  final NotificationDataProvider _notificationDp = locator<NotificationDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //notification settings
  NotificationSetting? _settings;
  NotificationSetting? get settings => _settings;
  set settings(NotificationSetting? val){
    _settings = val;
    print('at init:::::${_settings?.toJson()}>>>>');
    notifyListeners();
  }

  bool get push => _settings?.pushNotification?.toLowerCase() == 'true';
  bool get email => _settings?.emailNotification?.toLowerCase() == 'true';
  bool get gameDraw => _settings?.gameDraw?.toLowerCase() == 'true';
  bool get gameResult => _settings?.gameResultWinners?.toLowerCase() == 'true';
  bool get gameSuggestion => _settings?.gameSuggestions?.toLowerCase() == 'true';
  bool get newGames => _settings?.newGames?.toLowerCase() == 'true';
  bool get paymentTransaction => _settings?.paymentTransactions?.toLowerCase() == 'true';
  bool get promotional => _settings?.promotional?.toLowerCase() == 'true';
  bool get accountSecurity => _settings?.accountSecurity?.toLowerCase() == 'true';




//login
updateNotificationSettings(
    {
      bool push = true,
      bool email = true,
      bool gameDraw = true,
      bool gameResult = true,
      bool gameSuggestions = true,
      bool newGames = true,
      bool paymentTransactions = true,
      bool promotional = true,
      bool accountSecurity = true
    }) async {

  setState(ViewState.busy);

  final details = {
      "push_notification":  push ? "true":'false',
      "email_notification":  email ? "true":'false',
      "game_draw":  gameDraw ? "true":'false',
      "game_result_winners":  gameResult ? "true":'false',
      "game_suggestions":  gameSuggestions ? "true":'false',
      "new_games":  newGames ? "true":'false',
      "payment_transactions": paymentTransactions ? "true":'false',
      "promotional":  promotional ? "true":'false',
      "account_security": accountSecurity ? "true":'false',
  };

  await _notificationDp.updateNotificationSettings(details: details).then((response) async{
    _message = response.message ?? defaultSuccessMessage;
    _settings = response.data;
    setState(ViewState.retrieved);
  }, onError: (e) {
    _message = Utilities.formatMessage(e.toString(), isSuccess: false);
    setState(ViewState.error);
  });
}



}

final notificationSettingsViewModel = ChangeNotifierProvider<NotificationSettingsVm>((ref){
  return NotificationSettingsVm();
});