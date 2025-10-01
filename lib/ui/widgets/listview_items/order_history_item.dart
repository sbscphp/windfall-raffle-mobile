import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/date_utilitites.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/profile/order/order_details.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import 'package:windfall/ui/widgets/windfall_tag.dart';

import '../../../core/data/enum/tag_type.dart';
import '../../../core/data/models/order.dart';
import '../../../core/utilities/utilities.dart';

class OrderHistoryItem extends StatelessWidget {
  final Order order;
  const OrderHistoryItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final orderId = order.uniqueId ?? 'N/A';
    final orderDate = DateUtilities.monthDayYear(date: order.createdAt ?? DateTime.now());
    final totalTicketCount = double.tryParse(order.ticketsCount?.toString() ?? "0") ?? 0;
    final paidAmount = double.tryParse(order.paidAmount?.toString() ?? '0') ?? 0;
    final gameCount = double.tryParse(order.gamesCount?.toString() ?? '0') ?? 0;
    final status = order.paymentStatus ?? 'N/A';
    final isSuccessful = status.toLowerCase() == 'successful';
    final isFailed = status.toLowerCase() == 'failed';
    return Clickable(
      onPressed: () {
        pushNavigation(
          context: context,
          widget: OrderDetails(
            id: order.uuid,
            orderId: orderId,
          ),
          routeName: NamedRoutes.orderDetails,
        );
      },
      child: WindfallContainer(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.textPrimary,
                    ),
                    TextSpan(
                      text: "Order ID: ",
                      children: [
                        TextSpan(
                          text: orderId,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.brandColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text.rich(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.textTertiary,
                    ),
                    TextSpan(
                      text: "Date Ordered: ",
                      children: [
                        TextSpan(
                          text: orderDate,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text.rich(
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.textTertiary,
                    ),
                    TextSpan(
                      text: "Qty: ",
                      children: [
                        TextSpan(
                          text: '${Utilities.formatAmount(
                            amount: gameCount,
                            addDecimal: false
                          )} ${gameCount > 1 ? 'Games':'Game'} . ${Utilities.formatAmount(
                              amount: totalTicketCount,
                              addDecimal: false
                          )} ${totalTicketCount > 1 ? 'Tickets':'Ticket'}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                WindfallTag(tag: isSuccessful ? TagType.success
                : isFailed ? TagType.failed : TagType.pending),
                SizedBox(height: 8.h),
                NairaDisplay(
                  amount: paidAmount,
                  addDecimal: true,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
