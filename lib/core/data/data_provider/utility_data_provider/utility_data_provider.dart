import 'dart:async';
import 'package:windfall/core/data/models/lga_details.dart';
import 'package:windfall/core/data/models/responses/response_data/config_data.dart';
import '../../../constants/api_routes.dart';
import '../../enum/request_type.dart';
import '../../models/responses/api_response.dart';
import '../../network_manager/network_manager.dart';




class UtilityDataProvider{

  //fetch Lga details
  Future<ApiResponse<List<LgaDetails>>> fetchLgaDetails() async {
    var completer = Completer<ApiResponse<List<LgaDetails>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchLgaDetails,
      );
      var result = ApiResponse<List<LgaDetails>>.fromJson(
        response,
            (data) => (data as List<dynamic>)
            .map((e) => LgaDetails.fromJson(
          e as Map<String, dynamic>,
        ))
            .toList(),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch 'hear about us' options
  // Future<HearAboutUsResponse> fetchHearAboutUs() async {
  //   var completer = Completer<HearAboutUsResponse>();
  //   try {
  //     Map<String, dynamic> response = await NetworkManager()
  //         .networkRequestManager(RequestType.get, ApiRoutes.fetchHearAboutUs,
  //       useAuth: false,
  //     );
  //     var result = HearAboutUsResponse.fromJson(response);
  //     completer.complete(result);
  //   } catch (e) {
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }

  //fetch configs
  Future<ApiResponse<ConfigData>> fetchConfigs() async {
    var completer = Completer<ApiResponse<ConfigData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchConfig,
        useAuth: false,
      );
      var result = ApiResponse<ConfigData>.fromJson(
        response,
            (data) => ConfigData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }


}