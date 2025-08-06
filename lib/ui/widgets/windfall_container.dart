import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/color_path.dart';

class WindfallContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const WindfallContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorPath.athensGrey2, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(8.r))
      ),
      child: child,
    );
  }
}
