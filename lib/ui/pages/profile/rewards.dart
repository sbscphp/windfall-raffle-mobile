import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/data/view_models/referral_vm.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/listview_items/reward_item.dart';
import 'package:windfall/ui/widgets/profile/reward_card.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/empty_state.dart';

class Rewards extends ConsumerStatefulWidget {
  const Rewards({super.key});

  @override
  ConsumerState<Rewards> createState() => _RewardsState();
}

class _RewardsState extends ConsumerState<Rewards> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _usedController, _earnedController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _usedController = ScrollController();
    _earnedController = ScrollController();
    final vm = ref.read(referralViewModel);
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   vm.fetchEarnedHistory();
    //   vm.fetchUsedHistory();
    // });
    _earnedScrollListener(vm);
    _usedScrollListener(vm);
    super.initState();
  }

  _earnedScrollListener(ReferralVm vm) {
    _earnedController.addListener(() {
      if (_earnedController.position.pixels ==
          _earnedController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.earnedHistory.length < vm.earnedTotalRecords) {
            //fetch more history
            vm.fetchEarnedHistory(
                firstCall: false
            );
          }
        }
      }
    });
  }

  _usedScrollListener(ReferralVm vm) {
    _usedController.addListener(() {
      if (_usedController.position.pixels ==
          _usedController.position.maxScrollExtent) {
        //check paginated state
        if(vm.secondPaginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.secondPaginatedState != ViewState.busy && vm.usedHistory.length < vm.usedTotalRecords) {
            //fetch more history
            vm.fetchUsedHistory(
                firstCall: false
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(referralViewModel);
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Rewards'),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          left: AppDimension.paddingLeft,
          right: AppDimension.paddingRight,
        ),
        child: Column(
          children: [
            // ScreenTitle(
            //   title: "My Rewards",
            //   subTitle: "Manage my rewards with ease",
            // ),
            // SizedBox(height: 32.h),
            RewardCard(vm: vm),
            SizedBox(height: 24.h),
            tabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [used(vm), earned(vm)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tabBar() => TabBar(
    controller: _tabController,
    isScrollable: false,
    labelPadding: EdgeInsets.zero,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      color: ColorPath.fairPink,
      borderRadius: BorderRadius.circular(8.r),
    ),
    labelColor: ColorPath.redOrange,
    dividerColor: Colors.transparent,
    unselectedLabelColor: ColorPath.grayGrey,
    unselectedLabelStyle: Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    labelStyle: Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
    tabs: [
      Tab(child: FittedBox(child: Text('Referral Bonus Used'))),
      Tab(child: FittedBox(child: const Text('Referral Bonus Earned'))),
    ],
  );

  Widget used(ReferralVm vm){

    if(vm.secondState == ViewState.busy){
      return Center(
        child: AppLoader(),
      );
    }

    if(vm.secondState == ViewState.retrieved){

      if(vm.usedHistory.isEmpty){
        return Center(
          child: EmptyState(
            asset: AppAsset.emptyCart,
            useBgCard: false,
            assetHeight: 128.h,
            assetWidth: 128.w,
            showCtaButton: false,
            title: "You haven't used any referral bonus yet",
            //ctaText: "Explore All Games",
            subtitle:
            "",
          ),
        );
      }

      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              // shrinkWrap: true,
              padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final referral = vm.usedHistory[index];
                return RewardItem(referral: referral, isEarned: false,);
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: vm.usedHistory.length,
            ),
          ),
          if(vm.secondPaginatedState == ViewState.busy)
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: const Align(
                alignment: Alignment.center,
                child: AppLoader(
                  size: 16,
                ),
              ),
            ),
          if(vm.secondPaginatedState == ViewState.error)
            ErrorState(
                message: vm.usedMessage,
                isPaginationType: true,
                onPressed: ()=>vm.fetchUsedHistory(firstCall: false))
        ],
      );
    }


    if(vm.secondState == ViewState.error){
      return Center(
        child: ErrorState(
          message: vm.usedMessage,
            onPressed: ()=>vm.fetchUsedHistory()
        ),
      );
    }

    return const SizedBox();

  }

  Widget earned(ReferralVm vm){
    if(vm.state == ViewState.busy){
      return Center(
        child: AppLoader(),
      );
    }

    if(vm.state == ViewState.retrieved){

      if(vm.earnedHistory.isEmpty){
        return Center(
          child: EmptyState(
            asset: AppAsset.emptyCart,
            useBgCard: false,
            assetHeight: 128.h,
            assetWidth: 128.w,
            showCtaButton: false,
            title: "You haven't earned any referral bonus yet",
            //ctaText: "Explore All Games",
            subtitle:
            "",
          ),
        );
      }

      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              // shrinkWrap: true,
              padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final referral = vm.earnedHistory[index];
                return RewardItem(referral: referral);
              },
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: vm.earnedHistory.length,
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
                message: vm.earnedMessage,
                isPaginationType: true,
                onPressed: ()=>vm.fetchEarnedHistory(firstCall: false))
        ],
      );
    }


    if(vm.state == ViewState.error){
      return Center(
        child: ErrorState(
            message: vm.earnedMessage,
            onPressed: ()=>vm.fetchEarnedHistory()
        ),
      );
    }

    return const SizedBox();
  }
}
