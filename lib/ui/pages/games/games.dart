import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/body_header.dart';
import 'package:windfall/ui/widgets/cart/cart_icon.dart';
import 'package:windfall/ui/widgets/listview_items/game_item.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/filter_icon.dart';
import '../../widgets/screen_title.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          showLeadingIcon: false,
          title: 'Raffles',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppDimension.paddingRight),
              child: CartIcon(),
            )
          ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ScreenTitle(
                      title: 'All Raffles / Games',
                      titleSize: 16,
                      subTitleSize: 14,
                      titleFontWeight: FontWeight.w600,
                      titleColor: Theme.of(context).colorScheme.textPrimary,
                      subTitle: 'One ticket. One shot. Your keys could be next.'
                  ),
                ),
                SizedBox(width: 10.w,),
                FilterIcon(
                    onPressed: (){}
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
                //controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 26,
                padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, top: 32.h),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  mainAxisExtent: 246.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GameItem();
                }),
          ),
        ],
      ),
    );
  }
}
