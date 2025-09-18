import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/game_vms/game_tickets_vm.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/ticket_item.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/tag_type.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/body_header.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/windfall_tag.dart';

class GameTickets extends ConsumerStatefulWidget {
  final String? appbarTitle;
  final String? id;
  const GameTickets({super.key, this.appbarTitle, required this.id});

  @override
  ConsumerState<GameTickets> createState() => _GameTicketsState();
}

class _GameTicketsState extends ConsumerState<GameTickets> {

  late ScrollController _scrollController;

  @override
  void initState() {
    final vm = ref.read(gameTicketsViewModel);
    _scrollController = ScrollController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      vm.fetchGameTickets(id: widget.id);
    });
    _scrollListener(vm);
    super.initState();
  }

  _scrollListener(GameTicketsVm vm) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.tickets.length < vm.totalRecords) {
            //fetch more tickets
            vm.fetchGameTickets(
                firstCall: false,
              id: widget.id
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
          title: widget.appbarTitle ?? 'Results',
      ),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            final vm = ref.watch(gameTicketsViewModel);

            if(vm.state == ViewState.busy){
              return Center(
                child: AppLoader(),
              );
            }

            if(vm.state == ViewState.retrieved){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyHeader(
                    verticalPadding: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ScreenTitle(
                                  title: 'Game Name',
                                  titleSize: 12,
                                  subTitleSize: 16,
                                  titleFontWeight: FontWeight.w400,
                                  titleColor: Theme.of(context).colorScheme.text5,
                                  subTitleColor: Theme.of(context).colorScheme.textPrimary,
                                  subTitleFontWeight: FontWeight.w600,
                                  subTitle: vm.name
                              ),
                              if(vm.isInstantGame)Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: WindfallTag(tag: TagType.instantGame),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Number of Tickets",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.text5,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(height: 5.h,),
                            Text(
                              "${Utilities.formatAmount(
                                amount: vm.totalRecords.toDouble(),
                                addDecimal: false
                              )} ${vm.totalRecords > 1 ? 'Tickets':'Ticket'}",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.textPrimary,
                                  fontWeight: FontWeight.w600
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h,),
                  if(vm.tickets.isEmpty)
                    Expanded(
                      child: Center(
                        child: EmptyState(
                          asset: AppAsset.emptyCart,
                          useBgCard: false,
                          assetHeight: 128.h,
                          assetWidth: 128.w,
                          showCtaButton: false,
                          title: "No Tickets",
                          //ctaText: "Explore All Games",
                          subtitle:
                          "",
                        ),
                      ),
                    )
                    else Expanded(
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
                              itemCount: vm.tickets.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final ticket = vm.tickets[index];
                                return TicketItem(
                                  ticket: ticket,
                                  isInstantGame: vm.isInstantGame,
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
                              onPressed: ()=>vm.fetchGameTickets(
                                  firstCall: false,
                                id: widget.id
                              ))
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
                    onPressed: ()=>vm.fetchGameTickets(
                        id: widget.id,
                    )
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
    final vm = ref.read(gameTicketsViewModel);
    //fetch my game results
    vm.fetchGameTickets(id: widget.id, refreshUi: false);
  }
}
