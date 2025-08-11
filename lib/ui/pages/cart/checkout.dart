import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/body_header.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/listview_items/cart_item.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: true,
        title: 'Checkout',
      ),
      body: Column(
        children: [
          BodyHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ScreenTitle(
                    title: 'Checkout',
                    titleExtension: ' (0)',
                    titleSize: 16,
                    subTitleSize: 14,
                    titleFontWeight: FontWeight.w600,
                    titleColor: Theme.of(context).colorScheme.textPrimary,
                    subTitle: 'Buy now and stand a chance to win big!!!',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimension.paddingLeft,
                    vertical: 16.h,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CartItem(isShowCounter: false);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                  itemCount: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: WindfallContainer(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Checkout Summary",
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
                            "0 Ticket",
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
                ),

                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimension.paddingLeft,
                  ),
                  child: CustomButton(
                    onPressed: () {
                      // pushNavigation(context: context, widget: Checkout(),routeName: NamedRoutes.checkout);
                    },
                    useDottedBorder: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
