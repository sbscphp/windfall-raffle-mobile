import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/app_asset.dart';
import 'custom_svg.dart';


class MediaPlaceholder extends StatelessWidget {
  final double? size;
  const MediaPlaceholder({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.brandColor,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.contain,
            //child: CustomSvg(asset: AppAsset.logo, height: size, width: size,)
        ),
      ),
    );

  }
}
