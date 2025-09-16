import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:windfall/core/constants/app_constants.dart';
import 'package:windfall/core/data/data_provider/payment_data_provider.dart';
import 'package:windfall/core/data/enum/view_state.dart';
import 'package:windfall/core/data/states/base_state.dart';
import 'package:windfall/core/utilities/utilities.dart';
import 'package:windfall/locator.dart';
import '../../models/order.dart';
import '../../models/order_detail.dart';

class OrderDetailsVm extends BaseState {

  //payment data provider
  final PaymentDataProvider _paymentDp = locator<PaymentDataProvider>();

  //message
  String _message = '';
  String get message => _message;


  //list of payment orders
  List<OrderDetail> _orderDetails = [];
  List<OrderDetail> get orderDetails => _orderDetails;

  //order
  Order? _order;
  Order? get order => _order;

  String get receiptId => _order?.uniqueId ?? 'N/A';


  //fetch order details
  fetchOrderDetails({required String? orderId}) async {

    setState(ViewState.busy);

    await _paymentDp.fetchOrderDetails(orderId: orderId).then(
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

final orderDetailsViewModel = ChangeNotifierProvider<OrderDetailsVm>((ref) {
  return OrderDetailsVm();
});
