import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/clickable.dart';

import '../../../core/constants/app_asset.dart';
import '../custom_svg.dart';

class ProfileAction extends StatelessWidget {
  final String imageAsset;
  final String label;
  final VoidCallback onPressed;
  const ProfileAction({super.key, required this.imageAsset, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Clickable(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CustomSvg(asset: imageAsset),
                  SizedBox(width: 16.w,),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w,),
            CustomSvg(asset: AppAsset.rightChevron, height: 22.h, width: 22.w,)
          ],
        ),
      ),
    );
  }
}
