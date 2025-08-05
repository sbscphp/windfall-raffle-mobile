import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_path.dart';


class CustomProgressBar extends CustomPainter{

  final Color? activeColor;
  final double? percentage;
  final double strokeWidth;
  final Color backgroundColor;


  CustomProgressBar({this.strokeWidth = 12, this.activeColor = ColorPath.redOrange, this.percentage = 0, this.backgroundColor = ColorPath.athensGrey});


  @override
  void paint(Canvas canvas, Size size) {

    final backgroundPaint = Paint();
    backgroundPaint.color = backgroundColor;
    backgroundPaint.strokeWidth = strokeWidth.w;
    backgroundPaint.strokeCap = StrokeCap.round;
    backgroundPaint.style = PaintingStyle.stroke;

    final foregroundPaint = Paint();
    foregroundPaint.color = activeColor!;
    foregroundPaint.strokeWidth = strokeWidth.w;
    foregroundPaint.strokeCap = StrokeCap.round;
    foregroundPaint.style = PaintingStyle.stroke;


    canvas.drawLine(Offset.zero, Offset(size.width, 0), backgroundPaint);
    if (percentage! > 0) {
      canvas.drawLine(Offset.zero, Offset(size.width * percentage!, 0),
          foregroundPaint);
    }
    //canvas.drawLine(Offset.zero, Offset(size.width / progress, 0), foregroundPaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}