import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color_path.dart';




class CustomDot extends StatelessWidget{

  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final Color borderColor;
  final double? height;
  final double? width;
  final bool useRoundCircles;

  const CustomDot({super.key, this.useRoundCircles = false, this.height, this.width, this.borderColor = Colors.white, this.isActive = true, this.activeColor = ColorPath.redOrange, this.inactiveColor = ColorPath.redOrange});

  @override
  Widget build(BuildContext context) {

    if(useRoundCircles){
      return AnimatedContainer(
        margin: EdgeInsets.only(right: 5.w),
        duration: const Duration(microseconds: 1),
        height: height?.h ?? 18.h,
        width: width?.w ?? 18.w,   //45
        decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            shape: BoxShape.circle
        ),
      );
    }

    return AnimatedContainer(
      margin: EdgeInsets.only(right: 2.w),
      duration: const Duration(microseconds: 1),
      height: height?.h ?? 4.h,
      width: width?.w ?? (isActive ? 20.w:8.w),   //45
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        borderRadius: BorderRadius.all(Radius.circular(100.r))
      ),
    );
  }


}