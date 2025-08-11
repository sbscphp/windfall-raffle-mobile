import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_painter/dotted_border.dart';
import 'custom_svg.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double? buttonWidth;
  final double? buttonHeight;
  final double buttonTextSize;
  final VoidCallback? onPressed;
  final double buttonHorizontalPadding;
  final Color? bgColor;
  final Color? borderColor;
  final Color? buttonTextColor;
  final FontWeight buttonTextFontWeight;
  final Color? disableBgColor;
  final bool showLoader;
  final Widget? childWidget;
  final Color? loaderColor;
  final bool useBorderColor;
  final String? buttonIcon;
  final bool showButtonIcon;
  final bool useDottedBorder;

  const CustomButton({
    super.key,
    this.buttonWidth = double.infinity,
    this.buttonTextFontWeight = FontWeight.w700,
    this.buttonTextSize = 16,
    this.borderColor,
    this.bgColor,
    this.buttonTextColor,
    required this.onPressed,
    this.buttonText = 'Continue',
    this.buttonHeight,
    this.disableBgColor,
    this.showLoader = false,
    this.loaderColor,
    this.childWidget,
    this.useBorderColor = false,
    this.buttonHorizontalPadding = 24,
    this.buttonIcon,
    this.showButtonIcon = false,
    this.useDottedBorder = false
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final height = buttonHeight?.h ?? 52.h;

    final buttonChild = showLoader
        ? Container(
      padding: EdgeInsets.all(6.w),
      height: 30.h,
      width: 30.h,
      child: CircularProgressIndicator(
        color: loaderColor ?? Colors.white,
        strokeWidth: 2,
      ),
    )
        : childWidget ??
        FittedBox(
          child: Row(
            children: [
              Text(
                buttonText,
                style: textTheme.bodyLarge?.copyWith(
                  color: buttonTextColor ??
                      (useBorderColor
                          ? borderColor ?? Colors.grey
                          : colorScheme.whiteText),
                  fontWeight: buttonTextFontWeight,
                  fontSize: buttonTextSize.sp,
                ),
              ),
              if(showButtonIcon)SizedBox(width: 8.w,),
              if(showButtonIcon)CustomSvg(asset: buttonIcon ?? AppAsset.buyNow, height: 18.h, width: 18.w,),
            ],
          ),
        );


    if(useDottedBorder){
      return SizedBox(
        height: height,
        width: buttonWidth,
        child: CustomPaint(
          painter: DottedBorder(
              color: ColorPath.bitterSweetRed,
            borderRadius: BorderRadius.all(Radius.circular(8.r))
          ),
          child: useBorderColor
              ? TextButton(
            onPressed: showLoader ? null : onPressed,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(color: borderColor ?? Colors.grey, width: 1.w),
              ),
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent, // removes splash
              overlayColor: Colors.transparent,
            ),
            child: buttonChild,
          )
              : ElevatedButton(
            onPressed: showLoader ? null : onPressed,
            style: ElevatedButton.styleFrom(
              side: null,
              padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding.w),
              elevation: 0,
              backgroundColor: bgColor ?? colorScheme.brandColor,
              disabledBackgroundColor:
              disableBgColor ?? colorScheme.brandColor.withAlpha((255 * 0.4).toInt()), //todo: update
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: buttonChild,
          ),
        ),
      );
    }



    return SizedBox(
      height: height,
      width: buttonWidth,
      child: useBorderColor
          ? TextButton(
        onPressed: showLoader ? null : onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(color: borderColor ?? Colors.grey, width: 1.w),
          ),
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent, // removes splash
          overlayColor: Colors.transparent,
        ),
        child: buttonChild,
      )
          : ElevatedButton(
        onPressed: showLoader ? null : onPressed,
        style: ElevatedButton.styleFrom(
          side: null,
          padding: EdgeInsets.symmetric(horizontal: buttonHorizontalPadding.w),
          elevation: 0,
          backgroundColor: bgColor ?? colorScheme.brandColor,
          disabledBackgroundColor:
          disableBgColor ?? colorScheme.brandColor.withAlpha((255 * 0.4).toInt()), //todo: update
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: buttonChild,
      ),
    );
  }
}
