import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:shimmer/shimmer.dart';
import 'package:windfall/core/data/view_models/game_vms/all_games_vm.dart';
import 'package:windfall/core/utilities/extensions/color_extensions.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';

class ActiveGamesCarousel extends ConsumerWidget {
  const ActiveGamesCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(allGamesViewModel);

    if(vm.secondState == ViewState.busy){
      return Shimmer.fromColors(
        baseColor: ColorPath.silverGrey.withCustomOpacity(0.1),
        highlightColor: ColorPath.athensGrey2,
        child: Container(
          height: 32.h,
          margin: EdgeInsets.only(),
          width: double.infinity,
          color: ColorPath.grayGrey,
        ),
      );
    }

    if(vm.secondState == ViewState.retrieved){
      return Row(
        children: [
          Container(
            height: 32.h,
            color: ColorPath.redOrange,
            padding: EdgeInsets.symmetric(
                horizontal: 16.w
            ),
            child: Center(
              child: Text(
                "Active Games",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 32.h,
              width: double.infinity,
              color: ColorPath.chablisPink,
              child: Center(
                child: Marquee(
                  text: vm.activeGameDetails,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorPath.shaftBlack
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 40.w,
                  velocity:50.0,
                  //pauseAfterRound: Duration(seconds: 1),
                  //startPadding: 10.0,
                  //accelerationDuration: Duration(seconds: 1),
                  //accelerationCurve: Curves.linear,
                  //decelerationDuration: Duration(milliseconds: 500),
                  //decelerationCurve: Curves.easeOut,
                ),
              ),
            ),
          )
        ],
      );
    }

    return const SizedBox();

  }
}
