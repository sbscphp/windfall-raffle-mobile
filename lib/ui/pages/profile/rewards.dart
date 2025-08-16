import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/listview_items/reward_item.dart';
import 'package:windfall/ui/widgets/profile/reward_card.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            ScreenTitle(
              title: "My Rewards",
              subTitle: "Manage my rewards with ease",
            ),
            SizedBox(height: 32.h),
            RewardCard(referralCode: "AdeKUnleAIo"),
            SizedBox(height: 24.h),
            tabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [used(), earned()],
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

  Widget used() => ListView.separated(
    // shrinkWrap: true,
    padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
    // physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return RewardItem(rewardData: "Kunle Jadesola", amount: 2000);
    },
    separatorBuilder: (context, index) => SizedBox(height: 16.h),
    itemCount: 20,
  );

  Widget earned() => ListView.separated(
    // shrinkWrap: true,
    padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
    // physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return RewardItem(rewardData: "Lekki Raffle House", point: 250);
    },
    separatorBuilder: (context, index) => SizedBox(height: 16.h),
    itemCount: 20,
  );
}
