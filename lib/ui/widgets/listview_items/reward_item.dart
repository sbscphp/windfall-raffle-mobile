import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/utilities/date_utilitites.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

class RewardItem extends StatelessWidget {
  final String? rewardData;
  final DateTime? date;
  final double? amount;
  final int? point;
  const RewardItem({
    super.key,
    this.amount,
    this.date,
    this.point,
    this.rewardData,
  });

  @override
  Widget build(BuildContext context) {
    return WindfallContainer(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rewardData ?? 'N/A',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12.h),
              Text.rich(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.textSecondary,
                ),
                TextSpan(
                  text: "Draw Date: ",
                  children: [
                    TextSpan(
                      text: DateUtilities.monthDayYear(
                        date: date ?? DateTime.now(),
                      ),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 18.w),
          if (amount != null && point == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 2.h,
                  ),
                  margin: EdgeInsets.only(top: 4.h),
                  decoration: BoxDecoration(
                    color: ColorPath.foamGreen,
                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                  ),
                  child: Center(
                    child: Text(
                      "Successful",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: ColorPath.funGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                NairaDisplay(
                  amount: 2000,
                  addDecimal: false,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          if (point != null && amount == null)
            Text(
              "${point}pts",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
        ],
      ),
    );
  }
}