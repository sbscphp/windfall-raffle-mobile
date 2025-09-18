import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/data/models/order_detail.dart';
import 'package:windfall/core/data/view_models/order_history_vms/order_history_details_vm.dart';
import 'package:windfall/core/utilities/date_utilitites.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import 'package:windfall/ui/widgets/windfall_tag.dart';

import '../../../core/data/enum/tag_type.dart';
import '../../../core/utilities/utilities.dart';

class OrderDetailsItem extends StatelessWidget {
  final OrderDetail orderDetail;
  const OrderDetailsItem({super.key, required this.orderDetail});

  @override
  Widget build(BuildContext context) {
    final isInstantGame = orderDetail.game?.instantGame?.toLowerCase() == 'true';
    final name = orderDetail.game?.name ?? 'N/A';
    final ticketCount = double.tryParse(orderDetail.quantity?.toString() ?? '0') ?? 0;
    final date = DateUtilities.monthDayYear(date: orderDetail.createdAt ?? DateTime.now());
    final unitPrice = double.tryParse(orderDetail.unitAmount?.toString() ?? '0') ?? 0;
    final paidAmount = double.tryParse(orderDetail.paidAmount?.toString() ?? '0') ?? 0;
    final discountAmount = double.tryParse(orderDetail.discountAmount?.toString() ?? '0') ?? 0;
    return WindfallContainer(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          RowDescriptionItem(
            description: "Game Type:",
            fontSize: 14.sp,
            item: WindfallTag(
              tag: isInstantGame ? TagType.instantGame : TagType.drawGame,
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Game Name:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(
                    name,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "No of Tickets Bought:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                Flexible(child: Text("${Utilities.formatAmount(
                  amount: ticketCount,
                  addDecimal: false
                )}", textAlign: TextAlign.end)),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Order Date:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(
                    date,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Unit Price:",
            fontSize: 14.sp,

            item: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 16.w),
                NairaDisplay(
                  amount: unitPrice,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
          if(discountAmount > 0)Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: RowDescriptionItem(
              description: "Discount Amount:",
              fontSize: 14.sp,

              item: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 16.w),
                  NairaDisplay(
                    amount: discountAmount,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 16.h),
          // RowDescriptionItem(
          //   description: "Paid Via:",
          //   fontSize: 14.sp,
          //
          //   item: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       SizedBox(width: 16.w),
          //       Flexible(child: Consumer(
          //         builder: (context, ref, child){
          //           final vm = ref.read(orderHistoryDetailsViewModel);
          //           return Text(Utilities.capitalizeWord(vm.paymentMethod), textAlign: TextAlign.end);
          //         },)),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 16.h),
          // RowDescriptionItem(
          //   description: "Status:",
          //   fontSize: 14.sp,
          //   item: WindfallTag(tag: TagType.completed),
          // ),
          SizedBox(height: 16.h),
          RowDescriptionItem(
            description: "Subtotal:",
            fontSize: 16.sp,
            item: NairaDisplay(
              amount: paidAmount,
              fontSize: 18.sp,
              color: ColorPath.redOrange,
              addDecimal: true,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
