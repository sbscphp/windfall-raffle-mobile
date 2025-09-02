import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/enum/otp_type.dart';
import 'package:windfall/core/data/view_models/authentication_vms/otp_vm.dart';
import 'package:windfall/core/data/view_models/profile_vms/profile_vm.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/authentication/create_password.dart';
import 'package:windfall/ui/pages/authentication/otp.dart';
import 'package:windfall/ui/pages/profile/change_password.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/screen_title.dart';
import 'package:windfall/ui/widgets/show_flush_bar.dart';
import 'package:windfall/ui/widgets/windfall_container.dart';

import '../../../core/data/enum/view_state.dart';

class AccountSecurity extends ConsumerWidget {
  const AccountSecurity({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpVm = ref.watch(otpViewModel);
    return BusyOverlay(
      show: otpVm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(context: context, title: 'Settings'),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: AppDimension.paddingTop,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              ScreenTitle(
                title: "Account Security",
                subTitle: "Manage your account security with ease.",
                subTitleSize: 12.sp,
              ),
              SizedBox(height: 24.h),
              WindfallContainer(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSvg(
                          asset: AppAsset.security,
                          height: 28.h,
                          width: 28.w,
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Account Security",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Keep your account safe by regularly updating your password. Choose a strong, unique password to protect your personal information and raffle activity",
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      height: 1.25,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.textTertiary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    CustomButton(
                      onPressed: () async{

                        final email = ref.read(profileViewModel).email;

                        await otpVm.sendOtp(
                            otpType: OtpType.resetPassword,
                            key: 'email_or_phone',
                            value: email
                        );

                        if(otpVm.state == ViewState.retrieved){
                          pushNavigation(
                              context: context,
                              widget: Otp(otpType: OtpType.resetPassword, identifier: email),
                            routeName: NamedRoutes.otp
                          );
                        }else{
                          showFlushBar(
                              context: context,
                              message: otpVm.message,
                            success: false
                          );
                        }



                        // pushNavigation(
                        //   context: context,
                        //   widget: ChangePassword(),
                        //   routeName: NamedRoutes.changePassword,
                        // );
                      },
                      // buttonText: "Change Password",
                      useDottedBorder: true,
                      bgColor: ColorPath.blackyBlack,
                      childWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Change Password",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.whiteText,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          SizedBox(width: 6.w),
                          CustomSvg(
                            asset: AppAsset.security3,
                            height: 18.h,
                            width: 18.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
