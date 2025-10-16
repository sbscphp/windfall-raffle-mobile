import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/bottom_nav_view_model.dart';
import 'package:windfall/core/data/view_models/game_vms/all_games_vm.dart';
import 'package:windfall/core/utilities/extensions/color_extensions.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/game_item.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../screen_title.dart';

class AllGamesSection extends ConsumerWidget {
  const AllGamesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(allGamesViewModel);

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
                      title: 'Don’t Miss out, Play Now',
                      titleSize: 16,
                      subTitleSize: 14,
                      titleFontWeight: FontWeight.w600,
                      titleColor: Theme.of(context).colorScheme.textPrimary,
                      subTitle: 'Start playing to win big!'
                  ),
                ),
                Clickable(
                  onPressed: (){
                    final container =
                    ProviderScope.containerOf(context);

                    final bottomNavVm =
                    container.read(bottomNavViewModel);

                    bottomNavVm.updateIndex(1);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Explore Games ",
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
              itemCount: vm.allGames.length > 5 ? 5 : vm.allGames.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 16.w, right: 16.w,),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final game = vm.allGames[index];
                return GameItem(game: game,);
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

    if(vm.state == ViewState.error){
      return Padding(
        padding: EdgeInsets.only(top: 32.h),
        child: Center(
          child: ErrorState(
            message: vm.message,
              onPressed: ()=>vm.fetchAllGames()
          ),
        ),
      );
    }

    return const SizedBox();

  }
}
