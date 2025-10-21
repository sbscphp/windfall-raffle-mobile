import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/game_vms/my_games_vm.dart';
import 'package:windfall/core/utilities/extensions/color_extensions.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/empty_state.dart';
import 'package:windfall/ui/widgets/guest_message.dart';
import 'package:windfall/ui/widgets/listview_items/my_game_item.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/authentication_vms/login_vm.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../error_state.dart';
import '../screen_title.dart';

class MyGamesSection extends ConsumerWidget {
  const MyGamesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginVm = ref.watch(loginViewModel);
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
              if(loginVm.isLoggedIn)Clickable(
                onPressed: (){
                  final container =
                  ProviderScope.containerOf(context);

                  final bottomNavVm =
                  container.read(bottomNavViewModel);

                  bottomNavVm.updateIndex(2);
                },
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
          if(loginVm.isLoggedIn)Builder(
            builder: (context) {

              final vm = ref.watch(myGamesViewModel);

              if(vm.state == ViewState.busy){
                return SizedBox(
                  height: 246.h,
                  child: ListView.separated(
                    itemCount:6,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft,),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: ColorPath.silverGrey.withCustomOpacity(0.1),
                        highlightColor: ColorPath.athensGrey2,
                        child: Container(
                          width: 191.w,
                          color: ColorPath.grayGrey,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16.w,
                      );
                    },
                  ),
                );
              }

              if(vm.state == ViewState.retrieved){
                if(vm.myGames.isEmpty){
                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight),
                      child: EmptyState(
                          asset: AppAsset.gamesEmptyState,
                          title: 'No Games',
                          subtitle: "You are yet to Play any Games",
                        ctaText: 'View Games',
                        onPressed: (){
                          final container =
                          ProviderScope.containerOf(context);

                          final bottomNavVm =
                          container.read(bottomNavViewModel);

                          bottomNavVm.updateIndex(1);
                        },
                      ),
                    );
                }
                return SizedBox(
                  height: 212.h,
                  child: ListView.separated(
                    itemCount: vm.myGames.length > 5 ? 5 : vm.myGames.length,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16.w, right: 16.w,),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final myGame = vm.myGames[index];
                      return MyGameItem(myGame: myGame,);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16.w,
                      );
                    },
                  ),
                );
              }

              if(vm.state == ViewState.error){
                return Padding(
                  padding: EdgeInsets.only(top: 32.h),
                  child: Center(
                    child: ErrorState(
                        message: vm.message,
                        onPressed: ()=>vm.fetchMyGames()
                    ),
                  ),
                );
              }

              return const SizedBox();


            }
          )
        else WindfallContainer(
            margin: EdgeInsets.symmetric(
              horizontal: AppDimension.paddingLeft
            ),
            padding: EdgeInsets.symmetric(
              vertical: 24.h,
              horizontal: 24.w
            ),
              child: GuestMessage(
                title: 'No Games Available',
                visitingRoute: NamedRoutes.bottomNav,
              )
          )

      ],
    );
  }
}
