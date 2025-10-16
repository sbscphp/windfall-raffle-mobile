import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:windfall/ui/widgets/bottom_sheets/custom_bottom_sheet.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/profile_vms/notification_vms/notification_settings_vm.dart';
import '../../widgets/show_flush_bar.dart';

class NotificationSettings extends ConsumerStatefulWidget {
  const NotificationSettings({super.key});

  @override
  ConsumerState<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends ConsumerState<NotificationSettings> {

  bool _push = false;
  bool _email = false;
  bool _gameDraw = false;
  bool _gameResult = false;
  bool _gameSuggestion = false;
  bool _newGames = false;
  bool _paymentTransactions = false;
  bool _promotional = false;
  bool _accountSecurity = false;

  @override
  void initState() {
    final notificationSettingsVm = ref.read(notificationSettingsViewModel);
    _push = notificationSettingsVm.push;
    _email = notificationSettingsVm.email;
    _gameDraw = notificationSettingsVm.gameDraw;
    _gameResult = notificationSettingsVm.gameResult;
    _gameSuggestion = notificationSettingsVm.gameSuggestion;
    _newGames = notificationSettingsVm.newGames;
    _paymentTransactions = notificationSettingsVm.paymentTransaction;
    _promotional = notificationSettingsVm.promotional;
    _accountSecurity = notificationSettingsVm.accountSecurity;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(notificationSettingsViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context, title: 'Notification Settings'),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: AppDimension.paddingTop,
          ),
          children: [
            ScreenTitle(
              title: "Notification Settings",
              subTitle: "Manage your Notification with ease. ",
              subTitleSize: 12.sp,
            ),
            SizedBox(height: 32.h),

            NotificationSettingsItem(
              title: "Game Draw Reminder",
              subTitle:
                  "Be notified when your raffle draws are about to take place.",
              onchanged: (value) => _gameDraw = value,
              initialValue: _gameDraw,
            ),
            NotificationSettingsItem(
              title: "Game Results & Winners",
              subTitle:
                  "Get notified when results are announced or if you've won.",
              onchanged: (value) => _gameResult = value,
              initialValue: _gameResult,
            ),
            NotificationSettingsItem(
              title: "Related Game Suggestions",
              subTitle:
                  "Discover similar raffles based on your interests and past entries.",
              onchanged: (value) => _gameSuggestion = value,
              initialValue: _gameSuggestion,
            ),
            NotificationSettingsItem(
              title: "New Game Alerts",
              subTitle:
                  "Be the first to know when new raffles launch on the platform.",
              onchanged: (value) => _newGames = value,
              initialValue: _newGames,
            ),

            NotificationSettingsItem(
              title: "Payment & Transaction Alerts",
              subTitle: "Receive confirmation for ticket purchases etc.",
              onchanged: (value) => _paymentTransactions = value,
              initialValue: _paymentTransactions,
            ),
            NotificationSettingsItem(
              title: "Promotional Emails",
              subTitle:
                  "Get exclusive offers, limited-time discounts, and raffle promotions.",
              onchanged: (value) => _promotional = value,
              initialValue: _promotional,
            ),
            NotificationSettingsItem(
              title: "Account & Security Alerts",
              subTitle:
                  "Get exclusive offers, limited-time discounts, and raffle promotions.",
              onchanged: (value) => _accountSecurity = value,
              initialValue: _accountSecurity,
            ),
            SizedBox(height: 16.h),

            CustomButton(
              onPressed: () {
                baseBottomSheet(
                  context: context,
                  content: CustomBottomSheet(
                    asset: Image.asset(
                      AppAsset.warning,
                      height: 100.h,
                      width: 100.w,
                    ),
                    title: "Save Changes ? ",
                    subTitle:
                        "Are you sure you want to save and update this new changes? Kindly note that this new changes would override the pre-existing data ",
                    firstbuttonText: "Save Changes",
                    secondButtonText: "No, Close",
                    firstButtonOnPressed: ()async{
                      popNavigation(context: context);
                      await vm.updateNotificationSettings(
                          //push: _push,
                          //email: _email,
                           accountSecurity: _accountSecurity,
                          gameDraw: _gameDraw,
                          gameResult: _gameResult,
                          gameSuggestions: _gameSuggestion,
                          newGames: _newGames,
                          paymentTransactions: _paymentTransactions,
                          promotional: _promotional,
                      );

                      if(vm.state == ViewState.retrieved){
                        popNavigation(context: context);
                      }

                      showFlushBar(
                          context: context,
                          message: vm.message,
                          success: vm.state == ViewState.retrieved
                      );
                    },
                    secondButtonOnPressed: (){
                      popNavigation(context: context);
                    },
                  ),
                );
              },
              useDottedBorder: true,
              buttonText: "Save and Update Changes",
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }
}

class NotificationSettingsItem extends StatefulWidget {
  final bool initialValue;
  final String title;
  final String subTitle;
  final ValueChanged<bool> onchanged;
  const NotificationSettingsItem({
    super.key,
    this.initialValue = true,
    this.title = "Title",
    this.subTitle = "Subtitle",
    required this.onchanged
  });

  @override
  State<NotificationSettingsItem> createState() =>
      _NotificationSettingsItemState();
}

class _NotificationSettingsItemState extends State<NotificationSettingsItem> {
  late bool value;
  @override
  void initState() {
    value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WindfallContainer(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.textPrimary,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(height: 5.h,),
                Text(
                  widget.subTitle,
                  // maxLines: 1,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.textSecondary,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: .75,
            child: CupertinoSwitch(
              value: value,
              activeTrackColor: ColorPath.redOrange,
              onChanged: (value) {
                setState(() {
                  // Handle switch toggle
                  this.value = value;
                  widget.onchanged(this.value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
