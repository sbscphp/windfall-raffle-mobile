import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/models/game.dart';
import 'package:windfall/core/data/view_models/game_vms/all_games_vm.dart';
import 'package:windfall/ui/widgets/body_header.dart';
import 'package:windfall/ui/widgets/cart/cart_icon.dart';
import 'package:windfall/ui/widgets/listview_items/game_item.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/error_state.dart';
import '../../widgets/filter_icon.dart';
import '../../widgets/screen_title.dart';

class Games extends ConsumerStatefulWidget {
  const Games({super.key});

  @override
  ConsumerState<Games> createState() => _GamesState();
}

class _GamesState extends ConsumerState<Games> {

  late ScrollController _scrollController;

  @override
  void initState() {
    //todo: fetch cart here

    _scrollListener();
    super.initState();
  }

  _scrollListener() {
    final vm = ref.read(allGamesViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.allGames.length < vm.totalRecords) {
            //fetch more games
            vm.fetchAllGames(
                firstCall: false
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(allGamesViewModel);
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
                if(vm.state == ViewState.retrieved)FilterIcon(
                    onPressed: (){}
                )
              ],
            ),
          ),
          Builder(
            builder: (context) {
              if(vm.state == ViewState.busy){

              }

              if(vm.state == ViewState.retrieved){
                return Expanded(
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
                        return GameItem(game: Game(),);
                      }),
                );
              }

              if(vm.state == ViewState.error){
                return  Center(
                  child: ErrorState(
                      message: vm.message,
                      onPressed: ()=>vm.fetchAllGames()
                  ),
                );
              }

              return const SizedBox();

            }
          ),
        ],
      ),
    );
  }
}
