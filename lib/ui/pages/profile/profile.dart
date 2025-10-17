import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/authentication_vms/login_vm.dart';
import 'package:windfall/core/data/view_models/bottom_nav_view_model.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/profile/game_results.dart';
import 'package:windfall/ui/pages/profile/notifications.dart';
import 'package:windfall/ui/pages/profile/order/order_history.dart';
import 'package:windfall/ui/pages/profile/personal_information.dart';
import 'package:windfall/ui/pages/profile/rewards.dart';
import 'package:windfall/ui/pages/profile/settings.dart';
import 'package:windfall/ui/widgets/custom_divider.dart';
import 'package:windfall/ui/widgets/guest_message.dart';
import 'package:windfall/ui/widgets/profile/profile_action.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/view_models/profile_vms/profile_vm.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_painter/dotted_border.dart';
import '../../widgets/display_image.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final bottomNavVm = ref.watch(bottomNavViewModel);
    final loginVm = ref.watch(loginViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        showLeadingIcon: false,
        title: 'My Profile',
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: 20.h,
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight
        ),
        child: Builder(
          builder: (context) {
            if(loginVm.isLoggedIn){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child){
                      final profileVm = ref.watch(profileViewModel);
                      if(profileVm.hasImage){
                        final imageProvider = CachedNetworkImageProvider(profileVm.image);
                        precacheImage(imageProvider, context);
                      }
                      return Row(
                        children: [
                          CustomPaint(
                            painter: DottedBorder(
                                color: ColorPath.redOrange,
                                isCircle: true
                            ),
                            child: DisplayImage(
                              size: 54,
                              borderWidth: 0,
                              image: profileVm.image,
                              useGradient:  false,
                              borderColor: Theme.of(context).colorScheme.whiteText,
                              firstName: profileVm.firstname,
                              lastName: profileVm.lastname,
                              fontSize: 24.sp,
                            ),
                          ),
                          SizedBox(width: 19.w,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${profileVm.firstname} ${profileVm.lastname} 🌹',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).colorScheme.brandColor
                                  ),
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  'ID: ${profileVm.uniqueId}🚀',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textTertiary
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 32.h,),
                  Text(
                    'My Profile',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                  SizedBox(height: 24.h,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WindfallContainer(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileAction(
                                      imageAsset: AppAsset.personalInformation,
                                      label: "Personal Information",
                                      onPressed: (){
                                        pushNavigation(context: context, widget: PersonalInformation(),routeName: NamedRoutes.personalInfo);
                                      }
                                  ),
                                  CustomDivider(
                                    verticalSpace: 16.h,
                                  ),
                                  ProfileAction(
                                      imageAsset: AppAsset.ticketsLeft,
                                      label: "My Games",
                                      onPressed: (){
                                        bottomNavVm.setCurrentIndex(2);
                                      }
                                  ),
                                  CustomDivider(
                                    verticalSpace: 16.h,
                                  ),
                                  ProfileAction(
                                      imageAsset: AppAsset.results,
                                      label: "Result",
                                      onPressed: (){
                                        pushNavigation(context: context, widget: const GameResults(), routeName: NamedRoutes.gameResults);
                                      }
                                  ),
                                  CustomDivider(
                                    verticalSpace: 16.h,
                                  ),
                                  ProfileAction(
                                      imageAsset: AppAsset.rewards,
                                      label: "Rewards",
                                      onPressed: (){
                                        pushNavigation(context: context, widget: const Rewards(), routeName: NamedRoutes.rewards);
                                      }
                                  ),
                                  CustomDivider(
                                    verticalSpace: 16.h,
                                  ),
                                  ProfileAction(
                                      imageAsset: AppAsset.transactions,
                                      label: "Order History",
                                      onPressed: (){
                                        pushNavigation(context: context, widget: const OrderHistory(), routeName: NamedRoutes.orderHistory);
                                      }
                                  ),
                                  CustomDivider(
                                    verticalSpace: 16.h,
                                  ),
                                  ProfileAction(
                                      imageAsset: AppAsset.notifications,
                                      label: "Notifications",
                                      onPressed: (){
                                        pushNavigation(context: context, widget: Notifications(),routeName: NamedRoutes.notifications);
                                      }
                                  ),
                                  CustomDivider(
                                    verticalSpace: 16.h,
                                  ),
                                  ProfileAction(
                                      imageAsset: AppAsset.settings,
                                      label: "Settings",
                                      onPressed: (){
                                        pushNavigation(context: context, widget: Settings(),routeName: NamedRoutes.settings);

                                      }
                                  ),

                                ],
                              )
                          )


                        ],
                      ),
                    ),
                  )

                ],
              );
            }

            return Center(
              child: GuestMessage(
                visitingRoute: NamedRoutes.bottomNav,
              ),
            );
          }
        ),
      ),
    );
  }
}
