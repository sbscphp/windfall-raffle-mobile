import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class RenderLottie extends StatelessWidget {
  final BoxFit? fit;
  final double? height;
  final double? width;
  final bool repeat;
  final String lottieAsset;
  final Alignment? alignment;
  const RenderLottie({super.key, this.alignment, required this.lottieAsset, this.repeat = true, this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(lottieAsset,
      fit: fit ?? BoxFit.cover,
      height: height?.h ?? 300.h,
      width: width?.w ?? double.infinity,
      repeat: repeat,
      alignment: alignment

    );
  }
}
