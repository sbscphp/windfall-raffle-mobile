import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';


class CountdownCircle extends StatelessWidget {
  final String label;
  final String value;
  const CountdownCircle({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 42.74.h,
      width: 42.74.w,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.blackText.withAlpha((255 * 0.7).toInt()),
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          //border: Border.all(color: ColorPath.ribbonRed2, width: 1.w)
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600,
                      color:Theme.of(context).colorScheme.whiteText
                  ),
                ),
                SizedBox(height: 2.h,),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                      fontWeight: FontWeight.w800,
                      color:Theme.of(context).colorScheme.whiteText
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
