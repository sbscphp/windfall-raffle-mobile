import 'dart:async';
import 'dart:convert';
import 'package:windfall/core/data/models/notification_setting.dart';
import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/app_notification.dart';
import '../../models/responses/api_response.dart';
import '../../models/responses/response_data/pagination_data.dart';
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
  Future<ApiResponse<PaginationData<AppNotification>>> fetchNotifications({required int? pageNumber}) async {
    var completer = Completer<ApiResponse<PaginationData<AppNotification>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchNotifications(pageNumber: pageNumber),
          useAuth: true
      );
      var result = ApiResponse<PaginationData<AppNotification>>.fromJson(
        response,
            (data) => PaginationData<AppNotification>.fromJson(
          data as Map<String, dynamic>,
              (gameJson) => AppNotification.fromJson(gameJson),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //mark notification as read
  Future<ApiResponse> markNotificationAsRead({required String? id}) async {
    var completer = Completer<ApiResponse>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.markNotificationAsRead(id: id),
          useAuth: true,
      );
      var result = ApiResponse.fromJson(
          response,
          null);
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}