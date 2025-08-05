import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/color_path.dart';

class LgbtqContainer extends StatelessWidget {
  final bool showPadding;
  final Widget child;
  final double? borderRadius;
  const LgbtqContainer({super.key, required this.child, this.showPadding = true, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: showPadding ? 2.h:0, horizontal: showPadding ? 2.w:0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius?.r ?? 8.r)),
        gradient: const LinearGradient(
          colors: [
            Colors.red
            //todo: add colors
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius?.r ?? 8.r)),
          child: child),
    );
  }
}
