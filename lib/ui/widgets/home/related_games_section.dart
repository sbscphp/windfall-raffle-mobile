import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/models/game.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/listview_items/game_item.dart';
import '../../../core/constants/app_asset.dart';
import '../screen_title.dart';

class RelatedGamesSection extends StatelessWidget {
  const RelatedGamesSection({super.key});

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
                    title: 'Related Games',
                    titleSize: 16,
                    subTitleSize: 14,
                    titleFontWeight: FontWeight.w600,
                    titleColor: Theme.of(context).colorScheme.textPrimary,
                    subTitle: 'Start playing to win big!'
                ),
              ),
              Clickable(
                onPressed: (){},
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
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 16.w, right: 16.w,),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return GameItem(game: Game(),);
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
