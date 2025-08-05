import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/color_path.dart';


class CustomDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? verticalSpace;
  final double? bottomMargin;
  final bool equalVerticalSpace;
  const CustomDivider({super.key, this.bottomMargin, this.equalVerticalSpace = true, this.height, this.color, this.verticalSpace});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.h ?? 1.h,
      width: double.infinity,
      color: color ?? ColorPath.athensGrey2,
      margin: equalVerticalSpace ? EdgeInsets.symmetric(vertical: verticalSpace ?? 20.h)
      :EdgeInsets.only(top: verticalSpace ?? 20.h, bottom: bottomMargin?.h ?? 20.h)
    );
  }
}
