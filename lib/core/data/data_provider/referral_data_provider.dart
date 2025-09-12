import 'dart:async';
import 'package:windfall/core/data/models/responses/api_response.dart';
import 'package:windfall/core/data/models/responses/response_data/referral_history_data.dart';
import '../../constants/api_routes.dart';
import '../enum/request_type.dart';
import '../network_manager/network_manager.dart';


class ReferralDataProvider{

  //fetch referral history
  Future<ApiResponse<ReferralHistoryData>> fetchReferralHistory({required int? pageNumber, required String? filterOption}) async {
    var completer = Completer<ApiResponse<ReferralHistoryData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchReferralHistory(pageNumber: pageNumber, filterOption: filterOption),
          useAuth: true
      );
      var result = ApiResponse<ReferralHistoryData>.fromJson(
        response,
            (data) => ReferralHistoryData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

}