import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/game_vms/all_games_vm.dart';
import 'package:windfall/core/data/view_models/game_vms/game_filters_vm.dart';
import 'package:windfall/ui/widgets/body_header.dart';
import 'package:windfall/ui/widgets/bottom_sheets/game_filters.dart';
import 'package:windfall/ui/widgets/cart/cart_icon.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/listview_items/game_item.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/app_loader.dart' show AppLoader;
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/filter_icon.dart';
import '../../widgets/screen_title.dart';

class Games extends ConsumerStatefulWidget {
  const Games({super.key});

  @override
  ConsumerState<Games> createState() => _GamesState();
}

class _GamesState extends ConsumerState<Games> {

  late ScrollController _scrollController, _filterScrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _filterScrollController = ScrollController();
    _scrollListener();
    _filterScrollListener();
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

  _filterScrollListener() {
    final vm = ref.read(gameFiltersViewModel);
    _filterScrollController.addListener(() {
      if (_filterScrollController.position.pixels ==
          _filterScrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.filteredResults.length < vm.totalRecords) {
            //fetch more games
            vm.fetchFilteredResults(
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
    final gameFiltersVm = ref.watch(gameFiltersViewModel);
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
                  child: FittedBox(
                    child: ScreenTitle(
                        title: 'All Raffles / Games',
                        titleSize: 16,
                        subTitleSize: 14,
                        titleFontWeight: FontWeight.w600,
                        titleColor: Theme.of(context).colorScheme.textPrimary,
                        subTitle: 'One ticket. One shot. Your keys could be next.'
                    ),
                  ),
                ),
                SizedBox(width: 20.w,),
                if(vm.state == ViewState.retrieved && vm.allGames.isNotEmpty)Row(
                  children: [
                    if(gameFiltersVm.showFilteredList)Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Clickable(
                        onPressed: (){
                          gameFiltersVm.clearFilters();
                        },
                        child: Text(
                          'Clear Filters',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textPrimary,
                            decorationColor: Theme.of(context).colorScheme.textPrimary,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ),
                    FilterIcon(
                        onPressed: (){
                          baseBottomSheet(
                              context: context,
                              enableDrag: false,
                              isDismissible: false,
                              content: GameFilters()
                          );
                        }
                    )
                  ],
                )
              ],
            ),
          ),
          Builder(
            builder: (context) {

              if(gameFiltersVm.showFilteredList){

                if(gameFiltersVm.state == ViewState.busy){
                  return Center(
                    child: AppLoader(),
                  );
                }

                if(gameFiltersVm.state == ViewState.retrieved){

                  if(gameFiltersVm.filteredResults.isEmpty){

                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight),
                            child: EmptyState(
                              asset: AppAsset.gamesEmptyState,
                              title: 'No Results',
                              subtitle: "no results found",
                              showCtaButton: false,
                            ),
                          )
                        ],
                      ),
                    );

                  }

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GridView.builder(
                              controller: _filterScrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: gameFiltersVm.filteredResults.length,
                              padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, top: 32.h),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 16.w,
                                mainAxisExtent: 246.h,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final game = gameFiltersVm.filteredResults[index];
                                return GameItem(game: game,);
                              }),
                        ),
                        if(gameFiltersVm.paginatedState == ViewState.busy)
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: const Align(
                              alignment: Alignment.center,
                              child: AppLoader(
                                size: 16,
                              ),
                            ),
                          ),
                        if(gameFiltersVm.paginatedState == ViewState.error)
                          ErrorState(
                              message: gameFiltersVm.message,
                              isPaginationType: true,
                              onPressed: ()=>gameFiltersVm.fetchFilteredResults(firstCall: false))
                      ],
                    ),
                  );
                }

                if(gameFiltersVm.state == ViewState.error){
                  return  Center(
                    child: ErrorState(
                        message: gameFiltersVm.message,
                        onPressed: ()=>gameFiltersVm.fetchFilteredResults()
                    ),
                  );
                }

                return const SizedBox();

              }
              else{

                if(vm.state == ViewState.busy){
                  return Center(
                    child: AppLoader(),
                  );
                }

                if(vm.state == ViewState.retrieved){

                  if(vm.allGames.isEmpty){

                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight),
                            child: EmptyState(
                              asset: AppAsset.gamesEmptyState,
                              title: 'No Results',
                              subtitle: "no results found",
                              showCtaButton: false,
                            ),
                          )
                        ],
                      ),
                    );

                  }

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GridView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: vm.allGames.length,
                              padding: EdgeInsets.only(left: AppDimension.paddingLeft, right: AppDimension.paddingRight, top: 32.h),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 16.w,
                                mainAxisExtent: 246.h,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                final game = vm.allGames[index];
                                return GameItem(game: game,);
                              }),
                        ),
                        if(vm.paginatedState == ViewState.busy)
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: const Align(
                              alignment: Alignment.center,
                              child: AppLoader(
                                size: 16,
                              ),
                            ),
                          ),
                        if(vm.paginatedState == ViewState.error)
                          ErrorState(
                              message: vm.message,
                              isPaginationType: true,
                              onPressed: ()=>vm.fetchAllGames(firstCall: false))
                      ],
                    ),
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
            }
          ),
        ],
      ),
    );
  }
}
