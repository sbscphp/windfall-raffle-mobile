import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/authentication_vms/password_vm.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/authentication_vms/otp_vm.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/authentication/password_requirement.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/show_flush_bar.dart';

class CreatePassword extends ConsumerStatefulWidget {
  const CreatePassword({super.key});

  @override
  ConsumerState<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends ConsumerState<CreatePassword> {

  bool _hidePwd = true;
  bool _hideConfirmPwd = true;

  final _formKey = GlobalKey<FormState>();
  final _pwd = TextEditingController();
  final _confirmPwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(passwordViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
            context: context,
            title: 'Set New Password'
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: AppDimension.paddingTop,
                bottom: 63.5.h,
                left: AppDimension.paddingLeft,
                right: AppDimension.paddingRight
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSvg(asset: AppAsset.createPassword, height: 40.h, width: 40.w,),
                          SizedBox(height: 16.h,),
                          ScreenTitle(
                              title: 'Create New Password ',
                              titleColor: ColorPath.redOrange,
                              subTitle: 'Enter a New Password different from previously used password '
                          ),
                          SizedBox(height: 24.h,),
                          CustomTextField(
                            label: 'New Password',
                            hintText: 'Enter your password',
                            obscure: _hidePwd,
                            controller: _pwd,
                            validator: FieldValidator.validate,
                            keyboardType: TextInputType.text,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 16.w, left: 16.w),
                              child: Clickable(
                                onPressed: (){
                                  setState(() {
                                    _hidePwd= !_hidePwd;
                                  });
                                },
                                child: CustomSvg(
                                  asset:  _hidePwd
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
                            onChanged: (value) => vm.checkPassWordRequirement(password: _pwd.text),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: PasswordRequirement(),
                          ),
                          SizedBox(height: 32.h,),
                          CustomTextField(
                            label: 'Confirm Password',
                            hintText: 'Confirm your password',
                            obscure: _hideConfirmPwd,
                            controller: _confirmPwd,
                            validator: FieldValidator.validate,
                            keyboardType: TextInputType.text,
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 16.w, left: 16.w),
                              child: Clickable(
                                onPressed: (){
                                  setState(() {
                                    _hideConfirmPwd= !_hideConfirmPwd;
                                  });
                                },
                                child: CustomSvg(
                                  asset:  _hideConfirmPwd
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
                ),
                SizedBox(height: 20.h,),
                CustomButton(
                    useDottedBorder: true,
                    buttonText:'Create New Password',
                    onPressed: ()async{

                      final validate = _formKey.currentState!.validate();
                      if(validate){

                        await vm.createNewPassword(
                            pwd: _pwd.text,
                            confirmPwd: _confirmPwd.text,
                            userId: ref.read(otpViewModel).userId
                        );

                        if(vm.state == ViewState.retrieved){
                          popUntilNavigation(context: context, route: NamedRoutes.login);
                        }

                        showFlushBar(
                          context: context,
                          message: vm.message,
                          success: vm.state == ViewState.retrieved
                        );

                      }

                    }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
