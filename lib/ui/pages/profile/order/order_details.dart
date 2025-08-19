import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/listview_items/order_details_item.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart'
    show WindfallContainer;

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
              subTitle: "View order details for #ORD-099618.",
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: ListView(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return OrderDeatilsItem(isLiveGame: index % 2 == 0);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16.h);
                    },
                    itemCount: 3,
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
                          description: "Total Number of Ticket:",
                          item: Text(
                            "100 Tickets",
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
                          description: "V.A.T:",
                          item: Text(
                            "0",
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
                          description: "Total Prices of Ticket:",
                          item: NairaDisplay(
                            amount: 480000,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            addDecimal: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
