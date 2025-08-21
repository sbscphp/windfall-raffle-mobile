import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/dotted_container.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/show_flush_bar.dart';

class RewardCard extends StatelessWidget {
  final String referralCode;
  const RewardCard({super.key, this.referralCode = ''});

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
              NairaDisplay(
                amount: 101200,
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
                  Clipboard.setData(ClipboardData(text: referralCode));
                  showFlushBar(
                    context: context,
                    message: "Copied referral code to Clip Board",
                  );
                },
                child: Row(
                  children: [
                    Text(referralCode),
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