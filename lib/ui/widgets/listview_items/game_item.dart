import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/home/game_details.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/data/models/game.dart';
import '../../../core/data/view_models/game_vms/single_game_vm.dart';
import '../../../core/utilities/date_utilitites.dart';
import '../../../core/utilities/utilities.dart';
import '../home/game_property.dart';
import '../media_placeholder.dart';
import '../naira_display.dart';

class GameItem extends StatelessWidget {
  final Game game;
  const GameItem({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final image = game.cardImage ?? '';
    final status = game.mainActiveStatus ?? '';
    final drawDate = game.drawDate ?? DateTime.now();
    final name = game.name ?? 'N/A';
    final minEntryPrice = double.tryParse(game.minimumEntry?.toString() ?? '0') ?? 0;
    final maxPerson = double.tryParse(game.maxTicketsPerPerson?.toString() ?? '0') ?? 0;
    final ticketsLeft = double.tryParse(game.ticketsLeft?.toString() ?? '0') ?? 0;
    final isInstantGame = game.instantGame?.toLowerCase() == 'true';
    final gameId = game.uuid ?? '';
    return Clickable(
      onPressed: (){
        print('game id before click::::$gameId>>>>>');
        pushNavigation(context: context, widget: ProviderScope(
            overrides: [
              gameIdProvider.overrideWithValue(gameId),
            ],
            child: const GameDetails()), routeName: NamedRoutes.gameDetails);
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
                  Positioned(
                    right: 8.w,
                    top: 10.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                      decoration: BoxDecoration(
                          color: Utilities.statusContainerColor(status: status),
                          borderRadius: BorderRadius.all(Radius.circular(16.r))
                      ),
                      child: Text(
                        Utilities.statusText(status: status),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                            color: Utilities.statusTextColor(status: status)
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
                            'Draw: ${DateUtilities.monthDayYear(date: drawDate)}',
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
                  // if(isInstantGame)Positioned(
                  //   top: 8.h,
                  //   right: 8.w,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                  //     decoration: BoxDecoration(
                  //       color: ColorPath.aliceBlue,
                  //       border: Border.all(color: Colors.white, width: 1.w),
                  //       borderRadius: BorderRadius.all(Radius.circular(16.r)),
                  //     ),
                  //     child: Text(
                  //       'Instant Game',
                  //       style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  //         fontSize: 9.sp,
                  //         fontWeight: FontWeight.w600,
                  //         color: ColorPath.allPortBlue,
                  //       ),
                  //     ),
                  //   ),
                  // )


                ],
              ),
            ),
            SizedBox(height: 12.h,),
            Text(
              name,
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
                    "${DateUtilities.monthDayYear(date: drawDate)}",
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
                    amount: minEntryPrice,
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
                    '${Utilities.formatAmount(
                      addDecimal: false,
                      amount: maxPerson
                    )}',
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
                    "${Utilities.formatAmount(
                      amount: ticketsLeft,
                      addDecimal: false
                    )} ${ticketsLeft > 1 ? 'Tickets':'Ticket'}",
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
