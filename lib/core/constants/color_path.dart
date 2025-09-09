
import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPath {

  //brand colors
  static const redOrange = Color(0xffFF2F31);


  //other colors
  static const athensGrey = Color(0xffF7F7F9);
  static const athensGrey2 = Color(0xffE7E6EC);
  static const athensGrey3 = Color(0xffFAFAFB);
  static const athensGrey4 = Color(0xffF3F2F5);
  static const athensGrey5 = Color(0xffE4E7EC);
  static const athensGrey6 = Color(0xffF9F9FB);
  static const athensGrey7 = Color(0xffEAECF0);
  static const athensGrey8 = Color(0xffFAFAFB); //scaffold background color for light mode
  static const athensGrey9 = Color(0xffEFEEF2);
  static const athensGrey10 = Color(0xffF2F4F7);
  static const roseWhite = Color(0xffFFF7F7);
  static const grayGrey = Color(0xff818181);
  static const scorpionGrey = Color(0xff575757);
  static const fairPink = Color(0xffFFEAEB);
  static const blackyBlack = Color(0xff030303);
  static const mischkaGrey = Color(0xffD0D5DD);
  static const silverGrey = Color(0xffABABAB);
  static const shaftBlack = Color(0xff2D2D2D);
  static const bitterSweetRed = Color(0xffFF7476);
  static const meadowGreen = Color(0xff12B76A);
  static const paleGrey = Color(0xff667085);
  static const troutGrey = Color(0xff4C4D61);
  static const yourPink = Color(0xffFFBABA);
  static const shipGrey = Color(0xff48464E);
  static const chablisPink = Color(0xffFFF1F1);
  static const hazeGreen = Color(0xff039855);
  static const vesuviusBrown = Color(0xffB54708);
  static const scandalGreen = Color(0xffD1FADF);
  static const dawnBrown = Color(0xffFFFAEB);
  static const frondGreen = Color(0xff4F7A21);
  static const frenchGrey = Color(0xffBABEC6);
  static const cosmosPink = Color(0xffFFD5D6);
  static const bayBlue = Color(0xff3538CD);
  static const solitudeBlue = Color(0xffE0EAFF);
  static const salomieBrown = Color(0xffFEDF89);
  static const whisperGrey = Color(0xffEDEDF6);
  static const wildGrey = Color(0xffF5F5F5);
  static const altoGrey = Color(0xffD5D5D5);
  static const regentGrey = Color(0xff8A94A4);
  static const lisaPink = Color(0xffFF9798);
  static const californiaOrange = Color(0xffF79009);
  static const pippinPink = Color(0xffFFE4E8);
  static const shirazRed = Color(0xffC01048);
  static const foamGreen = Color(0xffECFDF3);
  static const provincialPink = Color(0xffFEF3F2);
  static const thunderbirdRed = Color(0xffB42318);
  static const funGreen = Color(0xff027A48);
  static const fetaGreen = Color(0xffF6FEF9);
  static const shamrockGreen = Color(0xff32D583);
  static const mistGrey = Color(0xff9A999D);
  static const allPortBlue = Color(0xff026AA2);
  static const pattensBlue = Color(0xffE0F2FE);
  static const aliceBlue = Color(0xffF0F9FF);
  static const bambooOrange = Color(0xffDC6803);
  static const toryBlue = Color(0xff0D47A1);
  static const oxfordBlue = Color(0xff344054);


















  static Color dynamicColor(String? hexString) {
    // Return default color if hexString is null or empty
    if (hexString == null || hexString.isEmpty) {
      return redOrange;
    }
    try {
      // Remove the '#' character if it exists
      final hexCode = hexString.replaceAll('#', '');

      // Parse the hexadecimal string to an integer
      return Color(int.parse('FF$hexCode', radix: 16));
    } catch (e) {
      debugPrint('Error parsing color: $e');
      return redOrange;
    }
  }







































}