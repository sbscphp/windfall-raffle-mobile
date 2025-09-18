import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/game_vms/all_games_vm.dart';
import 'package:windfall/core/data/view_models/game_vms/my_game_results_vm.dart';
import 'package:windfall/core/data/view_models/game_vms/my_games_vm.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/home/active_games_carousel.dart';
import 'package:windfall/ui/widgets/home/all_games_section.dart';
import 'package:windfall/ui/widgets/home/game_results_section.dart';
import 'package:windfall/ui/widgets/home/my_games_section.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/profile/in_app_display_image.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  final List<String> messages = [
    'Welcome to our app!',
    'Stay safe and healthy!',
    'New features rolling out!',
    'Enjoy seamless experience!',
  ];

  @override
  void initState() {
    final allGamesVm = ref.read(allGamesViewModel);
    final myGamesVm = ref.read(myGamesViewModel);
    final myGameResultsVm = ref.read(myGameResultsViewModel);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      //fetch all games
      allGamesVm.fetchAllGames();
      //fetch live games
      allGamesVm.fetchLiveGames();
      //fetch my games
      myGamesVm.fetchMyGames();
      //fetch my game results
      myGameResultsVm.fetchMyGameResults();

    });
    super.initState();
  }

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
            child: RefreshIndicator.adaptive(
              onRefresh: () => _refreshHome(),
              backgroundColor: Theme.of(context).colorScheme.whiteText,
              color: ColorPath.redOrange,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    AllGamesSection(),
                    MyGamesSection(),
                    GameResultsSection(),
                  ],
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  //refreshes the home screen
  Future<void> _refreshHome() async {
    final allGamesVm = ref.read(allGamesViewModel);
    final myGamesVm = ref.read(myGamesViewModel);
    final myGameResultsVm = ref.read(myGameResultsViewModel);
    //fetch all games
    allGamesVm.fetchAllGames(refreshUi: false);
    //fetch live games
    allGamesVm.fetchLiveGames(refreshUi: false);
    //fetch my games
    myGamesVm.fetchMyGames(refreshUi: false);
    //fetch my game results
    myGameResultsVm.fetchMyGameResults(refreshUi: false);
  }
}
