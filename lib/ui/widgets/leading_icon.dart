import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_asset.dart';
import '../../core/constants/color_path.dart';
import 'clickable.dart';
import 'custom_svg.dart';


class LeadingIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool addPadding;
  final bool show;

  const LeadingIcon(
      {super.key, this.onPressed, this.addPadding = true, this.show = false});

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    if (canPop) {
      return GestureDetector(
        onTap: onPressed ?? () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: SizedBox(
            height: 50.h,
            width: 30.w,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 32.h,
                  width: 32.w,
                  decoration: const BoxDecoration(
                      color: ColorPath.athensGrey7,
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new, color: ColorPath.grayGrey,
                      size: 13.w,),
                  ),
                )
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
