import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/core/constants/app_keys.dart';
import 'package:project/core/constants/app_routes.dart';
import 'package:project/core/storage/shared_preferences.dart';
import 'package:project/features/main/presentation/screens/main_screen.dart';

class GoRouterService {
  final GoRouter router = GoRouter(
    // initialLocation: SharedPrefs.getString(AppKeys.initialLocation) ??
    //     AppRoutes.onBoardingScreen,
    initialLocation: AppRoutes.mainScreen,
    debugLogDiagnostics: true, // this enables debug logging in console
    routes: [
      GoRoute(
        // name: AppRoutes.mainScreen,// if we want to use named Navigation we use name insstead of path
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
