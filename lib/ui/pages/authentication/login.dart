import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/authentication/forgot_password.dart';
import 'package:windfall/ui/pages/bottom_nav.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/utilities/validator.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_painter/dotted_border.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/display_image.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _hidePwd = true;

  final _pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
        title: 'Log in'
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
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                            child: 1 + 1 == 2 ? DisplayImage(
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
                                  1 + 1 == 2 ? 'Damilola Aremu 🌹':'Log In',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).colorScheme.brandColor
                                  ),
                                ),
                                SizedBox(height: 5.h,),
                                Text(
                                  'Welcome to WindFall. Play to win today 🚀 ',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 24.h,),
                      CustomTextField(
                        label: 'Your Email Address',
                        hintText: 'example@email.com',
                        //controller: _loginChoice,
                        keyboardType: TextInputType.emailAddress,
                        validator: EmailValidator.validateEmail,
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
                      ),
                      SizedBox(height: 24.h,),
                      Clickable(
                        onPressed: (){
                          pushNavigation(context: context, widget: const ForgotPassword(), routeName: NamedRoutes.forgotPassword);
                        },
                        child: Text(
                         'Forgot password ?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorPath.bitterSweetRed
                          ),
                        ),
                      ),
                      SizedBox(height: 80.h,),
                      CustomButton(
                          useDottedBorder: true,
                          buttonText:'Log in',
                          onPressed: (){
                            pushNavigation(context: context, widget: const BottomNav(), routeName: NamedRoutes.bottomNav);
                          }
                      ),
                      SizedBox(height: 16.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textTertiary
                            ),
                          ),
                          Text(
                            "Sign Up",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorPath.redOrange,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorPath.redOrange
                            ),
                          ),
                        ],
                      )


                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                  child: CustomSvg(asset: AppAsset.biometrics, height: 40.h, width: 40.w,))
            ],
          ),
        ),
      ),
    );
  }
}
