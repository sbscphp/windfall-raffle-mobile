import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import '../custom_button.dart';


class ErrorDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final String buttonText;
  const ErrorDialog({super.key, required this.title, required this.subtitle, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppDimension.paddingTop,
          horizontal: AppDimension.bottomSheetPaddingRight
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color:colorScheme.text6,
            ),
          ),
          SizedBox(height: 8.h,),
          Text(
            subtitle,
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color:colorScheme.text7,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h,),
          CustomButton(
              useDottedBorder: true,
              buttonText:buttonText,
              onPressed: onPressed
          ),



        ],
      ),
    );
  }
}
