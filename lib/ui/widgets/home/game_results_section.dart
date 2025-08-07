import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/listview_items/my_game_item.dart';
import '../../../core/constants/app_asset.dart';
import '../empty_state.dart';
import '../screen_title.dart';

class GameResultsSection extends StatelessWidget {
  const GameResultsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Clickable(
              //   onPressed: (){},
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
        if(1 + 1 == 3) Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight),
          child: EmptyState(
            asset: AppAsset.gamesEmptyState,
            title: 'No Result',
            subtitle: "You have no games result yet.",
            ctaText: 'Start Playing',
          ),
        )
        else SizedBox(
          height: 212.h,
          child: ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16.w, right: 16.w,),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return MyGameItem();
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
}
