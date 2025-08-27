import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:windfall/core/constants/app_asset.dart';
import 'package:windfall/core/constants/app_dimension.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';
import 'package:windfall/core/utilities/navigator.dart';
import 'package:windfall/ui/widgets/clickable.dart';
import 'package:windfall/ui/widgets/custom_svg.dart';

import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/otp_type.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/authentication_vms/otp_vm.dart';
import '../../../core/data/view_models/authentication_vms/registration_vm.dart';
import '../../../core/utilities/utilities.dart';
import '../count_down_timer.dart';
import '../custom_button.dart';
import '../show_flush_bar.dart';

class EmailVerification extends ConsumerStatefulWidget {
  final OtpType otpType;
  final String identifier;
  const EmailVerification({super.key, required this.otpType, required this.identifier});

  @override
  ConsumerState<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends ConsumerState<EmailVerification> {
  final _otp = TextEditingController();
  late DateTime endTime;
  bool _timerElapsed = false;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  void _resetTimer() {
    setState(() {
      endTime = DateTime.now().add(const Duration(minutes: 1));
      _timerElapsed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final otpVm = ref.watch(otpViewModel);

    return Container(
      margin:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: AppDimension.paddingTop,
          horizontal: AppDimension.paddingRight
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSvg(asset: AppAsset.emailVerification, height: 40.h, width: 40.w,),
                IgnorePointer(
                  ignoring: otpVm.state == ViewState.busy || otpVm.secondState == ViewState.busy,
                  child: Clickable(
                    onPressed: ()=>popNavigation(context: context),
                      child: CustomSvg(asset: AppAsset.close, height: 30.h, width: 30.w,)),
                ),
              ],
            ),
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
                    text: widget.otpType == OtpType.verifyEmail ? widget.identifier:Utilities.cleanPhoneNumber(phoneNumber: widget.identifier),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            CountdownTimer(
              key: ValueKey(endTime), // 👈 ensures it resets
              endTime: endTime,
              builder: (_, time) {
                final minutes = time.minutes.toString().padLeft(2, '0');
                final seconds = time.seconds.toString().padLeft(2, '0');
                return  Align(
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
                          text: '$minutes:$seconds',
                          style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color:ColorPath.redOrange
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onEnd: () {
                setState(() {
                  _timerElapsed = true;
                });
              },
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
                IgnorePointer(
                  ignoring: !_timerElapsed,
                  child: Opacity(
                    opacity: _timerElapsed ? 1 : 0.4,
                    child: Clickable(
                      onPressed: otpVm.state == ViewState.busy ? null : ()async{
                        Utilities.hideKeyboard(context);

                        await otpVm.sendOtp(
                            otpType: widget.otpType,
                            key: widget.otpType == OtpType.verifyEmail ? 'email':'phone_number',
                            value: widget.identifier
                        );

                        if(otpVm.state == ViewState.retrieved){
                          _resetTimer();
                        }

                        showFlushBar(
                            context: context,
                            message: otpVm.message,
                            success: otpVm.state == ViewState.retrieved
                        );
                      },
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
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h,),
            CustomButton(
                useDottedBorder: true,
                showLoader: otpVm.state == ViewState.busy || otpVm.secondState == ViewState.busy,
                buttonText:widget.otpType == OtpType.verifyEmail ? 'Verify Email':'Verify Phone Number',
                onPressed: ()async{

                  Utilities.hideKeyboard(context);

                  await otpVm.validateOtp(
                      otpType: widget.otpType,
                      otp: _otp.text,
                      key: widget.otpType == OtpType.verifyEmail ? 'email':'phone_number',
                      value: widget.identifier
                  );

                  if(otpVm.secondState == ViewState.retrieved){
                    //update verification flag
                    final registrationVm = ref.read(registrationViewModel);
                    widget.otpType == OtpType.verifyEmail
                        ? registrationVm.isEmailVerified = true
                        : registrationVm.isPhoneVerified = true;

                    //close bottom-sheet
                    popNavigation(context: context);
                  }

                  //show message(error or successful)
                  showFlushBar(
                      context: context,
                      message: otpVm.message,
                      success: otpVm.secondState == ViewState.retrieved
                  );

                }
            ),


          ],
        ),
      ),
    );
  }
}
