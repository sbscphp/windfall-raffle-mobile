import 'dart:async';
import 'package:windfall/core/data/models/order.dart';
import 'package:windfall/core/data/models/responses/api_response.dart';
import 'package:windfall/core/data/models/responses/response_data/pagination_data.dart';
import '../../constants/api_routes.dart';
import '../../utilities/utilities.dart';
import '../enum/request_type.dart';
import '../models/responses/response_data/order_data.dart';
import '../network_manager/network_manager.dart';





class OrderHistoryDataProvider{

  //fetch order history
  Future<ApiResponse<PaginationData<Order>>> fetchOrderHistory({required int? pageNumber, Map<String, dynamic>? filterParams}) async {
    var completer = Completer<ApiResponse<PaginationData<Order>>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchOrderHistory(pageNumber: pageNumber, filterParams: Utilities.returnQueryString(params: filterParams)),
          useAuth: true
      );
      var result = ApiResponse<PaginationData<Order>>.fromJson(
        response,
            (data) => PaginationData<Order>.fromJson(
          data as Map<String, dynamic>,
              (gameJson) => Order.fromJson(gameJson),
        ),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }

  //fetch order history details
  Future<ApiResponse<OrderData>> fetchOrderHistoryDetails({required String? id}) async {
    var completer = Completer<ApiResponse<OrderData>>();
    try {
      Map<String, dynamic> response = await NetworkManager()
          .networkRequestManager(RequestType.get, ApiRoutes.fetchOrderHistoryDetails(id: id),
        useAuth: true,
      );
      var result = ApiResponse<OrderData>.fromJson(
        response,
            (data) => OrderData.fromJson(data as Map<String, dynamic>),
      );
      completer.complete(result);
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }














}