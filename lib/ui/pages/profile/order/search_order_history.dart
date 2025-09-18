import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/data/view_models/order_history_vms/search_order_history_vm.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/data/enum/view_state.dart';
import '../../../../core/utilities/debouncer.dart';
import '../../../../core/utilities/utilities.dart';
import '../../../widgets/app_loader.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/error_state.dart';
import '../../../widgets/listview_items/order_history_item.dart';
import '../../../widgets/show_flush_bar.dart';


class SearchOrderHistory extends ConsumerStatefulWidget {
  const SearchOrderHistory({super.key});

  @override
  ConsumerState<SearchOrderHistory> createState() => _SearchOrderHistoryState();
}

class _SearchOrderHistoryState extends ConsumerState<SearchOrderHistory> {

  late ScrollController _scrollController;
  final _keyWord = TextEditingController();
  late Debouncer debouncer;

  @override
  void initState() {
    _scrollController = ScrollController();
    debouncer = Debouncer(milliseconds: 800);
    _scrollListener(vm: ref.read(searchOrderHistoryViewModel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(searchOrderHistoryViewModel);
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Search'),
      body: Padding(
        padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              isCompulsory: false,
              hintText: "Search",
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12, right: 12.w),
                child: CustomSvg(asset: AppAsset.search),
              ),
              onChanged: (value){
                debouncer.performAction(action: () async {
                  if (value.isNotEmpty &&
                      value.length >= 3){
                    Utilities.hideKeyboard(context);
                    //search transaction
                    await vm.fetchOrderHistory(keyWord: value.trim(), firstCall: true);
                    showFlushBar(
                        context: context,
                        success: vm.state == ViewState.retrieved,
                        message: vm.message
                    );
                  }
                });
              },
            ),
            SizedBox(height: 24.h,),
            Expanded(
              child: setBody(context: context, vm: vm),
            )

          ],
        ),
      ),
    );
  }

  _scrollListener({required SearchOrderHistoryVm vm}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.searchResults.length < vm.totalRecords) {
            //fetch more order histories
            vm.fetchOrderHistory(
                firstCall: false,
                keyWord: _keyWord.text
            );
          }
        }
      }
    });
  }

  setBody({required BuildContext context, required SearchOrderHistoryVm vm}){
    if(vm.state == ViewState.busy){
      return const Center(
        child: AppLoader(),
      );
    }
    if(vm.state == ViewState.retrieved){
      if(vm.searchResults.isEmpty){
        return EmptyState(
          asset: AppAsset.emptyCart,
          useBgCard: false,
          assetHeight: 128.h,
          assetWidth: 128.w,
          title: "No Results",
          ctaText: "",
          subtitle:
          "",
          showCtaButton: false,
        );
      }
      return Column(
        children: [
          Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final orderHistory = vm.searchResults[index];
                  return OrderHistoryItem(order: orderHistory,);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.h);
                },
                itemCount: vm.searchResults.length,
              )),
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
                onPressed: ()=>vm.fetchOrderHistory(firstCall: false, keyWord: _keyWord.text.trim()))
        ],
      );

    }

    if(vm.state == ViewState.error){
      return Center(
        child: ErrorState(
          message: vm.message,
          onPressed: ()=>vm.fetchOrderHistory(keyWord: _keyWord.text),
        ),
      );
    }

    return const SizedBox();
  }
}
