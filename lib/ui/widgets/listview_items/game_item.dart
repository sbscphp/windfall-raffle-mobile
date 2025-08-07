import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/game_details.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/utilities/utilities.dart';
import '../home/game_property.dart';
import '../media_placeholder.dart';
import '../naira_display.dart';

class GameItem extends StatelessWidget {
  const GameItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: (){
        pushNavigation(context: context, widget: const GameDetails(), routeName: NamedRoutes.gameDetails);
      },
      child: WindfallContainer(
        width: 191.w,
        padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 8.w
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
      ),
    );
  }
}
