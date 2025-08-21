import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../custom_expansion_tile.dart';
import '../custom_svg.dart';
import '../custom_text_field.dart';
import '../dotted_container.dart';
import '../media_placeholder.dart';
import '../naira_display.dart';

class InstantGameItem extends StatelessWidget {
  const InstantGameItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      initiallyExpanded: false,
      primaryChild: Row(
        children: [
          Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
                border: Border.all(color: ColorPath.redOrange, width: 2.w),
                borderRadius: BorderRadius.all(Radius.circular(8.r))
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: double.infinity,
                imageUrl: 'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg',
                placeholder: (context, url) => const MediaPlaceholder(),
                errorWidget: (context, url, error) => const MediaPlaceholder(),
              ),
            ),
          ),
          SizedBox(width: 16.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: NairaDisplay(
                        amount: 4500,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        addDecimal: false,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                    Text(
                      " Cash Prize",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSvg(asset: AppAsset.gift, height: 16.h, width: 16.w,),
                    SizedBox(width: 8.w,),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.textSecondary
                          ),
                          children: [
                            const TextSpan(
                              text: '38/40',
                            ),
                            TextSpan(
                              text: ' Units to be Won',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textSecondary
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
      secondaryChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            label: '',
            showLabel: false,
            hintText: 'Search',
            //controller: _loginChoice,
            keyboardType: TextInputType.text,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: CustomSvg(
                asset:AppAsset.search,
                height: 20.h,
                width: 20.w,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.textFieldSuffixIcon,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h,),
          GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24.h,
                crossAxisSpacing: 24.w,
                mainAxisExtent: 68.h,
              ),
              itemBuilder: (BuildContext context, int index) {
                return DottedContainer(
                    borderColor: ColorPath.mistGrey,
                    borderRadius: 8,
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                          decoration: BoxDecoration(
                              color: ColorPath.scandalGreen,
                              borderRadius: BorderRadius.all(Radius.circular(16.r))
                          ),
                          child: Text(
                            'Already Won',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorPath.hazeGreen
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h,),
                        Text(
                          '#WF100423X8',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.textTertiary
                          ),
                        ),

                      ],
                    )
                );
              })

        ],
      ),
    );
  }
}
