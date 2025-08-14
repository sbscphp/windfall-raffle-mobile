import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/receipt/payment_receipt.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

class CheckoutSummaryBottomsheet extends StatelessWidget {
  const CheckoutSummaryBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimension.paddingTop,
        horizontal: AppDimension.paddingRight,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WindfallContainer(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Summary",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                    color: Theme.of(context).colorScheme.brandColor,
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Total Number of Ticket:",
                  item: Text(
                    "140 Ticket",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "V.A.T:",
                  item: Text(
                    "0",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Total Prices of Ticket:",
                  item: NairaDisplay(
                    amount: 480000,
                    fontSize: 18,
                    addDecimal: false,
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Promo-Code Applied:",
                  item: Text(
                    "New-Promo-20%",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Amount Deducted:",
                  item: NairaDisplay(
                    amount: 10000,
                    fontSize: 18,
                    addDecimal: false,
                    color: Theme.of(context).colorScheme.brandColor,
                    showPrefixSign: true,
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Amount Payable:",
                  item: NairaDisplay(
                    amount: 4700000,
                    fontSize: 18,
                    addDecimal: false,
                    // color: Theme.of(context).colorScheme.brandColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          CustomButton(
            onPressed: () {
              popNavigation(context: context);
              pushNavigation(
                context: context,
                widget: PaymentReceipt(),
                routeName: NamedRoutes.paymentReceipt,
              );
            },
            buttonText: "Go to Payment (₦470,000)",
            useDottedBorder: true,
          ),
        ],
      ),
    );
  }
}
