import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:windfall/core/constants/app_theme/custom_color_scheme.dart';

import '../../core/constants/color_path.dart';
import 'leading_icon.dart';

AppBar customAppBar({
  required BuildContext context,
  String? title,
  FontWeight? titleFontWeight,
  double titleSize = 16,
  List<Widget>? actions,
  bool centerTitle = true,
  VoidCallback? leadingIconOnPressed,
  double? appBarElevation,
  final Color? textColor,
  bool useCustomTitleWidget = false,
  Widget? titleWidget,
  bool showLeadingIcon = true,
  double? leadingWidth,
  Widget? leading,
  double? appbarBottomPadding
}){
  final textTheme = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;
  return AppBar(
    leadingWidth: leadingWidth ?? MediaQuery.of(context).size.width / 4.5,
    scrolledUnderElevation: 0,
    centerTitle: centerTitle,
    title: useCustomTitleWidget ? titleWidget :
    title != null ?  Text(
      title,
      style: textTheme.titleSmall?.copyWith(
          fontSize: titleSize.sp,
          fontWeight: titleFontWeight ?? FontWeight.w400,
          color: textColor ?? colorScheme.appbarTitle
      ),
    ):null,
    leading: leading ?? LeadingIcon(
      onPressed: leadingIconOnPressed,
      show: showLeadingIcon,
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(appbarBottomPadding?.h ?? 0.h),
      child: Container(
        color: ColorPath.athensGrey9,
        height: 1.h,
      ),
    ),
    actions: actions,
  );
}

