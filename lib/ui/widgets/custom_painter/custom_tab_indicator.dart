import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabIndicator extends Decoration {
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomTabIndicatorPainter();
  }
}

class _CustomTabIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    final Rect rect = Offset(offset.dx, offset.dy) & Size(configuration.size!.width, configuration.size!.height);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(3.r));
    canvas.drawRRect(rRect, paint);
  }
}