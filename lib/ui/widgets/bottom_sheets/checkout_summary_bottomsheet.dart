import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/payment_vms/payment_vm.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/select_payment_method.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../../core/utilities/utilities.dart';

class CheckoutSummaryBottomSheet extends ConsumerWidget {
  const CheckoutSummaryBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(paymentViewModel);
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
                    "${vm.totalTicketCount} ${vm.totalTicketCount > 1 ? 'Tickets':'Ticket'}",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // SizedBox(height: 16.h),
                // RowDescriptionItem(
                //   description: "V.A.T:",
                //   item: Text(
                //     "0",
                //     style: Theme.of(context).textTheme.titleSmall?.copyWith(
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Total Prices of Ticket:",
                  item: NairaDisplay(
                    amount: vm.totalAmount,
                    fontSize: 18,
                    addDecimal: true,
                  ),
                ),
                if(vm.promoCode != null)Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: RowDescriptionItem(
                    description: "Promo-Code Applied:",
                    item: Text(
                      vm.promoCode ?? 'N/A',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if(vm.discountAmount > 0)Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: RowDescriptionItem(
                    description: "Amount Deducted:",
                    item: NairaDisplay(
                      amount: vm.discountAmount,
                      fontSize: 18,
                      addDecimal: true,
                      color: Theme.of(context).colorScheme.brandColor,
                      showPrefixSign: true,
                    ),
                  ),
                ),
                if(vm.referralAmount > 0) Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: RowDescriptionItem(
                    description: "Referral Amount Used:",
                    item: NairaDisplay(
                      amount: vm.referralAmount,
                      fontSize: 18,
                      addDecimal: true,
                      color: Theme.of(context).colorScheme.brandColor,
                      showPrefixSign: true,
                    ),
                  ),
                ),
                if(vm.promoAmount > 0)Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: RowDescriptionItem(
                    description: "Promo Amount:",
                    item: NairaDisplay(
                      amount: vm.promoAmount,
                      fontSize: 18,
                      addDecimal: true,
                      color: Theme.of(context).colorScheme.brandColor,
                      showPrefixSign: true,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Amount Payable:",
                  item: NairaDisplay(
                    amount: vm.amountToPay,
                    fontSize: 18,
                    addDecimal: true,
                    // color: Theme.of(context).colorScheme.brandColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          CustomButton(
            onPressed: () {
              pushNavigation(
                context: context,
                widget: SelectPaymentMethod(),
                routeName: NamedRoutes.selectPaymentMethod,
              );
            },
            buttonText: "Go to Payment (₦${Utilities.formatAmount(
              addDecimal: true,
              amount: vm.amountToPay
            )})",
            useDottedBorder: true,
          ),
        ],
      ),
    );
  }
}
