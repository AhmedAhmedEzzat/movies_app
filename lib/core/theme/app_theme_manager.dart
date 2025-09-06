import 'package:flutter/material.dart';

import 'color_pallete.dart';

abstract class AppThemeManager {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ColorPallete.primaryColor,

    scaffoldBackgroundColor: ColorPallete.backgroundColor,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: ColorPallete.primaryColor),

      titleTextStyle: TextStyle(
        color: ColorPallete.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',

      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorPallete.primaryColor,
      unselectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,

      selectedIconTheme: IconThemeData(color: ColorPallete.primaryColor),
      unselectedIconTheme: IconThemeData(color: Colors.white),

    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontFamily: 'Roboto',
      ),
    ),
  );
}
