import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/models/referral.dart';
import 'package:windfall/core/utilities/date_utilitites.dart';
import 'package:windfall/ui/widgets/naira_display.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import 'package:windfall/ui/widgets/windfall_tag.dart';

import '../../../core/data/enum/tag_type.dart';

class RewardItem extends StatelessWidget {
  final Referral referral;
  final bool isEarned;
  const RewardItem({
    super.key,
    required this.referral,
    this.isEarned = true
  });

  @override
  Widget build(BuildContext context) {
    final firstName = referral.referredUser?.firstname ?? 'N/A';
    final lastName = referral.referredUser?.lastname ?? 'N/A';
    final id = referral.order?.uniqueId ?? 'N/A';
    final amount = double.tryParse(referral.amount?.toString() ?? '0') ?? 0;
    final date = DateUtilities.monthDayYear(date: referral.date ?? DateTime.now());
    final status = referral.status ?? 'N/A';
    final isSuccessTag = status.toLowerCase() == 'awarded';
    final reason = referral.reason ?? 'N/A';


    return WindfallContainer(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isEarned ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$firstName $lastName',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8.h),
              Text.rich(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.textSecondary,
                ),
                TextSpan(
                  text: "Date: ",
                  children: [
                    TextSpan(
                      text: date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '$reason',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          )
              :Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction ID',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.text7
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                id,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
              ),
              SizedBox(height: 8.h),
              Text.rich(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.textSecondary,
                ),
                TextSpan(
                  text: "Date: ",
                  children: [
                    TextSpan(
                      text: date,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if(isEarned)Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: WindfallTag(tag: isSuccessTag ? TagType.success:TagType.pending),
                ),
                NairaDisplay(
                  amount: amount,
                  addDecimal: false,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
        ],
      ),
    );
  }
}