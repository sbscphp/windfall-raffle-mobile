import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  final double? titleSize;
  final double? subTitleSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  const ScreenTitle({super.key, this.titleFontWeight, this.titleColor, this.titleSize, this.subTitleSize, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
              fontWeight: titleFontWeight ?? FontWeight.w700,
              fontSize: titleSize?.sp,
              color: titleColor ?? colorScheme.textPrimary
          ),
        ),
        SizedBox(height: 5.h,),
        Text(
          subTitle,
          style: textTheme.bodyLarge?.copyWith(
              fontSize: subTitleSize?.sp,
              fontWeight: FontWeight.w400,
              color: colorScheme.textSecondary
          ),
        ),
      ],
    );
  }
}
