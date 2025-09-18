import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/game_vms/game_filters_vm.dart';
import 'package:windfall/core/data/view_models/game_vms/my_game_filters_vm.dart';
import 'package:windfall/ui/widgets/bottom_sheets/my_game_filters.dart';
import 'package:windfall/ui/widgets/filter_icon.dart';
import 'package:windfall/ui/widgets/listview_items/my_game_item.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../../../core/data/view_models/game_vms/all_games_vm.dart';
import '../../../core/data/view_models/game_vms/my_games_vm.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/screen_title.dart';

class MyGames extends ConsumerStatefulWidget {
  const MyGames({super.key});

  @override
  ConsumerState<MyGames> createState() => _MyGamesState();
}

class _MyGamesState extends ConsumerState<MyGames> {

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
    final vm = ref.read(myGamesViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.myGames.length < vm.totalRecords) {
            //fetch more games
            vm.fetchMyGames(
                firstCall: false
            );
          }
        }
      }
    });
  }

  _filterScrollListener() {
    final vm = ref.read(myGameFiltersViewModel);
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
    final vm = ref.watch(myGamesViewModel);
    final myGamesFilterVm = ref.watch(myGameFiltersViewModel);
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
                if(vm.state == ViewState.retrieved && vm.myGames.isNotEmpty)Row(
                  children: [
                    if(myGamesFilterVm.showFilteredList)Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Clickable(
                        onPressed: (){
                          myGamesFilterVm.clearFilters();
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
                              content: MyGameFilters()
                          );
                        }
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 16.h,),
          Builder(
            builder: (context) {

              if(myGamesFilterVm.showFilteredList){

                if(myGamesFilterVm.state == ViewState.busy){
                  return Center(
                    child: AppLoader(),
                  );
                }

                if(myGamesFilterVm.state == ViewState.retrieved){

                  if(myGamesFilterVm.filteredResults.isEmpty){

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
                          child: RefreshIndicator.adaptive(
                            onRefresh: () => _refresh(myGamesFilterVm),
                            backgroundColor: Theme.of(context).colorScheme.whiteText,
                            color: ColorPath.redOrange,
                            child: GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                                controller: _filterScrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: myGamesFilterVm.filteredResults.length,
                                padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 16.w,
                                  mainAxisExtent: 212.h,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final myGame = myGamesFilterVm.filteredResults[index];
                                  return MyGameItem(myGame: myGame,);
                                }),
                          ),
                        ),
                        if(myGamesFilterVm.paginatedState == ViewState.busy)
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: const Align(
                              alignment: Alignment.center,
                              child: AppLoader(
                                size: 16,
                              ),
                            ),
                          ),
                        if(myGamesFilterVm.paginatedState == ViewState.error)
                          ErrorState(
                              message: myGamesFilterVm.message,
                              isPaginationType: true,
                              onPressed: ()=>myGamesFilterVm.fetchFilteredResults(firstCall: false))
                      ],
                    ),
                  );
                }

                if(vm.state == ViewState.error){
                  return  Center(
                    child: ErrorState(
                        message: myGamesFilterVm.message,
                        onPressed: ()=>myGamesFilterVm.fetchFilteredResults()
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

                  if(vm.myGames.isEmpty){

                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingRight),
                            child: EmptyState(
                              asset: AppAsset.gamesEmptyState,
                              title: 'No Games',
                              subtitle: "You are yet to Play any Games",
                              ctaText: 'View Games',
                              onPressed: (){
                                final container =
                                ProviderScope.containerOf(context);

                                final bottomNavVm =
                                container.read(bottomNavViewModel);

                                bottomNavVm.updateIndex(1);
                              },
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
                          child: RefreshIndicator.adaptive(
                            onRefresh: () => _refresh(myGamesFilterVm),
                            backgroundColor: Theme.of(context).colorScheme.whiteText,
                            color: ColorPath.redOrange,
                            child: GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                                controller: _scrollController,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: vm.myGames.length,
                                padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16.h,
                                  crossAxisSpacing: 16.w,
                                  mainAxisExtent: 212.h,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final myGame = vm.myGames[index];
                                  return MyGameItem(myGame: myGame,);
                                }),
                          ),
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
                              onPressed: ()=>vm.fetchMyGames(firstCall: false))
                      ],
                    ),
                  );
                }

                if(vm.state == ViewState.error){
                  return  Center(
                    child: ErrorState(
                        message: vm.message,
                        onPressed: ()=>vm.fetchMyGames()
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

  //refreshes my games screen
  Future<void> _refresh(MyGameFiltersVm myFiltersVm) async {
    final myGamesVm = ref.read(myGamesViewModel);
    if(myFiltersVm.showFilteredList){
      myFiltersVm.fetchFilteredResults(refreshUi: false);
    }else{
      //fetch my games
      myGamesVm.fetchMyGames(refreshUi: false);
    }

  }
}
