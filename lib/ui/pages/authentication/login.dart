import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/constants/named_routes.dart';
import 'package:windfall/core/data/view_models/authentication_vms/login_vm.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/pages/authentication/forgot_password.dart';
import 'package:windfall/ui/pages/authentication/sign_up.dart';
import 'package:windfall/ui/pages/bottom_nav.dart';
import 'package:windfall/ui/widgets/busy_overlay.dart';
import 'package:windfall/ui/widgets/custom_appbar.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/models/user.dart';
import '../../../core/data/services/navigation_service.dart';
import '../../../core/data/view_models/cart_vm.dart';
import '../../../core/data/view_models/game_vms/my_game_results_vm.dart';
import '../../../core/data/view_models/game_vms/my_games_vm.dart';
import '../../../core/data/view_models/profile_vms/notification_vms/notification_settings_vm.dart';
import '../../../core/data/view_models/profile_vms/profile_vm.dart';
import '../../../core/data/view_models/referral_vm.dart';
import '../../../core/utilities/biometric_utils.dart';
import '../../../core/utilities/secure_storage/secure_storage_utils.dart';
import '../../../core/utilities/utilities.dart';
import '../../../core/utilities/validator.dart';
import '../../../locator.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_painter/dotted_border.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/display_image.dart';
import '../../widgets/show_flush_bar.dart';

