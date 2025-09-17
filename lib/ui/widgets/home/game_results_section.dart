import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/game_vms/my_game_results_vm.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/profile/game_results.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/my_game_item.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/data/enum/view_state.dart';
import '../clickable.dart';
import '../custom_svg.dart';
import '../empty_state.dart';
import '../screen_title.dart';

class GameResultsSection extends ConsumerWidget {
  const GameResultsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    title: 'My Games Result',
                    titleSize: 16,
                    subTitleSize: 14,
                    titleFontWeight: FontWeight.w600,
                    titleColor: Theme.of(context).colorScheme.textPrimary,
                    subTitle: 'Track and Manage Games Result '
                ),
              ),
              Clickable(
                onPressed: (){
                  pushNavigation(context: context, widget: const GameResults(), routeName: NamedRoutes.gameResults);
                },
                child: Row(
                  children: [
                    Text(
                      "View More Results ",
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
        Builder(
          builder: (context) {
            final vm = ref.watch(myGameResultsViewModel);

            if(vm.state == ViewState.busy){
              return Center(
                child: AppLoader(),
              );
            }

            if(vm.state == ViewState.retrieved){

              if(vm.myGameResults.isEmpty){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight),
                  child: EmptyState(
                    asset: AppAsset.gamesEmptyState,
                    title: 'No Result',
                    subtitle: "You have no games result yet.",
                    ctaText: 'Start Playing',
                  ),
                );
              }
              return SizedBox(
                height: 212.h,
                child: ListView.separated(
                  itemCount: vm.myGameResults.length > 5 ? 5 : vm.myGameResults.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16.w, right: 16.w,),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final myGame = vm.myGameResults[index];
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
              return Center(
                child: ErrorState(
                  message: vm.message,
                    onPressed: ()=>vm.fetchMyGameResults()
                ),
              );
            }

            return const SizedBox();

          }
        )

      ],
    );

  }
}
