import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/color_path.dart';
import 'custom_painter/dotted_border.dart';


class DottedContainer extends StatelessWidget {
  final Widget child;
  final Color? borderColor;
  final Color? bgColor;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final  double? borderRadius;
  const DottedContainer({super.key, this.borderRadius, required this.child, this.borderColor, this.bgColor, this.padding, this.decoration});

  @override
  Widget build(BuildContext context) {
    return  CustomPaint(
      painter: DottedBorder(
          color: borderColor ?? ColorPath.redOrange,
          borderRadius: borderRadius == null ? BorderRadius.zero:BorderRadius.all(Radius.circular(borderRadius!.r))
      ),
      child: Container(
        color: decoration != null ? null : bgColor,
        padding: padding,
        decoration: decoration,
        child: child,
      ),
    );
  }
}
