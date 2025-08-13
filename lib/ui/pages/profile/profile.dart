import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/bottom_nav_view_model.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/profile/notification_settings.dart';
import 'package:windfall/ui/pages/profile/notifications.dart';
import 'package:windfall/ui/pages/profile/personal_information.dart';
import 'package:windfall/ui/pages/profile/settings.dart';
import 'package:windfall/ui/widgets/custom_divider.dart';
import 'package:windfall/ui/widgets/profile/profile_action.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_painter/dotted_border.dart';
import '../../widgets/custom_svg.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomPaint(
                  painter: DottedBorder(
                      color: ColorPath.redOrange,
                      isCircle: true
                  ),
                  child: 1 + 1 == 3 ? DisplayImage(
                    size: 54,
                    borderWidth: 0,
                    image: 'https://mir-s3-cdn-cf.behance.net/user/276/888fd91082619909.61d2827bbd7a2.jpg',
                    useGradient:  false,
                    borderColor: Theme.of(context).colorScheme.whiteText,
                    firstName: 'A',
                    lastName: 'D',
                    fontSize: 14.sp,
                  ):Container(
                    height: 54.h,
                    width: 54.w,
                    decoration: BoxDecoration(
                        color: ColorPath.fairPink,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                      child: CustomSvg(asset: AppAsset.avatar),
                    ),
                  ),
                ),
                SizedBox(width: 19.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Damilola Aremu 🌹',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.brandColor
                        ),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        'ID: 9940🚀 ',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textTertiary
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
                                onPressed: (){}
                            ),
                            CustomDivider(
                              verticalSpace: 16.h,
                            ),
                            ProfileAction(
                                imageAsset: AppAsset.rewards,
                                label: "Rewards",
                                onPressed: (){}
                            ),
                            CustomDivider(
                              verticalSpace: 16.h,
                            ),
                            ProfileAction(
                                imageAsset: AppAsset.transactions,
                                label: "Transactions",
                                onPressed: (){}
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
        ),
      ),
    );
  }
}
