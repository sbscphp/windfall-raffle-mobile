import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/color_path.dart';
import '../../core/data/view_models/authentication_vms/login_vm.dart';
import '../../core/data/view_models/bottom_nav_view_model.dart';
import '../../core/data/view_models/profile_vms/notification_vms/notification_settings_vm.dart';
import '../../core/data/view_models/profile_vms/profile_vm.dart';
import '../widgets/bottom_nav_items.dart';


class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {

  @override
  void initState() {

    final loginVm = ref.read(loginViewModel);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModel).user = loginVm.user;
      ref.read(notificationSettingsViewModel).settings = loginVm.user?.notificationSetting;
      // ref.read(spendLimitViewModel).spendLimit = loginVm.user?.spendLimitStatus;
      // ref.read(referralViewModel).referralBalance = loginVm.user?.referralBalance;
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final bottomNavVm = ref.watch(bottomNavViewModel);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: BottomNavigationBar(
                  onTap: (index) => bottomNavVm.updateIndex(index),
                  type: BottomNavigationBarType.fixed,
                  unselectedFontSize: 14.sp,
                  selectedFontSize: 14.sp,
                  selectedItemColor: ColorPath.redOrange,
                  unselectedItemColor: Theme.of(context).colorScheme.text5,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w400
                  ),
                  unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w400
                  ),
                  elevation: 10,
                  backgroundColor: Theme.of(context).colorScheme.whiteText,
                  currentIndex: bottomNavVm.currentIndex,

                  items: bottomNavItems()),
            ),
          ),
          body: SafeArea(
              top: false, //todo: add app upgrader package
              child: IndexedStack(
                  index: bottomNavVm.currentIndex, children: bottomNavVm.children)),
        ),
    );
  }
}
