import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/constants/app_constants.dart';
import 'package:windfall/core/data/data_provider/payment_data_provider.dart';
import 'package:windfall/core/data/enum/checkout_type.dart';
import 'package:windfall/core/data/enum/view_state.dart';
import 'package:windfall/core/data/models/checkout_credentials.dart';
import 'package:windfall/core/data/models/order_detail.dart';
import 'package:windfall/core/data/models/payment_breakdown.dart';
import 'package:windfall/core/data/models/payment_method.dart';
import 'package:windfall/core/data/services/geolocator_service.dart';
import 'package:windfall/core/data/states/base_state.dart';
import 'package:windfall/core/utilities/utilities.dart';
import 'package:windfall/locator.dart';
import '../../data_provider/order_history_data_provider.dart';
import '../../models/cart_product.dart';
import '../../models/order.dart';
import '../checkout_vm.dart';

class OrderHistoryDetailsVm extends BaseState {

  //order history data provider
  final OrderHistoryDataProvider _orderHistoryDp = locator<OrderHistoryDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //order
  Order? _order;

  //list of order details
  List<OrderDetail> _orderDetails = [];
  List<OrderDetail> get orderDetails => _orderDetails;

  //order values
  double get totalTicketCount => double.tryParse(_order?.quantity?.toString() ?? '0') ?? 0;
  double get paidAmount => double.tryParse(_order?.paidAmount?.toString() ?? '0') ?? 0;
  String get paymentMethod => _order?.paymentMethod ?? 'N/A';
  String get status => _order?.paymentStatus ?? 'N/A';
  bool get isSuccessful => status.toLowerCase() == 'successful';
  bool get isFailed => status.toLowerCase() == 'failed';


  //fetch order history details
  fetchOrderHistoryDetails({required String? id}) async {

    setState(ViewState.busy);

    await _orderHistoryDp.fetchOrderHistoryDetails(id: id).then(
            (response) async {
          _message = response.message ?? defaultSuccessMessage;
          _order = response.data?.order;
          _orderDetails = response.data?.orderDetails ?? [];
          setState(ViewState.retrieved);
        }, onError: (e) {
      _message = Utilities.formatMessage(e.toString(), isSuccess: false);
      setState(ViewState.error);
    });
  }


}

final orderHistoryDetailsViewModel = ChangeNotifierProvider.autoDispose<OrderHistoryDetailsVm>((ref) {
  return OrderHistoryDetailsVm();
});
