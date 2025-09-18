import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/order_history_vms/order_history_vm.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/profile/order/search_order_history.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/custom_text_field.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/order_history_item.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

import '../../../../core/data/enum/view_state.dart';
import '../../../../core/data/models/grouped_list.dart';
import '../../../../core/data/models/order.dart';
import '../../../../core/utilities/date_utilitites.dart';
import '../../../widgets/empty_state.dart';

class OrderHistory extends ConsumerStatefulWidget {
  const OrderHistory({super.key});

  @override
  ConsumerState<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends ConsumerState<OrderHistory> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    final vm = ref.read(orderHistoryViewModel);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        vm.fetchOrderHistory();
      });
    _scrollListener(vm: vm);
    super.initState();
  }

  _scrollListener({required OrderHistoryVm vm}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.orderHistory.length < vm.totalRecords) {
            //fetch more order histories
            vm.fetchOrderHistory(
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
      appBar: customAppBar(context: context, title: 'Order History'),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
        ),
        child: Column(
          children: [
            ScreenTitle(
              title: "Order History",
              subTitle: "Track and manage your order history.",
            ),
            Clickable(
              onPressed: (){
                pushNavigation(context: context, widget: const SearchOrderHistory(), routeName: NamedRoutes.searchOrderHistory);
              },
              child: CustomTextField(
                isCompulsory: false,
                enabled: false,
                hintText: "Search",
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12.w),
                  child: CustomSvg(asset: AppAsset.search),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Builder(
                builder: (context) {
                  final vm = ref.watch(orderHistoryViewModel);

                  if(vm.state == ViewState.busy){
                    return Center(
                      child: AppLoader(),
                    );
                  }

                  if(vm.state == ViewState.retrieved){
                    if(vm.groupedHistories.isEmpty){
                      return Center(
                        child: EmptyState(
                          asset: AppAsset.emptyCart,
                          useBgCard: false,
                          assetHeight: 128.h,
                          assetWidth: 128.w,
                          title: "No Order History",
                          ctaText: "Explore All Games",
                          subtitle:
                          "",
                          showCtaButton: false,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(top: 8.h),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final groupedHistory = vm.groupedHistories[index];
                              return _buildSingleDateItems(index, groupedHistory);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 8.h);
                            },
                            itemCount: vm.groupedHistories.length,
                            controller: _scrollController,
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
                              onPressed: ()=>vm.fetchOrderHistory(firstCall: false))
                      ],
                    );
                  }

                  if(vm.state == ViewState.error){
                    return Center(
                      child: ErrorState(
                        message: vm.message,
                          onPressed: ()=>vm.fetchOrderHistory()),
                    );
                  }

                  return const SizedBox();

                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleDateItems(int index, GroupedList<Order> groupedHistory) {
    final date = DateUtilities.actualDay(groupedHistory.date);
    final orderHistories = groupedHistory.items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.textTertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final orderHistory = orderHistories[index];
            return OrderHistoryItem(order: orderHistory,);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h);
          },
          itemCount: orderHistories.length,
        ),
      ],
    );
  }
}
