import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';


import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'custom_svg.dart';

class EmptyState extends StatelessWidget {
  final String asset;
  final double? assetHeight;
  final double? assetWidth;
  final String title;
  final String subtitle;
  final bool useBgCard;
  final String? ctaText;
  final bool showCtaButton;
  final VoidCallback? onPressed;
  const EmptyState({super.key, this.onPressed, this.showCtaButton = true, this.ctaText, this.assetHeight, this.assetWidth, this.useBgCard = true, required this.asset, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {

    if(useBgCard){
      return WindfallContainer(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSvg(asset: asset, height: assetHeight ?? 40.h, width: assetWidth ?? 40.w,),
              SizedBox(height: 8.h,),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                    fontWeight: FontWeight.w700,
                    color:
                    Theme.of(context).colorScheme.textPrimary),
              ),
              SizedBox(height: 4.h,),
              Text(
                subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                    Theme.of(context).colorScheme.textSecondary),
                textAlign: TextAlign.center,
              ),
              if(showCtaButton)Clickable(
                onPressed: onPressed,
                child: Container(
                  margin: EdgeInsets.only(top: 8.h),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 8.w
                  ),
                  decoration: BoxDecoration(
                    color: ColorPath.chablisPink,
                    borderRadius: BorderRadius.all(Radius.circular(8.r))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ctaText ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: ColorPath.redOrange,
                        ),
                      ),
                      SizedBox(width: 2.w,),
                      CustomSvg(asset: AppAsset.topRightChevron, height: 16.h, width: 16.w,)
                    ],
                  ),
                ),
              )

            ],
          )
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSvg(asset: asset, height: assetHeight ?? 100.h, width:  assetWidth ?? 100.w,),
        SizedBox(height: 16.h,),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(
              fontWeight: FontWeight.w800,
              color:
              Theme.of(context).colorScheme.textPrimary),
        ),
        SizedBox(height: 8.h,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                fontWeight: FontWeight.w400,
                color:
                Theme.of(context).colorScheme.textSecondary),
            textAlign: TextAlign.center,
          ),

        ),
        SizedBox(height: 48.h,),
        if(showCtaButton)
        Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomButton(onPressed: onPressed,
            useDottedBorder: true,
            buttonText: ctaText ?? '',),
          ),

      ],
    );
  }
}
