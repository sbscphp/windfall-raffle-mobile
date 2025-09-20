import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../locator.dart';
import '../../../../constants/app_constants.dart';
import '../../../../utilities/utilities.dart';
import '../../../data_provider/profile_data_provider/notification_data_provider.dart';
import '../../../enum/view_state.dart';
import '../../../models/app_notification.dart';
import '../../../states/base_state.dart';



class NotificationVm extends BaseState{

  //notification data provider
  final NotificationDataProvider _notificationDp = locator<NotificationDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //all notifications
  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  //grouped notifications
  // List<GroupedList<AppNotification>> _groupedNotifications = [];
  // List<GroupedList<AppNotification>> get groupedNotifications => _groupedNotifications;

  //selected notification
  AppNotification? notification;


  //fetch all notifications
  fetchNotifications({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _notificationDp.fetchNotifications(
      pageNumber: pageNumber,
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _notifications = response.data?.data ?? [];
        // _groupedNotifications = Utilities.groupList<AppNotification>(
        //   _notifications,
        //       (notification) => notification.createdAt,
        // );
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _notifications.addAll(response.data?.data ?? []);
        // final newGrouping = Utilities.groupList<AppNotification>(
        //   response.data?.data ?? [],
        //       (notification) => notification.createdAt,
        // );
        // _groupedNotifications.addAll(newGrouping);
        setPaginatedState(ViewState.retrieved);
      }
      pageNumber++;
    }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      if(firstCall){
        setState(ViewState.error);
      }else{
        setPaginatedState(ViewState.error);
      }
    });
  }

  markNotificationAsRead(
      {required String? id, required int index}) async {

    setSecondState(ViewState.busy);

    await _notificationDp.markNotificationAsRead(id: id).then(
            (response) async {
             updateNotificationData(index);
          setSecondState(ViewState.retrieved);
        }, onError: (e) {
      setSecondState(ViewState.error);
    });
  }


  updateNotificationData(int index){
    try{
      _notifications[index].readAt = '';
      //_groupedNotifications[parentIndex].items[childIndex].readAt = '';
    }catch(e){
      return;
    }

  }


}

final notificationViewModel = ChangeNotifierProvider.autoDispose<NotificationVm>((ref){
  return NotificationVm();
});