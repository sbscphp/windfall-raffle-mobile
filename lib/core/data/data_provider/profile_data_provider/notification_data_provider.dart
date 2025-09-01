import 'dart:async';
import 'dart:convert';
import 'package:windfall/core/data/models/notification_setting.dart';
import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../network_manager/network_manager.dart';




class NotificationDataProvider{

  //update notification settings
  Future<ApiResponse<NotificationSetting>> updateNotificationSettings({required Map<String, dynamic> details}) async {
    var completer = Completer<ApiResponse<NotificationSetting>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.put, ApiRoutes.updateNotificationSettings,
        useAuth: true,
        body: jsonEncode(details)
      );
      var result = ApiResponse<NotificationSetting>.fromJson(
        response,
            (data) => NotificationSetting.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch notifications
  // Future<NotificationsResponse> fetchNotifications({required int? pageNumber}) async {
  //   var completer = Completer<NotificationsResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.post, ApiRoutes.fetchNotifications(pageNumber: pageNumber),
  //         useAuth: true,
  //         body: jsonEncode({
  //           "module": "", //
  //           "category": "",
  //           "status": "", //read, unread
  //           "start_date": "",
  //           "end_date": "",
  //           "paginate": "true",
  //           "limit": "10"
  //         })
  //     );
  //     var result = NotificationsResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }

  //mark notification as read
  // Future<DefaultResponse> markNotificationAsRead({required String? id}) async {
  //   var completer = Completer<DefaultResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.post, ApiRoutes.markNotificationAsRead(id: id),
  //         useAuth: true,
  //     );
  //     var result = DefaultResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }



}