import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:project/core/constants/app_keys.dart';
import 'package:project/core/constants/app_strings.dart';


class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  Future<void> changeTheme(ThemeMode newMode) async {
    emit(newMode);// when emit state the method toJson will call with the new state
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {  // this map json from toJson method
    if (json[AppKeys.themeMode] == AppStrings.light) {
      return ThemeMode.light;
    } else if (json[AppKeys.themeMode] == AppStrings.dark) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) { // toJson automatically store in local storage and return a map 
    if (state == ThemeMode.light) {
      return {
        AppKeys.themeMode: AppStrings.light,
      };
    } else if (state == ThemeMode.dark) {
      return {
        AppKeys.themeMode: AppStrings.dark,
      };
    } else {
      return {
        AppKeys.themeMode: AppStrings.system,
      };
    }
  }
}
