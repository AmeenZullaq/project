import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/theme/app_colors.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    // fontFamily: 'Monrapo',
    primaryColor: Colors.lightGreen,
    cardColor: Colors.amber,
    dialogBackgroundColor: Colors.white,
    splashColor: Colors.redAccent,
    canvasColor: Colors.white, // like Drawer, bottomsheet, dialog
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 24.sp,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      scrolledUnderElevation: 0,
      titleSpacing: 1,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor:
            SystemUiOverlayStyle.dark.systemNavigationBarColor,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: ThemeData().textTheme.apply(
          bodyColor: Colors.black,
        ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    // fontFamily: 'Monrapo',
    primaryColor: Colors.red,
    cardColor: Colors.amber,
    dialogBackgroundColor: Colors.grey,
    splashColor: Colors.redAccent,
    canvasColor: Colors.grey, // like Drawer, bottomsheet, dialog
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 24.sp,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      scrolledUnderElevation: 0,
      titleSpacing: 1,
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor:
            SystemUiOverlayStyle.dark.systemNavigationBarColor,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: ThemeData().textTheme.apply(
          bodyColor: Colors.white,
        ),
  );
}
