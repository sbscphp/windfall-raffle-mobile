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

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: () {
        pushNavigation(
          context: context,
          widget: OrderDetails(),
          routeName: NamedRoutes.orderDetails,
        );
      },
      child: WindfallContainer(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
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
                        text: '#ORD-099618',
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
                        text: DateUtilities.monthDayYear(date: DateTime.now()),
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
                        text: '4 Games . 100 Tickets',
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
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                WindfallTag(tag: TagType.success),
                SizedBox(height: 8.h),
                NairaDisplay(
                  amount: 200000,
                  addDecimal: false,
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
