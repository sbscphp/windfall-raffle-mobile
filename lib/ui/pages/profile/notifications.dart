import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/models/app_notification.dart';
import 'package:windfall/ui/pages/home/game_details.dart';
import 'package:windfall/ui/pages/receipt/payment_receipt.dart';
import 'package:windfall/ui/widgets/app_loader.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/empty_state.dart';
import 'package:windfall/ui/widgets/error_state.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/with_scope.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/game_vms/single_game_vm.dart';
import '../../../core/data/view_models/profile_vms/notification_vms/notification_vm.dart';
import '../../../core/utilities/date_utilitites.dart';
import '../../../core/utilities/navigator.dart';
import '../my_games/game_tickets.dart';

class Notifications extends ConsumerStatefulWidget {
  const Notifications({super.key});

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {

  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    final vm = ref.read(notificationViewModel);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        vm.fetchNotifications();
      });
    _scrollListener(vm: vm);
    super.initState();
  }

  _scrollListener({required NotificationVm vm}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.notifications.length < vm.totalRecords) {
            //fetch more notifications
            vm.fetchNotifications(
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
      appBar: customAppBar(context: context, title: 'Notifications'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimension.paddingLeft,
          vertical: AppDimension.paddingTop,
        ),
        child: Column(
          children: [
            ScreenTitle(
              title: "Notification",
              subTitle:
                  "See what’s going on, manage your notification, all in one place.",
              subTitleSize: 12.sp,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Builder(
                builder: (context) {
                  final vm = ref.watch(notificationViewModel);

                  if(vm.state == ViewState.busy){
                    return Center(child: AppLoader(),);
                  }

                  if(vm.state == ViewState.retrieved){
                    if(vm.notifications.isEmpty){
                      return EmptyState(
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
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RefreshIndicator.adaptive(
                            onRefresh: () => _refresh(),
                            backgroundColor: Colors.white,
                            color: ColorPath.redOrange,
                            child: ListView.separated(
                              controller: _scrollController,
                              physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final notification = vm.notifications[index];
                                return NotificationItem(
                                  notification: notification,
                                  index: index,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 8.h);
                              },
                              itemCount: vm.notifications.length,
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
                              onPressed: ()=>vm.fetchNotifications(firstCall: false))
                      ],
                    );
                  }

                  if(vm.state == ViewState.error){
                    return Center(
                      child: ErrorState(
                        message: vm.message,
                          onPressed: ()=>vm.fetchNotifications()
                      ),
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

  //refreshes the notification screen
  Future<void> _refresh() async {
    final vm = ref.read(notificationViewModel);
    vm.fetchNotifications(refreshUi: false);
  }

}

class NotificationItem extends StatelessWidget {
  final AppNotification notification;
  final int index;
  const NotificationItem({super.key, required this.notification, required this.index});

  @override
  Widget build(BuildContext context) {
    final message = notification.message ?? 'N/A';
    final title = notification.title ?? 'N/A';
    final timeAgo = DateUtilities.timeAgo(dateTime: notification.createdAt ?? DateTime.now());
    final isRead = notification.readAt != null;
    return Clickable(
      onPressed: (){
        if(!isRead){
          final container =
          ProviderScope.containerOf(context);
          final vm =
          container.read(notificationViewModel);
          vm.markNotificationAsRead(
              id: notification.id,
            index: index
          );

        }
        _handleClick(notification, context);
      },
      child: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.textPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.circle,
                        size: 6,
                        color: Theme.of(context).colorScheme.textPrimary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        timeAgo,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.textSecondary,
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
             message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //handles notification click
  _handleClick(AppNotification notification, BuildContext context){
    final type = notification.type?.toLowerCase() ?? '';
    switch(type){
      case 'order_success':
        pushNavigation(context: context, widget: PaymentReceipt(
          orderId: notification.orderId,
        ), routeName: NamedRoutes.paymentReceipt);
      case 'game_end':
      case 'draw_end':
      case 'draw_win':
        pushNavigation(context: context, widget: GameTickets(id: notification.uuid), routeName: NamedRoutes.gameTickets);
      case 'game_create':
        pushNavigation(context: context, widget: WithScope(
          overrides: [
            gameIdProvider.overrideWithValue(notification.gameId ?? ''),
          ],
          child: GameDetails(
          ),
        ), routeName: NamedRoutes.gameDetails);
      default:
        return;
    }
  }


}
