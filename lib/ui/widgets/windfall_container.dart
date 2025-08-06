import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/color_path.dart';

class WindfallContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? width;
  const WindfallContainer({super.key, required this.child, this.padding, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      padding: padding,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.whiteText,
          border: Border.all(color: ColorPath.athensGrey2, width: 1.w),
          borderRadius: BorderRadius.all(Radius.circular(8.r))
      ),
      child: child,
    );
  }
}
