import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/cart/row_description_item.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/dotted_container.dart';

class ClaimSuccessfulBottomsheet extends StatelessWidget {
  const ClaimSuccessfulBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAssetViewer(
            asset: AppAsset.successImg,
            height: 120.h,
            width: 120.h,
          ),
          SizedBox(height: 24.h),
          Text(
            "Claim Successfully Submitted",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8.h),
          Text(
            "Your prize claim for 3 bedroom duplex has been submitted. Our team will review it shortly.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          DottedContainer(
            padding: EdgeInsets.all(16.w),
            borderRadius: 8,
            decoration: BoxDecoration(
              color: ColorPath.fairPink,
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
            ),
            child: Column(
              children: [
                RowDescriptionItem(
                  description: "Claim Reference ID",
                  fontSize: 14.sp,
                  item: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 15.w),
                      Text("WF 092830"),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Est. Processing Time",
                  fontSize: 14.sp,
                  item: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 15.w),
                      Text("2-5 Business days"),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                RowDescriptionItem(
                  description: "Claim Status",
                  fontSize: 14.sp,
                  item: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 15.w),
                      Text("Under Review"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text.rich(
            TextSpan(
              text: "If you need help, Contact Us at",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              children: [
                TextSpan(
                  text: " support@windfall.ng",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: ColorPath.redOrange),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          CustomButton(
            onPressed: () {},
            useDottedBorder: true,
            buttonText: "Continue to Home",
          ),
        ],
      ),
    );
  }
}
