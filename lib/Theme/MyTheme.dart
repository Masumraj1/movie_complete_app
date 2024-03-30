

import 'package:flutter/material.dart';

class MyTheme{
  static const Color blackColor = Color(0xFF121312);
  static const Color primaryLight =  Color(0xFF1A1A1A);
  static const Color containerColor =  Color(0xFF282A28);
  static const Color whiteColor = Color(0xFFffffff);
  static const Color yellowColor = Color(0xFFFFBB3B);


  static ThemeData Themes = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryLight,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30
      ),
      centerTitle: true,
      titleSpacing: 2,
      titleTextStyle: TextStyle(color: Colors.white)
    ),
    scaffoldBackgroundColor: blackColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: primaryLight, // Set the background color here
      selectedItemColor: yellowColor,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(size: 32, color: yellowColor),
    ),
    colorScheme: ColorScheme.fromSeed(
      background:blackColor ,
      seedColor: Colors.black,
      primary: containerColor,
      secondary: primaryLight,
      onPrimary: whiteColor,
      onSecondary: Colors.white,
    ),
    //useMaterial3: true,
  );
}