import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/filter_icon.dart';
import 'package:windfall/ui/widgets/listview_items/my_game_item.dart';
import '../../../core/constants/app_dimension.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/screen_title.dart';

class MyGames extends StatefulWidget {
  const MyGames({super.key});

  @override
  State<MyGames> createState() => _MyGamesState();
}

class _MyGamesState extends State<MyGames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          showLeadingIcon: false,
          title: 'My Games',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32.h, left: AppDimension.paddingLeft, right: AppDimension.paddingRight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ScreenTitle(
                      title: 'My Games',
                      titleSize: 16,
                      subTitleSize: 14,
                      titleFontWeight: FontWeight.w600,
                      titleColor: Theme.of(context).colorScheme.textPrimary,
                      subTitle: 'Manage your games all in one place'
                  ),
                ),
                SizedBox(width: 10.w,),
                FilterIcon(
                    onPressed: (){}
                )
              ],
            ),
          ),
          SizedBox(height: 16.h,),
          Expanded(
            child: GridView.builder(
              //controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 26,
                padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                  mainAxisExtent: 212.h,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return MyGameItem();
                }),
          ),
        ],
      ),
    );
  }
}
