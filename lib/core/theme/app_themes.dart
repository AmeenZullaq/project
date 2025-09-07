import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/core/theme/app_colors.dart';

class AppThemes {
  const AppThemes._();

  static ThemeData lightTheme = ThemeData(
    // Basic Theme Properties
    brightness: Brightness.light,
    useMaterial3: true,

    // Color Properties
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.green,
    canvasColor: Colors.white,
    cardColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    dividerColor: Colors.grey.shade300,
    disabledColor: Colors.grey.shade400,
    hintColor: Colors.grey.shade600,
    focusColor: AppColors.green,
    hoverColor: AppColors.green,
    highlightColor: AppColors.green.withValues(alpha: 0.2),
    splashColor: AppColors.green.withValues(alpha: 0.3),
    unselectedWidgetColor: Colors.grey.shade600,
    secondaryHeaderColor: Colors.grey.shade50,

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.light,
      primary: AppColors.green,
      onPrimary: Colors.white,
      secondary: Colors.grey.shade600,
      onSecondary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black87,
      error: Colors.red.shade600,
      onError: Colors.white,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16.w,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: Colors.black87,
        size: 24.sp,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black87,
        size: 24.sp,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(
      color: Colors.black87,
      size: 24.sp,
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.white,
      size: 24.sp,
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        splashFactory: InkRipple.splashFactory,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        splashFactory: InkRipple.splashFactory,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.green,
        side: BorderSide(color: AppColors.green, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        splashFactory: InkRipple.splashFactory,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.green, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.red.shade600),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.red.shade600, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.green,
      foregroundColor: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      splashColor: Colors.white.withValues(alpha: 0.4),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.green,
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle:
          TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.green,
      unselectedLabelColor: Colors.grey.shade600,
      indicatorColor: AppColors.green,
      labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      splashFactory: InkRipple.splashFactory,
      overlayColor:
          WidgetStateProperty.all(AppColors.green.withValues(alpha: 0.2)),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      splashRadius: 20.r,
      overlayColor:
          WidgetStateProperty.all(AppColors.green.withValues(alpha: 0.2)),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        }
        return Colors.grey.shade600;
      }),
      splashRadius: 20.r,
      overlayColor:
          WidgetStateProperty.all(AppColors.green.withValues(alpha: 0.2)),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        }
        return Colors.grey.shade400;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green.withValues(alpha: 0.5);
        }
        return Colors.grey.shade300;
      }),
      overlayColor:
          WidgetStateProperty.all(AppColors.green.withValues(alpha: 0.2)),
      splashRadius: 20.r,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade300,
      thickness: 1,
      space: 1,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: AppColors.green.withValues(alpha: 0.1),
      iconColor: Colors.grey.shade600,
      textColor: Colors.black87,
      selectedColor: AppColors.green,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    // Basic Theme Properties
    brightness: Brightness.dark,
    useMaterial3: true,

    // Color Properties
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: AppColors.green,
    canvasColor: const Color(0xFF1E1E1E),
    cardColor: const Color(0xFF1E1E1E),
    dialogBackgroundColor: const Color(0xFF2D2D2D),
    dividerColor: Colors.grey.shade700,
    disabledColor: Colors.grey.shade600,
    hintColor: Colors.grey.shade400,
    focusColor: AppColors.green,
    hoverColor: AppColors.green,
    highlightColor: AppColors.green.withValues(alpha: 0.3),
    splashColor: AppColors.green.withValues(alpha: 0.4),
    unselectedWidgetColor: Colors.grey.shade400,
    secondaryHeaderColor: const Color(0xFF2D2D2D),

    // Color Scheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.green,
      brightness: Brightness.dark,
      primary: AppColors.green,
      onPrimary: Colors.black,
      secondary: Colors.grey.shade400,
      onSecondary: Colors.black,
      surface: const Color(0xFF1E1E1E),
      onSurface: Colors.white70,
      error: Colors.red.shade400,
      onError: Colors.black,
    ),

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      foregroundColor: Colors.white70,
      elevation: 0,
      scrolledUnderElevation: 1,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 16.w,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white70,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: Colors.white70,
        size: 24.sp,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white70,
        size: 24.sp,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF121212),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      displayMedium: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      displaySmall: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      headlineLarge: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      headlineSmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      titleSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white54,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white70,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white54,
      ),
    ),

    // Icon Theme
    iconTheme: IconThemeData(
      color: Colors.white70,
      size: 24.sp,
    ),
    primaryIconTheme: IconThemeData(
      color: Colors.black,
      size: 24.sp,
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.green,
        foregroundColor: Colors.black,
        elevation: 4,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        splashFactory: InkRipple.splashFactory,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        splashFactory: InkRipple.splashFactory,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.green,
        side: BorderSide(color: AppColors.green, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        splashFactory: InkRipple.splashFactory,
      ),
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2D2D2D),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.green, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.red.shade400, width: 2),
      ),
      labelStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    ),

    // Card Theme
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 4,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.green,
      foregroundColor: Colors.black,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      splashColor: Colors.black.withValues(alpha: 0.4),
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: AppColors.green,
      unselectedItemColor: Colors.grey.shade400,
      selectedLabelStyle:
          TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.green,
      unselectedLabelColor: Colors.grey.shade400,
      indicatorColor: AppColors.green,
      labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      splashFactory: InkRipple.splashFactory,
      overlayColor:
          WidgetStateProperty.all(AppColors.green.withValues(alpha: 0.3)),
    ),

    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      splashRadius: 20.r,
      overlayColor:
          WidgetStateProperty.all(AppColors.green.withValues(alpha: 0.3)),
    ),

    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        }
        return Colors.grey.shade400;
      }),
      splashRadius: 20.r,
      overlayColor:
          WidgetStateProperty.all(AppColors.green.withValues(alpha: 0.3)),
    ),

    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green;
        }
        return Colors.grey.shade600;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.green.withValues(alpha: 0.5);
        }
        return Colors.grey.shade700;
      }),
      overlayColor:
          WidgetStateProperty.all(AppColors.green.withValues(alpha: 0.3)),
      splashRadius: 20.r,
    ),

    // Divider Theme
    dividerTheme: DividerThemeData(
      color: Colors.grey.shade700,
      thickness: 1,
      space: 1,
    ),

    // List Tile Theme
    listTileTheme: ListTileThemeData(
      tileColor: Colors.transparent,
      selectedTileColor: AppColors.green.withValues(alpha: 0.2),
      iconColor: Colors.grey.shade400,
      textColor: Colors.white70,
      selectedColor: AppColors.green,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
  );
}
