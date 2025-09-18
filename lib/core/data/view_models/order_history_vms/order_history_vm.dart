import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/data/data_provider/order_history_data_provider.dart';
import 'package:windfall/core/data/models/order.dart';
import '../../../../../locator.dart';
import '../../../constants/app_constants.dart';
import '../../../utilities/utilities.dart';
import '../../enum/view_state.dart';
import '../../models/grouped_list.dart';
import '../../states/base_state.dart';



class OrderHistoryVm extends BaseState{

  //order history data provider
  final OrderHistoryDataProvider _orderHistoryDp = locator<OrderHistoryDataProvider>();

  //message
  String _message = '';
  String get message => _message;

  //page number
  int pageNumber = 1;


  //total records
  int totalRecords = 0;


  //order history
  List<Order> _orderHistory = [];
  List<Order> get orderHistory => _orderHistory;

  //grouped histories
  List<GroupedList<Order>> _groupedHistories = [];
  List<GroupedList<Order>> get groupedHistories => _groupedHistories;




  //fetch order history
  fetchOrderHistory({bool firstCall = true, bool refreshUi = true}) async {
    if(firstCall){
      pageNumber = 1;
      if(refreshUi)setState(ViewState.busy);
    }
    else{
      setPaginatedState(ViewState.busy);
    }

    await _orderHistoryDp.fetchOrderHistory(
      pageNumber: pageNumber,
    ).then((response) async{
      _message = response.message ?? defaultSuccessMessage;
      totalRecords = response.data?.total ?? 0;
      if(firstCall){
        //populate list
        _orderHistory = response.data?.data ?? [];
        _groupedHistories = Utilities.groupList<Order>(
          _orderHistory,
              (orderHistory) => orderHistory.createdAt,
        );
        setState(ViewState.retrieved);
      }
      else{
        //add to list
        _orderHistory.addAll(response.data?.data ?? []);
        final newGrouping = Utilities.groupList<Order>(
          response.data?.data ?? [],
              (orderHistory) => orderHistory.createdAt,
        );
        _groupedHistories.addAll(newGrouping);
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

final orderHistoryViewModel = ChangeNotifierProvider<OrderHistoryVm>((ref){
  return OrderHistoryVm();
});