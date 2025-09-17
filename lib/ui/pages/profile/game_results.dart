  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/my_games/game_tickets.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';

class GameResults extends StatefulWidget {
  const GameResults({super.key});

  @override
  State<GameResults> createState() => _GameResultsState();
}

class _GameResultsState extends State<GameResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Results',
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 24.h,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
          bottom: 30.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                children: [
                  const TextSpan(
                    text: 'Game Results ',
                  ),
                  TextSpan(
                    text: '(7)',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorPath.redOrange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h,),
            1 + 1 == 3 ? Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 50.5.h,
                    left: 32.w,
                    right: 32.w,
                    bottom: 32.h
                  ),
                  decoration: BoxDecoration(
                    color: ColorPath.roseWhite,
                    border: Border.all(color: ColorPath.athensGrey4, width: 1.w),
                    borderRadius: BorderRadius.all(Radius.circular(16.r))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomSvg(asset: AppAsset.gameResultsEmptyState, height: 60.h, width: 60.w,),
                      SizedBox(height: 34.h,),
                      Text(
                        'No Result Yet',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        'You currently do not have any results for any of your games/Raffle Draw yet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 65.5.w),
                        child: CustomButton(
                            useDottedBorder: true,
                            buttonText:'Explore All Games',
                            onPressed: (){

                            }
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            )
                : Expanded(
                  child: ListView.separated(
                                itemCount: 15,
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {

                  return Clickable(
                    onPressed: (){
                      pushNavigation(context: context, widget: const GameTickets(id: '',), routeName: NamedRoutes.gameTickets);
                    },
                    child: WindfallContainer(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimension.paddingLeft,
                        vertical: 16.h
                      ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Secure a Luxury Studio Apartment in Lekki, Lagos State, Nigeria",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.textPrimary,
                                  fontWeight: FontWeight.w600
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h,),
                            Text(
                              "Enter now to grab the opportunity of a brand new S",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.textSecondary,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 8.h,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomSvg(asset: AppAsset.drawDate, height: 16.h, width: 16.w,),
                                SizedBox(width: 8.w,),
                                Text(
                                  "Draw Date: April 11, 2025",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context).colorScheme.textSecondary,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Container(
                                  height: 18.h,
                                  width: 1.5.w,
                                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                                  color: ColorPath.athensGrey5,
                                ),
                                Text(
                                  "View Result",
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: ColorPath.redOrange,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),

                              ],
                            )

                          ],
                        )
                    ),
                  );
                                },
                                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.h,);
                                },
                              ),
                )
          ],
        ),
      ),
    );
  }
}
