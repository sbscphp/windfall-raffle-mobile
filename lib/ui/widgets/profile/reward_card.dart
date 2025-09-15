import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/data/view_models/referral_vm.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/dotted_container.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/show_flush_bar.dart';

import '../../../core/data/enum/view_state.dart';

class RewardCard extends StatelessWidget {
  final ReferralVm vm;
  const RewardCard({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return DottedContainer(
      padding: EdgeInsets.all(16.w),
      borderRadius: 8,
      decoration: BoxDecoration(
        color: ColorPath.fairPink,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Referral Balance ",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.textTertiary,
                ),
              ),
              SizedBox(height: 8.h),
              if(vm.state == ViewState.busy)
                SizedBox(
                  height: 15.h,
                  width: 15.w,
                  child: CircularProgressIndicator(
                    color: ColorPath.redOrange,
                  ),
                )
                else NairaDisplay(
                amount: vm.referralBalance,
                color: ColorPath.redOrange,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Clickable(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: vm.referralCode));
                  showFlushBar(
                    context: context,
                    message: "Copied referral code to Clip Board",
                  );
                },
                child: Row(
                  children: [
                    Text(vm.referralCode,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                    SizedBox(width: 8),
                    CustomSvg(
                      asset: AppAsset.copy,
                      height: 18,
                      width: 18,
                      colorFilter: ColorFilter.mode(
                        ColorPath.redOrange,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Your referral code",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}