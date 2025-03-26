import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/constants/app_keys.dart';
import 'package:project/core/constants/app_routes.dart';
import 'package:project/core/services/shared_preferences.dart';
import 'package:project/features/main/presentation/screens/main_screen.dart';

class RouterService {
  final bool isUserAuth = false;
  final bool isOnBoardingShown = false;

  GoRouter router = GoRouter(
    // initialLocation: SharedPrefs.getString(AppKeys.initialLocation) ??
    //     AppRoutes.onBoardingScreen,
    initialLocation: AppRoutes.mainScreen,
    routes: [
      GoRoute(
        path: AppRoutes.mainScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: const MainScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),
    ],
  );

  void setInitRoute(String route) {
    SharedPrefs.setString(
      AppKeys.initialLocation,
      route,
    );
  }
}
