import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/empty_state.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Notifications'),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: AppDimension.paddingTop,
        ),
        children: [
          ScreenTitle(
            title: "Notification",
            subTitle:
                "See what’s going on, manage your notification, all in one place.",
            subTitleSize: 12.sp,
          ),
          SizedBox(height: 24.h),
          1 + 1 == 3
              ? EmptyState(
                  asset: AppAsset.emptyNotification,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 62.h,
                  ),
                  title: "No Notifications",
                  subtitle: "You have no notifications yet",
                  showCtaButton: false,
                  assetHeight: 70.h,
                  assetWidth: 70.h,
                )
              : ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      isRead: index % 2 == 0, // Example logic for read/unread
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.h);
                  },
                  itemCount: 5,
                ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final bool isRead;
  const NotificationItem({super.key, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: !isRead ? Theme.of(context).colorScheme.surface : null,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Win Alert",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.circle,
                      size: 6,
                      color: Theme.of(context).colorScheme.textPrimary,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Just Now",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.textSecondary,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
              !isRead
                  ? Icon(
                      Icons.circle,
                      size: 10,
                      color: Theme.of(context).colorScheme.brandColor,
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "This is a description of the notification. It provides more details about the notification.",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
