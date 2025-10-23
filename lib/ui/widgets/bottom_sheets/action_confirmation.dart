import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/utilities/extensions/color_extensions.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/navigator.dart';
import '../custom_button.dart';
import '../custom_svg.dart';

class ActionConfirmation extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? cancelBtnText;
  final String? proceedBtnText;
  final VoidCallback onPressed;
  final Color? proceedBtnColor;
  const ActionConfirmation({super.key, this.proceedBtnColor, this.subtitle, required this.title, this.cancelBtnText, this.proceedBtnText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppDimension.paddingTop,
        horizontal: AppDimension.bottomSheetPaddingLeft
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAssetViewer(asset: AppAsset.alert, height: 56.h, width: 56.w,
              colorFilter: proceedBtnColor != null ? ColorFilter.mode(
                proceedBtnColor!,
                BlendMode.srcIn,
              ):null,
          ),
          SizedBox(height: 16.h,),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.blackText.withCustomOpacity(0.85),
            ),
            textAlign: TextAlign.center,
          ),
          if(subtitle != null)Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              subtitle ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.blackText.withCustomOpacity(0.85),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 24.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                    buttonHeight: 40,
                    useBorderColor: true,
                    borderColor: ColorPath.altoGrey,
                    buttonText: cancelBtnText ?? 'No',
                    buttonTextColor: Theme.of(context).colorScheme.blackText.withCustomOpacity(0.85),
                    onPressed: ()=>popNavigation(context: context)
                ),
              ),
              SizedBox(width: 8.w,),
              Expanded(
                child: CustomButton(
                    buttonHeight: 40,
                    bgColor: proceedBtnColor ?? ColorPath.redOrange,
                    buttonText: proceedBtnText ?? 'Yes, continue',
                    buttonTextColor: Colors.white,
                    onPressed: (){
                      popNavigation(context: context);
                      onPressed();
                    }
                ),
              )

            ],
          )

        ],
      ),
    );
  }
}
