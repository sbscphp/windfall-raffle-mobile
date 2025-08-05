import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/app_asset.dart';
import '../custom_svg.dart';

class GameProperty extends StatelessWidget {
  final String imageAsset;
  final String label;
  final Widget value;
  const GameProperty({super.key, required this.imageAsset, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSvg(asset: imageAsset, height: 12.h, width: 12.w,),
        SizedBox(width: 4.w,),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.text5,
          ),
        ),
        SizedBox(width: 4.w,),
        value
      ],
    );
  }
}
