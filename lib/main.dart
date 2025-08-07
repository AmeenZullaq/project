// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:project/core/services/shared_preferences.dart';
// import 'package:project/core/theme/app_themes.dart';
// import 'package:project/core/theme/cubit/theme_cubit.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SharedPrefs.init();
//   await EasyLocalization.ensureInitialized();
//   HydratedBloc.storage = await HydratedStorage.build(
//     storageDirectory: kIsWeb
//         ? HydratedStorage.webStorageDirectory
//         : await getApplicationDocumentsDirectory(),
//   );
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en'), Locale('ar')],
//       path: 'assets/translations',
//       startLocale: const Locale('en'),
//       fallbackLocale: const Locale('en'),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   final designSize = const Size(360, 690);

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: designSize,
//       minTextAdapt: true,
//       splitScreenMode: true,
//       fontSizeResolver: (fontSize, instance) {
//         final display = View.of(context).display;
//         final screenSize = display.size / display.devicePixelRatio;
//         final scaleWidth = screenSize.width / designSize.width;
//         return fontSize * scaleWidth;
//       },
//       builder: (_, __) {
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (context) => ThemeCubit(),
//             ),
//           ],
//           child: BlocBuilder<ThemeCubit, ThemeMode>(
//             builder: (context, newMode) {
//               return MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 navigatorObservers: [NavObserver()], // with built in navigator
//                 localizationsDelegates: context.localizationDelegates,
//                 supportedLocales: context.supportedLocales,
//                 locale: context.locale,
//                 theme: AppThemes.lightTheme,
//                 darkTheme: AppThemes.darkTheme,
//                 themeMode: newMode,
//                 home: const Scaffold(),
//                 // routerConfig: RouterService().router,
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>();
final _shellNavigatorSettingsKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorHomeKey,
      builder: (context, state, child) =>
          TabsScaffold(currentIndex: 0, child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              const MaterialPage(child: HomeScreen()),
          routes: [
            GoRoute(
              path: 'details',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: HomeDetailsScreen()),
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorProfileKey,
      builder: (context, state, child) =>
          TabsScaffold(currentIndex: 1, child: child),
      routes: [
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) =>
              const MaterialPage(child: ProfileScreen()),
          routes: [
            GoRoute(
              path: 'details',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: ProfileDetailsScreen()),
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorSettingsKey,
      builder: (context, state, child) =>
          TabsScaffold(currentIndex: 2, child: child),
      routes: [
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) =>
              const MaterialPage(child: SettingsScreen()),
          routes: [
            GoRoute(
              path: 'details',
              pageBuilder: (context, state) =>
                  const MaterialPage(child: SettingsDetailsScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
);

class TabsScaffold extends StatefulWidget {
  final int currentIndex;
  final Widget child;

  const TabsScaffold(
      {super.key, required this.currentIndex, required this.child});

  @override
  State<TabsScaffold> createState() => _TabsScaffoldState();
}

class _TabsScaffoldState extends State<TabsScaffold> {
  int currentIndex = 0;
  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/profile');
        break;
      case 2:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/home/details'),
          child: const Text('Go to Home Details'),
        ),
      ),
    );
  }
}

class HomeDetailsScreen extends StatelessWidget {
  const HomeDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Details')),
      body: const Center(child: Text('Details inside Home Tab')),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/profile/details'),
          child: const Text('Go to Profile Details'),
        ),
      ),
    );
  }
}

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Details')),
      body: const Center(child: Text('Details inside Profile Tab')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/settings/details'),
          child: const Text('Go to Settings Details'),
        ),
      ),
    );
  }
}

class SettingsDetailsScreen extends StatelessWidget {
  const SettingsDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Details')),
      body: const Center(child: Text('Details inside Settings Tab')),
    );
  }
}
