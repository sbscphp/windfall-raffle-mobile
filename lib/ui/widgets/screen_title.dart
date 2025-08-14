import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String? titleExtension;
  final String subTitle;
  final double? titleSize;
  final double? subTitleSize;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? titleExtensionColor;
  final FontWeight? titleFontWeight;
  final FontWeight? subTitleFontWeight;
  final FontWeight? titleExtensionFontWeight;
  const ScreenTitle({super.key, this.subTitleColor, this.subTitleFontWeight, this.titleFontWeight, this.titleColor, this.titleSize, this.subTitleSize, required this.title, required this.subTitle,this.titleExtension,this.titleExtensionColor, this.titleExtensionFontWeight});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                  fontWeight: titleFontWeight ?? FontWeight.w700,
                  fontSize: titleSize?.sp,
                  color: titleColor ?? colorScheme.textPrimary
              ),
            ),
             Text(
              titleExtension ?? '',
              style: textTheme.titleMedium?.copyWith(
                  fontWeight: titleExtensionFontWeight ?? FontWeight.w700,
                  fontSize: titleSize?.sp,
                  color: titleExtensionColor ?? colorScheme.brandColor
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h,),
        Text(
          subTitle,
          style: textTheme.bodyLarge?.copyWith(
              fontSize: subTitleSize?.sp,
              fontWeight: subTitleFontWeight ?? FontWeight.w400,
              color: subTitleColor ?? colorScheme.textSecondary
          ),
        ),
      ],
    );
  }
}
