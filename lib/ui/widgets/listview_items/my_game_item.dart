import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/models/my_game.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/my_games/game_tickets.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/color_path.dart';
import '../media_placeholder.dart';

class MyGameItem extends StatelessWidget {
  final MyGame myGame;
  const MyGameItem({super.key, required this.myGame});

  @override
  Widget build(BuildContext context) {
    final image = myGame.game?.cardImage ?? '';
    final name = myGame.game?.name ?? 'N/A';
    final description = myGame.game?.description ?? 'N/A';
    final status = myGame.game?.mainActiveStatus ?? '';
    final isInstantGame = myGame.game?.instantGame?.toLowerCase() == 'true';
    final isInView = status.toLowerCase() == 'upcoming';
    final isOngoing = status.toLowerCase() == 'live';
    final isEnded = status.toLowerCase() == 'ended';
    final drawDate = myGame.game?.drawDate ?? DateTime.now();
    return Clickable(
      onPressed: (){
        pushNavigation(context: context, widget: GameTickets(id: myGame.uuid,), routeName: NamedRoutes.gameTickets);
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
                      height: double.infinity,
                      imageUrl: image,
                      placeholder: (context, url) => const MediaPlaceholder(),
                      errorWidget: (context, url, error) => const MediaPlaceholder(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    isEnded
                        ? Container(
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
                    ):
                    isInView
                        ? Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: ColorPath.meadowGreen,
                        border: Border.all(color: Colors.white, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Text(
                        'Draw Date: ${DateFormat("dd/MM/yyyy").tryParse(drawDate.toString())}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ):
                    isOngoing
                        ? Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: ColorPath.bambooOrange,
                        border: Border.all(color: Colors.white, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Text(
                        'Game Date: Ongoing',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                    :const SizedBox(),
                  ),
                  if(isInstantGame)Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: ColorPath.aliceBlue,
                        border: Border.all(color: Colors.white, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      ),
                      child: Text(
                        'Instant Game',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorPath.allPortBlue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 12.h,),
            // Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     "Game 1",
            //     style: Theme.of(context).textTheme.bodySmall?.copyWith(
            //       fontSize: 10.sp,
            //       fontWeight: FontWeight.w400,
            //       color: Theme.of(context).colorScheme.textTertiary,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // SizedBox(height: 5.h,),
            Align(
              alignment: Alignment.center,
              child: Text(
                name,
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
                description,
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
