import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/authentication_vms/login_vm.dart';
import 'package:windfall/core/data/view_models/bottom_nav_view_model.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/authentication/login.dart';
import 'package:windfall/ui/pages/profile/account_security.dart';
import 'package:windfall/ui/pages/profile/notification_settings.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../../core/constants/secure_storage_constants.dart';
import '../../../core/utilities/secure_storage/secure_storage_utils.dart';
import '../../widgets/show_flush_bar.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Settings'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: AppDimension.paddingTop,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(
              title: "Settings ",
              subTitle: "Manage your account settings all in one place.   ",
              subTitleSize: 12.sp,
            ),
            SizedBox(height: 32.h),
            SettingsItem(
              imageAsset: AppAsset.settingsNotification,
              label: "Notification Setting",
              subInfo: "Edit your Personal Information like name etc.",
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: NotificationSettings(),
                  routeName: NamedRoutes.notificationSettings,
                );
              },
            ),
            SizedBox(height: 16.h),
            SettingsItem(
              imageAsset: AppAsset.settingsAccount,
              label: "Account Security",
              subInfo: "Secure your account wth ease. ",
              onPressed: () {
                pushNavigation(
                  context: context,
                  widget: AccountSecurity(),
                  routeName: NamedRoutes.settings,
                );
              },
            ),
            SizedBox(height: 16.h),
            SettingsItem(
              imageAsset: AppAsset.logout,
              label: "Log Out",
              subInfo: "Log out of your account. ",
              onPressed: () async{

                //clear token
                await SecureStorageUtils.deleteKey(key: SecuredStorageConstants.token);

                //todo: hit backend endpoint if provided by backend first before clearing user
                final container =
                ProviderScope.containerOf(context);

                final loginVm =
                container.read(loginViewModel);
                //delete user
                loginVm.clearUser();

                pushAndClearNavigation(
                  context: context,
                  widget: Login(),
                  routeName: NamedRoutes.login,
                  clearRoute: NamedRoutes.onboarding
                );

                //show message
                showFlushBar(
                  context: context,
                  success: true,
                  message: 'Logout Successful',
                );
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String imageAsset;
  final String label;
  final String subInfo;
  final VoidCallback onPressed;
  const SettingsItem({
    super.key,
    required this.imageAsset,
    required this.label,
    this.subInfo = '',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onPressed: onPressed,
      child: WindfallContainer(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  CustomSvg(asset: imageAsset),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).colorScheme.textPrimary,
                              ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          subInfo,
                          maxLines: 1,

                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            CustomSvg(asset: AppAsset.rightChevron, height: 28.h, width: 28.w),
          ],
        ),
      ),
    );
  }
}
