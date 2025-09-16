import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/data/view_models/payment_vms/order_details_vm.dart';
import 'package:windfall/core/data/view_models/payment_vms/payment_vm.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/payment_receipt_item.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

import '../../../core/data/enum/view_state.dart';

class PaymentReceipt extends ConsumerStatefulWidget {
  const PaymentReceipt({super.key});

  @override
  ConsumerState<PaymentReceipt> createState() => _PaymentReceiptState();
}

class _PaymentReceiptState extends ConsumerState<PaymentReceipt> {

  @override
  void initState() {
    final vm = ref.read(orderDetailsViewModel);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      vm.fetchOrderDetails(orderId: ref.read(paymentViewModel).orderId);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: true,
        title: 'Payment receipt',
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final vm = ref.watch(orderDetailsViewModel);

            if(vm.state == ViewState.busy){
              return Center(
                child: AppLoader(),
              );
            }

            if(vm.state == ViewState.retrieved){
              return Padding(
                padding: EdgeInsets.only(
                  top: AppDimension.paddingTop,
                  left: AppDimension.paddingLeft,
                  right: AppDimension.paddingRight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenTitle(
                      title: "Payment Receipt ID:  ",
                      titleSize: 16.sp,
                      subTitleSize: 12.sp,
                      titleExtension: vm.receiptId,
                      subTitle:
                      "Details of raffle tickets purchased, consisting of all raffle tickets across multiple games. ",
                    ),
                    SizedBox(height: 32.h,),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final orderDetail = vm.orderDetails[index];
                          return PaymentReceiptItem(orderDetail: orderDetail,);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16.h);
                        },
                        itemCount: vm.orderDetails.length,
                      ),
                    ),
                  ],
                ),
              );
            }

            if(vm.state == ViewState.error){
              return Center(
                child: ErrorState(
                  message: vm.message,
                    onPressed: ()=>vm.fetchOrderDetails(orderId: ref.read(paymentViewModel).orderId)
                ),
              );
            }

            return const SizedBox();

          }
        ),
      ),
    );
  }
}
