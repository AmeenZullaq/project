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
// }

import 'package:flutter/material.dart';
import 'package:project/core/services/Navigator_observer.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [NavObserver()],
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) {
                        return SecondScreen();
                      },
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        final position =
                            Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
                                .animate(animation);
                        return SlideTransition(
                          position: position,
                          child: child,
                        );
                      },
                    ));
              },
              child: Text(
                'Go to second screen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        print(didPop);
        if (didPop) {
          return; // this case when pop excuted, and we put it because if poped then the context in dialog in it in the widge tree
        }

        showDialog(
          context: context,
          builder: (context) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('pop'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancle'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Second Screen'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Do to Third screen',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'tap',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
