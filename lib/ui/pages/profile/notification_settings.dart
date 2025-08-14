import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:windfall/ui/widgets/bottom_sheets/custom_bottom_sheet.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
          NotificationSettingsItem(
            title: "Game Results & Winners",
            subTitle:
                "Get notified when results are announced or if you've won.",
          ),
          NotificationSettingsItem(
            title: "Related Game Suggestions",
            subTitle:
                "Discover similar raffles based on your interests and past entries.",
          ),
          NotificationSettingsItem(
            title: "New Game Alerts",
            subTitle:
                "Be the first to know when new raffles launch on the platform.",
          ),

          NotificationSettingsItem(
            title: "Payment & Transaction Alerts",
            subTitle: "Receive confirmation for ticket purchases etc.",
          ),
          NotificationSettingsItem(
            title: "Promotional Emails",
            subTitle:
                "Get exclusive offers, limited-time discounts, and raffle promotions.",
          ),
          NotificationSettingsItem(
            title: "Account & Security Alerts",
            subTitle:
                "Get exclusive offers, limited-time discounts, and raffle promotions.",
          ),
          SizedBox(height: 16.h),

          CustomButton(
            onPressed: () {
                // confirmm save changes bottomsheet
              // baseBottomSheet(
              //   context: context,
              //   content: CustomBottomSheet(
              //     title: "Save Changes ? ",
              //     subTitle:
              //         "Are you sure you want to save and update this new changes? Kindly note that this new changes would override the pre-existing data ",
              //     firstbuttonText: "Save Changes",
              //     secondButtonText: "No, Close",
              //   ),
              // );
              // success bottomsheet
              baseBottomSheet(
                context: context,
                content: CustomBottomSheet(
                  title: "New Changes Saved ",
                  subTitle:
                      "Congratulation, you have successfully saved and updated new changes",
                  firstbuttonText: "Manage Settings",
                  secondButtonText: "Explore Games",
                  asset: AppAsset.success,
                ),
              );
            },
            useDottedBorder: true,
            buttonText: "Save and Update Changes",
          ),
          SizedBox(height: 48.h),
        ],
      ),
    );
  }
}

class NotificationSettingsItem extends StatefulWidget {
  // final bool value;
  final String title;
  final String subTitle;
  const NotificationSettingsItem({
    super.key,
    // this.value = true,
    this.title = "Title",
    this.subTitle = "Subtitle",
  });

  @override
  State<NotificationSettingsItem> createState() =>
      _NotificationSettingsItemState();
}

class _NotificationSettingsItemState extends State<NotificationSettingsItem> {
  bool value = true;
  @override
  void initState() {
    // value = widget.value;
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
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
