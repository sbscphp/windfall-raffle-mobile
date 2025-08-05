import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/home/game_property.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/utilities.dart';
import '../media_placeholder.dart';
import '../naira_display.dart';
import '../screen_title.dart';

class MyGamesSection extends StatelessWidget {
  const MyGamesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 32.h, left: AppDimension.paddingLeft, right: AppDimension.paddingRight),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child:ScreenTitle(
                    title: 'My Games',
                    titleSize: 16,
                    subTitleSize: 14,
                    titleFontWeight: FontWeight.w600,
                    titleColor: Theme.of(context).colorScheme.textPrimary,
                    subTitle: 'Track and Manage games Played'
                ),
              ),
              Clickable(
                onPressed: (){},
                child: Row(
                  children: [
                    Text(
                      "View My Games ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).colorScheme.textTertiary
                      ),
                    ),
                    SizedBox(width: 2.w,),
                    CustomSvg(asset: AppAsset.topRightChevron, height: 16.h, width: 16.w,)
                  ],
                ),
              )

            ],
          ),
        ),
        SizedBox(height: 24.h,),
        SizedBox(
          height: 246.h,
          child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16.w, right: 16.w,),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 191.w,
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 8.w
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.whiteText,
                  border: Border.all(
                    color: ColorPath.athensGrey10,
                    width: 1.w
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8.r))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4.r)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: double.infinity,
                              imageUrl: 'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg',
                              placeholder: (context, url) => const MediaPlaceholder(),
                              errorWidget: (context, url, error) => const MediaPlaceholder(),
                            ),
                          ),
                          Positioned(
                            right: 8.w,
                            top: 10.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                              decoration: BoxDecoration(
                                  color: Utilities.statusContainerColor(status: 'live'),
                                  borderRadius: BorderRadius.all(Radius.circular(16.r))
                              ),
                              child: Text(
                                Utilities.statusText(status: 'Live Game'),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontSize: 9.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Utilities.statusTextColor(status: 'live')
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 6.w,
                            bottom: 13.h,
                            child: ClipRRect( // 💡 Clip here to limit blur area
                              borderRadius: BorderRadius.circular(16.r),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha((255 * 0.3).toInt()),
                                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                                  ),
                                  child: Text(
                                    'Draw: April 11, 2025',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 9.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(height: 12.h,),
                    Text(
                      "Win One Bed Room Flat in Akoka-Yaba, Lagos State, Nigeria",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h,),
                    GameProperty(
                        imageAsset: AppAsset.drawDate,
                        label: 'Draw Date:',
                        value: Expanded(
                          child: Text(
                            "April 11, 2025",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.textSecondary,
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 6.h,),
                    GameProperty(
                        imageAsset: AppAsset.minEntry,
                        label: 'Minimum Entry:',
                        value: Flexible(
                          child: NairaDisplay(
                            amount: 450000,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            addDecimal: false,
                            color: Theme.of(context).colorScheme.textSecondary,
                          ),
                        )
                    ),
                    SizedBox(height: 6.h,),
                    GameProperty(
                        imageAsset: AppAsset.maxPerson,
                        label: 'Max/Person:',
                        value: Expanded(
                          child: Text(
                            "200",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.textSecondary,
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 6.h,),
                    GameProperty(
                        imageAsset: AppAsset.ticketsLeft,
                        label: 'Ticket Left:',
                        value: Expanded(
                          child: Text(
                            "1,000 Tickets",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.textSecondary,
                            ),
                          ),
                        )
                    )

                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 16.w,
              );
            },
          ),
        )

      ],
    );
  }
}
