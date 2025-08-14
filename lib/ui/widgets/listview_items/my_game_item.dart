import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/my_games/game_tickets.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/color_path.dart';
import '../media_placeholder.dart';

class MyGameItem extends StatelessWidget {
  const MyGameItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: (){
        pushNavigation(context: context, widget: const GameTickets(), routeName: NamedRoutes.gameTickets);
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: 1 + 1 == 3 ? Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: ColorPath.frondGreen,
                        border: Border.all(color: Colors.white, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Text(
                        'Draw Completed: Check Result',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ):Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: ColorPath.meadowGreen,
                        border: Border.all(color: Colors.white, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Text(
                        'Draw Date: 03/06/2025',
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
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Game 1",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 5.h,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Claim a 3-Bedroom House in Ikeja, Lagos State, Nigeria",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 5.h,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Take part for a chance to win an apartment",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.text5,
                ),
                textAlign: TextAlign.center,
              ),
            )

          ],
        ),
      ),
    );
  }
}
