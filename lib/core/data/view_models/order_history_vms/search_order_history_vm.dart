import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/data/models/order.dart';

import '../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../data_provider/order_history_data_provider.dart';
import '../../enum/view_state.dart';
import '../../states/base_state.dart';


class SearchOrderHistoryVm extends BaseState{

  //election data provider
  final OrderHistoryDataProvider _orderHistoryDp = locator<OrderHistoryDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //list of search result
  List<Order> _searchResults = [];
  List<Order> get searchResults => _searchResults;

  //page number
  int pageNumber = 1;

  //total records
  int totalRecords = 0;

  //fetch elections
  fetchOrderHistory({bool firstCall = true, bool refreshUi = true, required String keyWord}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _orderHistoryDp.fetchOrderHistory(
        pageNumber: pageNumber,
        filterParams: {'search':keyWord}
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _searchResults = response.data?.data ?? [];
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _searchResults.addAll(response.data?.data ?? []);
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
}

final searchOrderHistoryViewModel = ChangeNotifierProvider.autoDispose<SearchOrderHistoryVm>((ref){
  return SearchOrderHistoryVm();
});