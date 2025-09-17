import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/app_dimension.dart';
import '../../core/constants/color_path.dart';

class BodyHeader extends StatelessWidget {
  final Widget child;
  final double? verticalPadding;
  const BodyHeader({super.key, required this.child, this.verticalPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding?.h ?? 24.h,
          horizontal: AppDimension.paddingRight
      ),
      decoration: BoxDecoration(
        color:  Theme.of(context).colorScheme.whiteText,
        boxShadow: [
          BoxShadow(
            color: ColorPath.frenchGrey.withAlpha((255 * 0.18).toInt()),
            spreadRadius: 0,
            blurRadius: 200,
            offset: const Offset(0, 100),
          ),
        ],
      ),
      child: child,
    );
  }
}
