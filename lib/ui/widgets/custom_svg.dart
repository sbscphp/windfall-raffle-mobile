import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  final ColorFilter? colorFilter;
  final BoxFit? fit;
  const CustomSvg({super.key, this.fit, this.colorFilter, required this.asset, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      height: height?.h ?? 24.h,
      width: width?.w ?? 24.w,
      fit: fit ?? BoxFit.cover,
      colorFilter: colorFilter,
    ); 
  }
}

class CustomAssetViewer extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  final ColorFilter? colorFilter;
  const CustomAssetViewer({
    super.key,
    required this.asset,
    this.height,
    this.width,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return isSvg()
        ? CustomSvg(
            asset: asset,
            height: height,
            width: width,
            colorFilter: colorFilter,
          )
        : Image.asset(
            asset,
            height: height?.h ?? 24.h,
            width: width?.w ?? 24.w,
          );
  }

  bool isSvg() => asset.endsWith('.svg');
}
