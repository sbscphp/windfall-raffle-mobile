  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/game_vms/my_game_results_vm.dart';
import 'package:windfall/core/utilities/date_utilitites.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/my_games/game_tickets.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';


class GameResults extends ConsumerStatefulWidget {
  const GameResults({super.key});

  @override
  ConsumerState<GameResults> createState() => _GameResultsState();
}

class _GameResultsState extends ConsumerState<GameResults> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollListener();
    super.initState();
  }

  _scrollListener() {
    final vm = ref.read(myGameResultsViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.myGameResults.length < vm.totalRecords) {
            //fetch more game results
            vm.fetchMyGameResults(
                firstCall: false
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Results',
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 24.h,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
          bottom: 30.h
        ),
        child: Builder(
          builder: (context) {
            final vm = ref.watch(myGameResultsViewModel);

            if(vm.state == ViewState.busy){
              return Center(
                child: AppLoader(),
              );
            }

            if(vm.state == ViewState.retrieved){
              if(vm.myGameResults.isEmpty){
                return Center(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 32.w,
                        right: 32.w,
                        bottom: 32.h
                    ),
                    decoration: BoxDecoration(
                        color: ColorPath.roseWhite,
                        border: Border.all(color: ColorPath.athensGrey4, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(16.r))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomSvg(asset: AppAsset.gameResultsEmptyState, height: 60.h, width: 60.w,),
                        SizedBox(height: 34.h,),
                        Text(
                          'No Result Yet',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          'You currently do not have any results for any of your games/Raffle Draw yet',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32.h,),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 65.5.w),
                          child: CustomButton(
                              useDottedBorder: true,
                              buttonText:'Explore All Games',
                              onPressed: (){

                                final bottomNavVm =
                                ref.read(bottomNavViewModel);

                                bottomNavVm.updateIndex(1);

                                popUntilNavigation(context: context, route: NamedRoutes.bottomNav);
                              }
                          ),
                        ),


                      ],
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                      children: [
                        const TextSpan(
                          text: 'Game Results ',
                        ),
                        TextSpan(
                          text: '(${vm.totalRecords})',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorPath.redOrange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RefreshIndicator.adaptive(
                            onRefresh: () => _refresh(),
                            backgroundColor: Theme.of(context).colorScheme.whiteText,
                            color: ColorPath.redOrange,
                            child: ListView.separated(
                              controller: _scrollController,
                              itemCount: vm.myGameResults.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final result = vm.myGameResults[index];
                                final name = result.game?.name ?? 'N/A';
                                final description = result.game?.description ?? 'N/A';
                                final drawDate = DateUtilities.monthDayYear(date: result.game?.endDate ?? DateTime.now());
                                return Clickable(
                                  onPressed: (){
                                    pushNavigation(context: context, widget: GameTickets(id: result.uuid,), routeName: NamedRoutes.gameTickets);
                                  },
                                  child: WindfallContainer(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppDimension.paddingLeft,
                                          vertical: 16.h
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: Theme.of(context).colorScheme.textPrimary,
                                                fontWeight: FontWeight.w600
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 5.h,),
                                          Text(
                                            description,
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: Theme.of(context).colorScheme.textSecondary,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                          SizedBox(height: 8.h,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomSvg(asset: AppAsset.drawDate, height: 16.h, width: 16.w,),
                                              SizedBox(width: 8.w,),
                                              Text(
                                                drawDate,
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: Theme.of(context).colorScheme.textSecondary,
                                                    fontWeight: FontWeight.w400
                                                ),
                                              ),
                                              Container(
                                                height: 18.h,
                                                width: 1.5.w,
                                                margin: EdgeInsets.symmetric(horizontal: 16.w),
                                                color: ColorPath.athensGrey5,
                                              ),
                                              Text(
                                                "View Result",
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                    color: ColorPath.redOrange,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),

                                            ],
                                          )

                                        ],
                                      )
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 16.h,);
                              },
                            ),
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
                              onPressed: ()=>vm.fetchMyGameResults(firstCall: false))
                      ],
                    ),
                  )
                ],
              );
            }

            if(vm.state == ViewState.error){
              return Center(
                child: ErrorState(
                  message: vm.message,
                    onPressed: ()=>vm.fetchMyGameResults()
                ),
              );
            }

            return const SizedBox();

          }
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    final myGameResultsVm = ref.read(myGameResultsViewModel);
    //fetch my game results
    myGameResultsVm.fetchMyGameResults(refreshUi: false);
  }
}
