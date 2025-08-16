import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

class FormMediaUploader extends StatelessWidget {
  final String title;
  final String? titleExtension;
  final bool isCompulsory;
  const FormMediaUploader({
    super.key,
    this.title = '',
    this.titleExtension,
    this.isCompulsory = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
            children: [
              if (titleExtension != null)
                TextSpan(
                  text: " $titleExtension",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textSecondary,
                  ),
                ),
              if (isCompulsory)
                TextSpan(
                  text: " *",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: ColorPath.redOrange),
                ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        Clickable(
          onPressed: () {
            // todo::: handle upload here.
          },
          child: WindfallContainer(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                CustomSvg(asset: AppAsset.upload, height: 40.w, width: 40.w),
                SizedBox(height: 12.h),
                Text.rich(
                  textAlign: TextAlign.center,

                  TextSpan(
                    text: "Click to upload \n",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: ColorPath.redOrange,
                      height: 1.5,
                    ),

                    children: [
                      TextSpan(
                        text: "SVG, PNG, JPG or GIF (max. 800x400px)",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}