import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/home/active_games_carousel.dart';
import 'package:windfall/ui/widgets/home/all_games_section.dart';
import 'package:windfall/ui/widgets/home/game_results_section.dart';
import 'package:windfall/ui/widgets/home/my_games_section.dart';
import '../../../core/constants/app_asset.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/profile/in_app_display_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<String> messages = [
    'Welcome to our app!',
    'Stay safe and healthy!',
    'New features rolling out!',
    'Enjoy seamless experience!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Home',
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: AppDimension.paddingLeft),
              child: const InAppDisplayImage(tag: "home",),
            ),
          ),
          appbarBottomPadding: 16,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: AppDimension.paddingRight),
              child: Clickable(
                onPressed: (){},
                  child: CustomSvg(asset: AppAsset.notification, height: 32.h, width: 32.w,)),
            )
          ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActiveGamesCarousel(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MyGamesSection(),
                  GameResultsSection(),
                  AllGamesSection()
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
