import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/authentication/create_password.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_svg.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  final _otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Clickable(
      onPressed: ()=>Utilities.hideKeyboard(context),
      child: Scaffold(
        appBar: customAppBar(
            context: context,
            title: 'Otp'
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
                        CustomSvg(asset: AppAsset.emailVerification, height: 40.h, width: 40.w,),
                        SizedBox(height: 16.h,),
                        Text(
                          "Email Verification",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: ColorPath.redOrange,
                          ),
                        ),
                        SizedBox(height: 5.h,),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: colorScheme.textSecondary
                            ),
                            children: [
                              const TextSpan(
                                text: 'We have sent a six-digit verification code to ',
                              ),
                              TextSpan(
                                text: 'juwon****gmail.com',
                                style: textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:colorScheme.textPrimary
                                ),
                              ),
                              const TextSpan(
                                text: '. Enter code to continue account setup',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 48.h,),
                        PinCodeTextField(
                          length: 6,
                          controller: _otp,
                          mainAxisAlignment: MainAxisAlignment.center,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 16.w,);
                          },
                          obscureText: false,
                          animationType: AnimationType.fade,
                          backgroundColor: Colors.transparent,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.number,
                          cursorColor: colorScheme.textPrimary,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
      
                          pinTheme: PinTheme(
                            disabledColor: Colors.transparent,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.all(Radius.circular(10.r)),
                            fieldHeight: 40.h,
                            fieldWidth: 40.w,
                            inactiveColor: colorScheme.pinCodeInactiveBorderColor,
                            activeColor: colorScheme.pinCodeActiveBorderColor,
                            borderWidth: 1.w,
                            selectedColor: colorScheme.pinCodeInactiveBorderColor,
                            selectedFillColor: colorScheme.pinCodeInactiveFillColor,
                            inactiveFillColor: colorScheme.pinCodeInactiveFillColor,
                            activeFillColor: colorScheme.pinCodeActiveFillColor,
      
                          ),
                          textStyle: textTheme.titleMedium?.copyWith(
                            //fontSize: 31.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorPath.redOrange
                          ),
                          enabled: true,
                          appContext: context,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          onCompleted: (v) {
                            debugPrint("Completed: $v");
                          },
                          onChanged: (value) {
                            //model.otp = value;
                          },
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: colorScheme.text5
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Code Expires in ',
                                ),
                                TextSpan(
                                  text: '15:00',
                                  style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color:ColorPath.redOrange
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive Code? ",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textTertiary
                              ),
                            ),
                            Clickable(
                              onPressed: (){},
                              child: Text(
                                "Resend OTP",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorPath.redOrange,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorPath.redOrange
                                ),
                              ),
                            ),
                          ],
                        ),
      
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h,),
                CustomButton(
                    useDottedBorder: true,
                    buttonText:'Verify Otp',
                    onPressed: (){
                      pushNavigation(context: context, widget: const CreatePassword(), routeName: NamedRoutes.createPassword);
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
