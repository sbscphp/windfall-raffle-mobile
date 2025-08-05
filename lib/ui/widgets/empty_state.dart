import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';


import 'custom_svg.dart';

class EmptyState extends StatelessWidget {
  final String asset;
  final String title;
  final String subtitle;
  const EmptyState({super.key, required this.asset, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSvg(asset: asset, height: 100.h, width: 100.w,),
        SizedBox(height: 8.h,),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(
              fontWeight: FontWeight.w800,
              color:
              Theme.of(context).colorScheme.textPrimary),
        ),
        SizedBox(height: 8.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 59.w),
          child: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
                fontWeight: FontWeight.w500,
                color:
                Theme.of(context).colorScheme.textPrimary),
            textAlign: TextAlign.center,
          ),

        ),

      ],
    );
  }
}
