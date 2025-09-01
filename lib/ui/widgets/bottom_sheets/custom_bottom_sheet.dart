import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart' show AppDimension;
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String subTitle;
  final String firstbuttonText;
  final String secondButtonText;
  final Widget asset;
  final VoidCallback? firstButtonOnPressed;
  final VoidCallback? secondButtonOnPressed;
  final bool showSecondButton;
  const CustomBottomSheet({
    super.key,
    required this.title,
    this.subTitle = '',
    required this.firstbuttonText,
    this.secondButtonText = '',
    required this.asset,
    this.firstButtonOnPressed,
    this.secondButtonOnPressed,
    this.showSecondButton = true,
  });

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
          asset,
          SizedBox(height: 24.h),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 8.h),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.textSecondary,
            ),
          ),
          SizedBox(height: 32.h),
          CustomButton(
            onPressed: firstButtonOnPressed ?? () {},
            buttonText: firstbuttonText,
            useDottedBorder: true,
          ),
          if (showSecondButton)
            Column(
              children: [
                SizedBox(height: 16.h),
                CustomButton(
                  onPressed: secondButtonOnPressed ?? () {},
                  buttonText: secondButtonText,
                  bgColor: ColorPath.blackyBlack,
                  useDottedBorder: true,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