class Login extends ConsumerStatefulWidget {
  final bool sessionExpired;
  final String? visitingRoute;
  final String? destinationRoute;
  const Login({super.key, this.sessionExpired = false, this.visitingRoute, this.destinationRoute});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {

  bool _userExist = false;
  User? _savedUser;
  bool _hasImage = false;
  bool _canUseBiometrics = false;
  bool _biometricsEnabled = false;
  String? _savedPassword;
  late bool rememberMe = false;



  bool _hidePwd = true;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void initState() {
    if(widget.sessionExpired){
      _sessionExpiredPrompt();
    }
    _initBiometrics();
    _initLogInDynamics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(loginViewModel);
    final hasVisitingRoute = widget.visitingRoute != null;
    final hasDestinationRoute = widget.destinationRoute != null;
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
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
            child: Form(
              key: _formKey,
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
                                child: _userExist && _hasImage ? DisplayImage(
                                  size: 54,
                                  borderWidth: 0,
                                  image: _savedUser?.avatar ?? '',
                                  useGradient:  false,
                                  borderColor: Theme.of(context).colorScheme.whiteText,
                                  firstName: _savedUser?.firstname ?? '',
                                  lastName: _savedUser?.lastname ?? '',
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
                                      _userExist ? '${_savedUser?.firstname ?? ''} ${_savedUser?.lastname ?? ''} 🌹':'Log In',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).colorScheme.brandColor
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),
                                    FittedBox(
                                      child: Text(
                                        'Welcome to WindFall. Play to win today 🚀 ',
                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.textSecondary
                                        ),
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
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: EmailValidator.validateEmail,
                          ),
                          SizedBox(height: 24.h,),
                          CustomTextField(
                            label: 'Password',
                            hintText: 'Enter your password',
                            obscure: _hidePwd,
                            controller: _password,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              if(_userExist)
                                Flexible(
                                  child: FittedBox(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Not ${_savedUser?.firstname ?? ''} ? ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context).colorScheme.textPrimary,
                                          ),
                                        ),
                                        SizedBox(width: 5.w,),
                                        Clickable(
                                          onPressed: (){
                                            setState(() {
                                              _userExist = false;
                                              //clear text controllers
                                              _email.clear();
                                              _password.clear();

                                              _biometricsEnabled = false;
                                            });
                                          },
                                          child: Text(
                                            'Switch Account',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              decoration: TextDecoration.underline,
                                              decorationColor: ColorPath.redOrange,
                                              color: ColorPath.redOrange,
                                            ),
                                          ),
                                        ),
                                    
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                          SizedBox(height: 80.h,),
                          CustomButton(
                              useDottedBorder: true,
                              buttonText:'Log in',
                              onPressed: ()async{

                                final validate = _formKey.currentState!.validate();

                                if(validate){

                                  //attempt login
                                  await vm.login(
                                      email: _email.text.trim(),
                                      password: _password.text.trim()
                                  );

                                  if(vm.state == ViewState.retrieved){

                                    if(hasVisitingRoute && !hasDestinationRoute){

                                      //fetch user details
                                      fetchUserDetails();


                                      locator<NavigationService>().popUntil(
                                        routeName: widget.visitingRoute!,
                                      );

                                      //show success message
                                      showFlushBar(
                                        context: context,
                                        message: vm.message,
                                      );
                                      return;
                                    }

                                    if(hasVisitingRoute && hasDestinationRoute){

                                      //fetch user details
                                      fetchUserDetails();


                                      locator<NavigationService>().pushAndClearRoutes(
                                          routeName: widget.destinationRoute!,
                                          clearRoute: widget.visitingRoute!
                                      );

                                      //show success message
                                      showFlushBar(
                                        context: context,
                                        message: vm.message,
                                      );
                                      return;
                                    }

                                    //nav user into the app
                                    pushNavigation(context: context, widget: const BottomNav(), routeName: NamedRoutes.bottomNav);

                                  }
                                  else{
                                    //show error message
                                    showFlushBar(
                                        context: context,
                                        message: vm.message,
                                        success: false
                                    );
                                  }

                                }
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
                              Clickable(
                                onPressed: (){
                                  pushNavigation(context: context, widget: SignUp(
                                    visitingRoute: widget.visitingRoute,
                                    destinationRoute: widget.destinationRoute,
                                  ), routeName: NamedRoutes.signUp);
                                },
                                child: Text(
                                  "Sign Up",
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorPath.redOrange,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorPath.redOrange
                                  ),
                                ),
                              ),
                            ],
                          )


                        ],
                      ),
                    ),
                  ),
                  if(_canUseBiometrics && _biometricsEnabled && _userExist)Align(
                    alignment: Alignment.center,
                      child: Clickable(
                        onPressed: ()async{
                          //check if user has saved password
                          if(_savedPassword == null || !_userExist){
                            //prompt user to log in with password
                            showFlushBar(
                                context: context,
                                success: false,
                                message: 'Kindly login with password first to be able to use biometrics',
                                duration: 3
                            );
                            return;
                          }

                          //authenticate with biometrics
                          final authenticate = await BiometricUtils.authenticate(context);
                          if(authenticate != null && authenticate){
                            //login
                            Utilities.hideKeyboard(context);
                            //attempt login
                            await vm.login(
                                email: _email.text.trim(),
                                password: _savedPassword!.trim(),
                            );

                            if(vm.state == ViewState.retrieved){

                              if(hasVisitingRoute && !hasDestinationRoute){

                                //fetch user details
                                fetchUserDetails();


                                locator<NavigationService>().popUntil(
                                  routeName: widget.visitingRoute!,
                                );

                                //show success message
                                showFlushBar(
                                  context: context,
                                  message: vm.message,
                                );
                                return;
                              }

                              if(hasVisitingRoute && hasDestinationRoute){

                                //fetch user details
                                fetchUserDetails();


                                locator<NavigationService>().pushAndClearRoutes(
                                    routeName: widget.destinationRoute!,
                                    clearRoute: widget.visitingRoute!
                                );

                                //show success message
                                showFlushBar(
                                  context: context,
                                  message: vm.message,
                                );
                                return;
                              }

                              //nav user into the app
                              pushNavigation(context: context, widget: const BottomNav(), routeName: NamedRoutes.bottomNav);
                            }
                            else{
                              //show error message
                              showFlushBar(
                                  context: context,
                                  message: vm.message,
                                  success: false
                              );
                            }
                          }
                        },
                          child: CustomSvg(asset: Platform.isAndroid ? AppAsset.biometrics:AppAsset.faceId, height: 40.h, width: 40.w,)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _initLogInDynamics()async{
    //retrieve user from secure storage
    _savedUser = await SecureStorageUtils.retrieveUser();
    _userExist = _savedUser != null;
    if(_userExist){
      _email.text = _savedUser?.email ?? '';
      _hasImage = _savedUser?.avatar?.isNotEmpty ?? false;
    }

    setState(() {});
  }

  _sessionExpiredPrompt(){
    Future.delayed(const Duration(milliseconds: 800),
            (){
          showFlushBar(
              context: context,
              success: false,
              message: 'Session Expired. Kindly Login',
              duration: 5
          );
        });
  }

  _initBiometrics()async{
    _canUseBiometrics = await BiometricUtils.canAuthenticate();
    _biometricsEnabled = await SecureStorageUtils.retrieveBiometricPref();
    _savedPassword = await SecureStorageUtils.retrievePassword();
    setState(() {});
  }

  fetchUserDetails(){
    SchedulerBinding.instance.addPostFrameCallback((_) async{

      final loginVm = ref.read(loginViewModel);
      final myGamesVm = ref.read(myGamesViewModel);
      final myGameResultsVm = ref.read(myGameResultsViewModel);
      final vm = ref.read(referralViewModel);
      ref.read(profileViewModel).user = loginVm.user;
      //fetch cart
      ref.read(cartViewModel).transferCart();
      //fetch my games
      myGamesVm.fetchMyGames();
      //fetch my game results
      myGameResultsVm.fetchMyGameResults();
      ref.read(notificationSettingsViewModel).settings = loginVm.user?.notificationSetting;
      ref.read(referralViewModel).referralCode = loginVm.user?.referralCode ?? '';
      vm.fetchEarnedHistory();
      vm.fetchUsedHistory();

    });
  }
}
