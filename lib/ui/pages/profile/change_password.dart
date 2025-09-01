import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/color_path.dart';
import 'package:windfall/core/data/view_models/authentication_vms/password_vm.dart';
import 'package:windfall/core/utilities/validator.dart';
import 'package:windfall/ui/widgets/authentication/password_requirement.dart';
import 'package:windfall/ui/widgets/body_header.dart';
import 'package:windfall/ui/widgets/bottom_sheets/base_bottom_sheet.dart';
import 'package:windfall/ui/widgets/bottom_sheets/custom_bottom_sheet.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_button.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';
import 'package:windfall/ui/widgets/custom_text_field.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  bool _hidePwd = true;
  bool _hideConfirmPwd = true;

  final _pwd = TextEditingController();
  final _confirmPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(passwordViewModel);
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Settings'),
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyHeader(
              child: ScreenTitle(
                title: "Account Security: ",
                titleSize: 16.sp,
                subTitleSize: 12.sp,
                titleExtension: "Change your Password",
                subTitle: "Create a new password to secure your account.",
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: AppDimension.paddingTop,
                  bottom: 63.5.h,
                  left: AppDimension.paddingLeft,
                  right: AppDimension.paddingRight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenTitle(
                      title: "Create New Password ",
                      subTitle: "Enter your New Password below",
                    ),
                    SizedBox(height: 24.h),
                    CustomTextField(
                      label: 'Enter your old Password',
                      hintText: 'Enter your old Password',
                      obscure: _hideConfirmPwd,
                      controller: _confirmPwd,
                      validator: FieldValidator.validate,
                      keyboardType: TextInputType.text,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 16.w, left: 16.w),
                        child: Clickable(
                          onPressed: () {
                            setState(() {
                              _hideConfirmPwd = !_hideConfirmPwd;
                            });
                          },
                          child: CustomSvg(
                            asset: _hideConfirmPwd
                                ? AppAsset.pwdHidden
                                : AppAsset.pwdVisible,
                            height: 16.h,
                            width: 16.w,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.textFieldSuffixIcon,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomTextField(
                      label: 'Enter New Password',
                      hintText: 'Enter your password',
                      obscure: _hidePwd,
                      controller: _pwd,
                      validator: FieldValidator.validate,
                      keyboardType: TextInputType.text,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 16.w, left: 16.w),
                        child: Clickable(
                          onPressed: () {
                            setState(() {
                              _hidePwd = !_hidePwd;
                            });
                          },
                          child: CustomSvg(
                            asset: _hidePwd
                                ? AppAsset.pwdHidden
                                : AppAsset.pwdVisible,
                            height: 16.h,
                            width: 16.w,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.textFieldSuffixIcon,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      onChanged: (value) =>
                          vm.checkPassWordRequirement(password: _pwd.text),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6.h),
                      child: PasswordRequirement(),
                    ),
                    SizedBox(height: 32.h),
                    CustomTextField(
                      label: 'Confirm New Password',
                      hintText: 'Confirm your password',
                      obscure: _hideConfirmPwd,
                      controller: _confirmPwd,
                      validator: FieldValidator.validate,
                      keyboardType: TextInputType.text,
                      suffixIcon: Padding(
                        padding: EdgeInsets.only(right: 16.w, left: 16.w),
                        child: Clickable(
                          onPressed: () {
                            setState(() {
                              _hideConfirmPwd = !_hideConfirmPwd;
                            });
                          },
                          child: CustomSvg(
                            asset: _hideConfirmPwd
                                ? AppAsset.pwdHidden
                                : AppAsset.pwdVisible,
                            height: 16.h,
                            width: 16.w,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.textFieldSuffixIcon,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(
                left: AppDimension.paddingLeft,
                right: AppDimension.paddingRight,
              ),
              child: CustomButton(
                useDottedBorder: true,
                buttonText: 'Create New Password',
                onPressed: () {
                  //otp validation
                  baseBottomSheet(
                    context: context,
                    content: CustomBottomSheet(
                      title: "OTP Validated ",
                      subTitle:
                          "Congratulation, OTP has been successfully validated. Your password change is complete.",
                      firstbuttonText: "Continue",
                      asset: Image.asset(
                        AppAsset.warning,
                        height: 100.h,
                        width: 100.w,
                      ),
                      showSecondButton: false,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
