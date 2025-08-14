import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/listview_items/payment_receipt_item.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

class PaymentReceipt extends StatelessWidget {
  const PaymentReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: true,
        title: 'Payment receipt',
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            top: AppDimension.paddingTop,
            bottom: 63.5.h,
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
          ),
          children: [
            ScreenTitle(
              title: "Payment Receipt ID:  ",
              titleSize: 16.sp,
              subTitleSize: 12.sp,
              titleExtension: "9049404GJSB",
              subTitle:
                  "Details of raffle ticket purchased, consisting of all raffle tickets across multiples game. ",
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PaymentReceiptItem();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 16.h);
              },
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }
}
