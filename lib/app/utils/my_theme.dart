import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class MyTheme {
  //-------------------[Colors]----------------------
  static Color white = Colors.white;
  static Color blue = Colors.blue.shade800;

  //-------------------[TextStyle]----------------------
  static TextStyle poppinsNormal(
      {FontStyle? fontStyle,
      Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      double? letterSpacing,
      TextDecoration? decoration,
      double? spacing}) {
    return GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: fontSize != null ? Get.height * fontSize : Get.height * .015,
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: letterSpacing,
        decoration: decoration);
  }

  static TextStyle poppinsBold(
      {FontStyle? fontStyle,
      Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      double? letterSpacing,
      TextDecoration? decoration,
      double? spacing}) {
    return GoogleFonts.poppins(
        color: color ?? Colors.black,
        fontSize: fontSize != null ? Get.height * fontSize : Get.height * .018,
        fontWeight: fontWeight ?? FontWeight.w700,
        letterSpacing: letterSpacing,
        decoration: decoration);
  }

  //-------------------[Padding]----------------------
  static EdgeInsets symmetricPadding({double? width, double? height}) {
    return EdgeInsets.symmetric(
        horizontal: width == null ? Get.width * .05 : Get.width * width,
        vertical: height == null ? Get.height * .0 : Get.height * height);
  }

  static EdgeInsets allPadding(
      {double? left, double? right, double? top, double? bottom}) {
    return EdgeInsets.only(
        left: left == null ? Get.width * .0 : Get.width * left,
        right: right == null ? Get.height * .0 : Get.width * right,
        top: top == null ? Get.height * .0 : Get.height * top,
        bottom: bottom == null ? Get.height * .0 : Get.height * bottom);
  }

  //-------------------[For Space]----------------------
  static SizedBox space({double? height, double? width}) {
    return SizedBox(
      height: height == null ? 0 : Get.height * height,
      width: width == null ? 0 : Get.width * width,
    );
  }
}
