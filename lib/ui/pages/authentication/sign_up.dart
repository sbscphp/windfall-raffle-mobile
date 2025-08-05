import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/data/view_models/authentication_vms/password_vm.dart';
import 'package:windfall/core/utilities/utilities.dart';
import 'package:windfall/core/utilities/validator.dart';
import 'package:windfall/ui/widgets/authentication/password_requirement.dart';
import 'package:windfall/ui/widgets/bottom_sheets/action_completed.dart';
import 'package:windfall/ui/widgets/bottom_sheets/email_verification.dart';
import 'package:windfall/ui/widgets/screen_title.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/input_formatters/nigerian_phone_number_formatter.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/bottom_sheets/birth_date_selector_view.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_check_box.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/custom_text_field.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {

  bool _hidePwd = true;
  bool _hideConfirmPwd = true;
  
  final _dob = TextEditingController();
  final _pwd = TextEditingController();
  final _confirmPwd = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final pwdVm = ref.read(passwordViewModel);
    return Clickable(
      onPressed: ()=>Utilities.hideKeyboard(context),
      child: Scaffold(
        appBar: customAppBar(
            context: context,
            title: 'Sign Up'
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: AppDimension.paddingTop,
            bottom: 50.h,
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(
                  title: 'Sign up to WindFall',
                  titleColor: ColorPath.redOrange,
                  subTitle: 'Create an account in simple steps today!!'
              ),
              SizedBox(height: 32.h),
              CustomTextField(
                label: 'First Name',
                hintText: 'Enter first name',
                //controller: _loginChoice,
                keyboardType: TextInputType.text,
                validator: FieldValidator.validate,
              ),
              SizedBox(height: 24.h,),
              CustomTextField(
                label: 'Last Name',
                hintText: 'Enter last name',
                //controller: _loginChoice,
                keyboardType: TextInputType.text,
                validator: FieldValidator.validate,
              ),
              SizedBox(height: 24.h,),
              Clickable(
                onPressed: (){
                  baseBottomSheet(
                      context: context,
                      content: BirthdaySelectorView(
                          initialDate: DateFormat("dd-MM-yyyy").tryParse(_dob.text),
                          returningValue: (value){
                            setState(() {
                              //set birthdate text controller
                              _dob.text = value;
                            });
                          })
                  );
                },
                child: CustomTextField(
                  label: 'Date of Birth',
                  hintText: 'Select date of birth',
                  enabled: false,
                  controller: _dob,
                  keyboardType: TextInputType.text,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
                    child: const CustomSvg(
                        asset:AppAsset.calendar),
                  ),
                  //validator: FieldValidator.validate,
                ),
              ),
              SizedBox(height: 24.h,),
              CustomTextField(
                label: 'Your Email Address',
                hintText: 'example@email.com',
                //controller: _loginChoice,
                keyboardType: TextInputType.emailAddress,
                validator: EmailValidator.validateEmail,
              ),
              SizedBox(height:6.h,),
              Align(
                alignment: Alignment.centerRight,
                child: Clickable(
                  onPressed: (){
                    baseBottomSheet(
                        context: context,
                        content: EmailVerification()
                    );
                  },
                  child: 1 + 1 == 3 ? Text(
                    "Verify Email",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorPath.redOrange,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorPath.redOrange
                    ),
                  ):Text(
                    "Email Verified",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorPath.meadowGreen
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h,),
              CustomTextField(
                label: 'Phone Number',
                hintText: '+234 000 000 0000',
                keyboardType: TextInputType.number,
                //controller: _phone,
                //focusNode: _phoneFn,
                validator: FieldValidator.validate,
                onChanged: (value){
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(18),
                  NigerianPhoneNumberFormatter()
                ],
              ),
              SizedBox(height: 24.h,),
              CustomTextField(
                label: 'Password',
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
                onChanged: (value) => pwdVm.checkPassWordRequirement(password: _pwd.text),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: PasswordRequirement(),
              ),
              SizedBox(height: 24.h,),
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
              SizedBox(height: 24.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      height: 24,
                      width: 24,
                      onchanged: (value){
                        //vm.receiveEmailNotification = value;
                      }
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      'I want to receive exclusive offers, raffles update and promo alerts via email. ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.text4
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      height: 24,
                      width: 24,
                      onchanged: (value){
                        //vm.acceptTerms = value;
                      }
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.text4
                          ),
                          children: [
                            const TextSpan(
                              text: 'I have read and agree to the ',
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPath.redOrange
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  // pushNavigation(context: context,
                                  //     widget: const InAppWebView(
                                  //         url: terms,
                                  //         title: 'Privacy Policy'
                                  //     ),
                                  //     routeName: NamedRoutes.inAppWebView
                                  // );
                                },
                            ),
                            const TextSpan(
                              text: ',',
                            ),
                            TextSpan(
                              text: '\nTerms and Game Rules',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPath.redOrange
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  /*pushNavigation(context: context,
                                                      widget: const InAppWebView(
                                                          url: terms,
                                                          title: 'Terms and Game Rules'
                                                      ),
                                                      routeName: NamedRoutes.inAppWebView
                                                  );*/
                                },
                            ),
      
                          ],
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 24.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomCheckBox(
                      height: 24,
                      width: 24,
                      onchanged: (value){
                        //vm.is18yrs = value;
                      }
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      'By creating your account, you acknowledge and confirm that you are at least 18 years old and have read and accept Windfall’s policies relating to age verification.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.textSecondary
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64.h,),
              CustomButton(
                  useDottedBorder: true,
                  buttonText:'Create Account',
                  onPressed: (){
      
                  }
              ),
      
      
            ],
          ),
        ),
      ),
    );
  }
}
