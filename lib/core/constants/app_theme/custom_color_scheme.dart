import 'package:flutter/material.dart';
import '../color_path.dart';



extension CustomColorScheme on ColorScheme {
  // Custom text color variants

  //brand
  Color get brandColor => brightness == Brightness.light ? ColorPath.redOrange : Colors.white;


  //text
  Color get blackText => brightness == Brightness.light ? Colors.black : Colors.white;
  Color get whiteText => brightness == Brightness.light ? Colors.white : Colors.black;
  Color get textPrimary => brightness == Brightness.light ? ColorPath.shaftBlack : Colors.white;
  Color get textSecondary => brightness == Brightness.light ? ColorPath.grayGrey : Colors.white;
  Color get textTertiary => brightness == Brightness.light ? ColorPath.scorpionGrey : Colors.white;
  Color get text4 => brightness == Brightness.light ? ColorPath.troutGrey : Colors.white;



  //widgets
  //text-field
  Color get textFieldFillColor => brightness == Brightness.light ? whiteText : blackText;
  Color get textFieldLabel => brightness == Brightness.light ? ColorPath.blackyBlack : Colors.white;
  Color get textFieldBorder => brightness == Brightness.light ? ColorPath.mischkaGrey : Colors.white;
  Color get textFieldHint => brightness == Brightness.light ? ColorPath.silverGrey : Colors.white;
  Color get textFieldSuffixIcon => brightness == Brightness.light ? ColorPath.grayGrey : Colors.white;

  //appbar
  Color get appbarTitle => brightness == Brightness.light ? ColorPath.scorpionGrey : Colors.white;
  Color get appbarDivider => brightness == Brightness.light ? ColorPath.athensGrey9 : Colors.white;

  //password requirement widget
  Color get pwdInactive => brightness == Brightness.light ? ColorPath.paleGrey : Colors.white;


}