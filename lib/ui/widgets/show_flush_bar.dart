import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';






showFlushBar({required BuildContext context, String? fontFamily, Color bgColor = Colors.red, required String message, Color messageColor = Colors.white, FlushbarPosition position = FlushbarPosition.TOP, int duration = 3, bool isPersistent = false, bool success = true}) {

  Flushbar(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    backgroundColor: success ? Colors.green : Colors.red, //todo: set color
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    flushbarPosition: position,
    borderRadius: BorderRadius.all(Radius.circular(8.r)),
    borderColor: success ? Colors.green : Colors.red, //todo: set color
    blockBackgroundInteraction: false,
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SvgPicture.asset(
              //   'assets/icons/success_icon.svg',
              //   height: 20.h,
              //   width: 20.w,
              //   colorFilter:ColorFilter.mode(
              //     success ? Colors.green : Colors.red,
              //     BlendMode.srcIn,
              //   ),
              // ),
              // SizedBox(width: 12.w,),
              Expanded(
                child:  Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    //Theme.of(context).colorScheme.textPrimary
                  ),
                ),
              )
            ],
          ),
        ),

      ],
    ),
    duration: isPersistent ? null : Duration(seconds: duration),
  ).show(context);
}