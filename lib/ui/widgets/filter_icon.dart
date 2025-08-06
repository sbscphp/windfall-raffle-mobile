import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/ui/widgets/clickable.dart';

import '../../core/constants/app_asset.dart';
import 'custom_svg.dart';

class FilterIcon extends StatelessWidget {
  final VoidCallback onPressed;
  const FilterIcon({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: onPressed,
        child: CustomSvg(asset: AppAsset.filter, height: 32.h, width: 32.w,));
  }
}
