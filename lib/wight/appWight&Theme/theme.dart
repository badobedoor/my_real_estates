import 'package:flutter/material.dart';

/*
 * this is our app's theme , you can add any color here in both of dark and light theme and it will change directly in the app
 * the call of this class is in the [main.dart]
 * also we specify the theme type [dark] of [light] by adding [ThemeMode] in [main.dart] 
 */

class AppColors {
  AppColors._();
  // static final orange = Color.alphaBlend(Color(0xffFEC400), Color(0xffE56E00));
  static Color grey5 = const Color(0xFA656565);
  static final orange =
      Color.lerp(const Color(0xffFEC400), const Color(0xffE56E00), 0.3);
  static Color black = const Color(0xff151515);
  static Color white = const Color(0xffFFFFFF);
  static Color offwhite = const Color(0xffF4F4F4);
  static Color blue = const Color(0xff264D8F);

  static Color grey100 = const Color(0xffA4A4A4);
  static Color grey200 = const Color(0xff605959);
  static Color grey3 = const Color(0xff7F7F7F);
  static Color grey4 = const Color(0xffC4C4C4);
  static Color red = const Color(0xffFF0000);
  static Color transparent = const Color(0x00000000);
  static Color grey = const Color(0xffD4D4D4);
  static Color greenSwitch = const Color(0xff0AA107);
  static Color helpColor = const Color(0xffF8F8F8);
//new
  static final bluePurple =
      Color.lerp(const Color(0xff6E52FC), const Color(0xff52A0F8), 0.1);
  static Color lightblue = const Color(0xff52A0F8);
  static Color darkblue = const Color(0xff1B222E);
  static Color pink = const Color(0xffFF5A79);
  static Color purple = const Color(0xff6E52FC);
  static Color blue100 = const Color(0xff596A83);
  static Color green = const Color(0xff4AE347);
}

class AppTheme {
  AppTheme._();
  static final light = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Tajawal',
    primaryColor: AppColors.orange,
    scaffoldBackgroundColor: AppColors.blue100,
    backgroundColor: AppColors.blue100,
    // accentColor: AppColors.orange,
    canvasColor: Colors.transparent,
    colorScheme: const ColorScheme.light(),
    iconTheme: IconThemeData(color: AppColors.black, size: 30),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) => AppColors.black),
    ),
    toggleableActiveColor: AppColors.black,
    popupMenuTheme: PopupMenuThemeData(
      color: AppColors.grey200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.black,
      selectionColor: AppColors.grey,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateColor.resolveWith((states) => AppColors.orange!),
      fillColor: MaterialStateColor.resolveWith(
        (states) => AppColors.transparent,
      ),
    ),
  );
}
