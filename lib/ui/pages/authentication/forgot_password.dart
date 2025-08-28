import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/authentication_vms/otp_vm.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/authentication/otp.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/otp_type.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/utilities/utilities.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_title.dart';
import '../../widgets/show_flush_bar.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {

  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(otpViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
            context: context,
            title: 'Forgot Password'
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
                          ScreenTitle(
                              title: 'Reset Password',
                              titleColor: ColorPath.redOrange,
                              subTitle: 'Enter the email linked to your Account'
                          ),
                          SizedBox(height: 32.h,),
                          CustomTextField(
                            label: 'Your Email Address',
                            hintText: 'example@email.com',
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: EmailValidator.validateEmail,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                CustomButton(
                    useDottedBorder: true,
                    buttonText:'Send Otp',
                    onPressed: ()async{

                      final validate = _formKey.currentState!.validate();
                      if(validate){

                        Utilities.hideKeyboard(context);

                        await vm.sendOtp(
                            otpType: OtpType.forgotPassword,
                            key: 'username',
                            value: _email.text
                        );

                        if(vm.state == ViewState.retrieved){
                          pushNavigation(context: context, widget: Otp(
                             identifier: _email.text,
                            otpType: OtpType.forgotPassword,
                          ), routeName: NamedRoutes.otp);
                        }else{
                          showFlushBar(
                              context: context,
                              message: vm.message,
                              success: false
                          );
                        }
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
