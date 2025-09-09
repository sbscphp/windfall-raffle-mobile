import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/game_vms/related_games_vm.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/game_item.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/game_vms/single_game_vm.dart';
import '../screen_title.dart';

class RelatedGamesSection extends ConsumerWidget {
  const RelatedGamesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameId = ref.watch(gameIdProvider);
    final vm = ref.watch(relatedGamesViewModel(gameId));

    if(vm.state == ViewState.retrieved && vm.relatedGames.isEmpty){
      return const SizedBox();
    }

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
                    title: 'Related Games',
                    titleSize: 16,
                    subTitleSize: 14,
                    titleFontWeight: FontWeight.w600,
                    titleColor: Theme.of(context).colorScheme.textPrimary,
                    subTitle: 'Start playing to win big!'
                ),
              ),
              // Clickable(
              //   onPressed: (){
              //     final container =
              //     ProviderScope.containerOf(context);
              //
              //     final bottomNavVm =
              //     container.read(bottomNavViewModel);
              //
              //     bottomNavVm.updateIndex(1);
              //   },
              //   child: Row(
              //     children: [
              //       Text(
              //         "Explore Games ",
              //         style: Theme.of(context).textTheme.bodySmall?.copyWith(
              //             fontWeight: FontWeight.w400,
              //             color: Theme.of(context).colorScheme.textTertiary,
              //             decoration: TextDecoration.underline,
              //             decorationColor: Theme.of(context).colorScheme.textTertiary
              //         ),
              //       ),
              //       SizedBox(width: 2.w,),
              //       CustomSvg(asset: AppAsset.topRightChevron, height: 16.h, width: 16.w,)
              //     ],
              //   ),
              // )

            ],
          ),
        ),
        SizedBox(height: 24.h,),
        Builder(
          builder: (context) {
            if(vm.state == ViewState.busy){
              return Center(
                child: AppLoader(),
              );
            }

            if(vm.state == ViewState.retrieved){
              return SizedBox(
                height: 246.h,
                child: ListView.separated(
                  itemCount: vm.relatedGames.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16.w, right: 16.w,),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final game = vm.relatedGames[index];
                    return GameItem(game: game,);
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
                    onPressed: ()=>vm.fetchRelatedGames(gameId: gameId)
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
