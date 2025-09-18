import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/order_history_vms/order_history_details_vm.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/order_details_item.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart'
    show WindfallContainer;

import '../../../../core/data/enum/tag_type.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../widgets/windfall_tag.dart';

class OrderDetails extends ConsumerStatefulWidget {
  final String? id;
  final String orderId;
  const OrderDetails({super.key, required this.id, required this.orderId});

  @override
  ConsumerState<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends ConsumerState<OrderDetails> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(orderHistoryDetailsViewModel).fetchOrderHistoryDetails(id: widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Order History'),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
        ),
        child: Column(
          children: [
            ScreenTitle(
              title: "Order Details",
              subTitle: "View order details for ${widget.orderId}.",
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: Builder(
                builder: (context) {
                  final vm = ref.watch(orderHistoryDetailsViewModel);

                  if(vm.state == ViewState.busy){
                    return Center(
                      child: AppLoader(),
                    );
                  }

                  if(vm.state == ViewState.retrieved){
                    return ListView(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final orderDetail = vm.orderDetails[index];
                            return OrderDetailsItem(orderDetail: orderDetail);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 16.h);
                          },
                          itemCount: vm.orderDetails.length,
                        ),
                        SizedBox(height: 16.h),
                        //order summary card
                        WindfallContainer(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order Summary",
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: Theme.of(context).colorScheme.brandColor,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              RowDescriptionItem(
                                description: "Status:",
                                fontSize: 14.sp,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                item: WindfallTag(tag: vm.isSuccessful ? TagType.success
                                : vm.isFailed ? TagType.failed : TagType.pending),
                              ),
                              SizedBox(height: 16.h),
                              RowDescriptionItem(
                                description: "Paid Via:",
                                item: Text(
                                  "${Utilities.capitalizeWord(vm.paymentMethod)}",
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.textPrimary,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              RowDescriptionItem(
                                description: "Total Number of Ticket:",
                                item: Text(
                                  "${
                                  Utilities.formatAmount(
                                    amount: vm.totalTicketCount,
                                    addDecimal: false
                                  )
                                  } ${vm.totalTicketCount > 1 ? 'Tickets':'Ticket'}",
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.textPrimary,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              // SizedBox(height: 16.h),
                              // RowDescriptionItem(
                              //   description: "V.A.T:",
                              //   item: Text(
                              //     "0",
                              //     style: Theme.of(context).textTheme.titleLarge
                              //         ?.copyWith(
                              //       fontWeight: FontWeight.w700,
                              //       fontSize: 18.sp,
                              //       color: Theme.of(
                              //         context,
                              //       ).colorScheme.textPrimary,
                              //     ),
                              //     textAlign: TextAlign.end,
                              //   ),
                              // ),
                              SizedBox(height: 16.h),
                              RowDescriptionItem(
                                description: "Total Prices of Ticket:",
                                item: NairaDisplay(
                                  amount: vm.paidAmount,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  addDecimal: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 32.h),
                      ],
                    );
                  }

                  if(vm.state == ViewState.error){
                    return Center(
                      child: ErrorState(
                        message: vm.message,
                          onPressed: ()=>vm.fetchOrderHistoryDetails(id: widget.id)
                      ),
                    );
                  }
                  return const SizedBox();

                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
