import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/data/view_models/checkout_vm.dart';
import 'package:windfall/core/utilities/utilities.dart';
import 'package:windfall/ui/widgets/body_header.dart';
import 'package:windfall/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:windfall/ui/widgets/bottom_sheets/checkout_summary_bottomsheet.dart';
import 'package:windfall/ui/widgets/cart/column_description_item.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/custom_text_field.dart';
import 'package:windfall/ui/widgets/listview_items/cart_item.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

class Checkout extends ConsumerStatefulWidget {
  const Checkout({super.key});

  @override
  ConsumerState<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends ConsumerState<Checkout> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(checkoutViewModel);
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
                    titleExtension: ' (${vm.checkoutCount})',
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
                    final checkoutItem = vm.checkoutItems[index];
                    return CartItem(isShowCounter: false, item: checkoutItem,);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16.h);
                  },
                  itemCount: vm.checkoutCount,
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
                            "${Utilities.formatAmount(
                              amount: vm.totalTicketCount.toDouble(),
                              addDecimal: false
                            )} ${vm.totalTicketCount > 1 ? 'Tickets':'Ticket'}",
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
                        //           fontWeight: FontWeight.w700,
                        //           fontSize: 18.sp,
                        //           color: Theme.of(
                        //             context,
                        //           ).colorScheme.textPrimary,
                        //         ),
                        //     textAlign: TextAlign.end,
                        //   ),
                        // ),
                        SizedBox(height: 16.h),
                        RowDescriptionItem(
                          description: "Total Prices of Ticket:",
                          item: NairaDisplay(
                            amount: vm.totalPrice,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            addDecimal: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: WindfallContainer(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Use Promo Code",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: Theme.of(context).colorScheme.brandColor,
                              ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(
                                "Promo-Code",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.textSecondary,
                                    ),
                              ),
                            ),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: CustomTextField(
                                hintText: "Enter Promo Code",
                                isCompulsory: false,
                                bottomHintText:
                                    "Enter promo-code for discount.",
                                bottomHintColor: 1 + 1 == 2
                                    ? null
                                    : ColorPath.hazeGreen,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ColumnDescriptionItem(
                                description: "Referral Balance",
                                item: NairaDisplay(
                                  amount: 20000,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  // addDecimal: false,
                                ),
                              ),
                            ),
                            SizedBox(width: 18.w),
                            Expanded(
                              child: CustomTextField(
                                hintText: "0",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Text(
                                    Utilities.nairaSign,
                                    style: Theme.of(context).textTheme.bodyMedium
                                        ?.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.textPrimary,
                                        ),
                                  ),
                                ),
                                isCompulsory: false,
                                bottomHintText: "Enter value to pay with. ",
                                bottomHintColor: 1 + 1 == 2
                                    ? null
                                    : ColorPath.hazeGreen,
                              ),
                            ),
                          ],
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
                       baseBottomSheet(
                        context: context,
                        content: CheckoutSummaryBottomsheet()
                    );
                    },
                    useDottedBorder: true,
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
