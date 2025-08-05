import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/authentication/otp.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/screen_title.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        //controller: _loginChoice,
                        keyboardType: TextInputType.emailAddress,
                        validator: EmailValidator.validateEmail,
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              CustomButton(
                  useDottedBorder: true,
                  buttonText:'Send Otp',
                  onPressed: (){
                    pushNavigation(context: context, widget: const Otp(), routeName: NamedRoutes.otp);
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
