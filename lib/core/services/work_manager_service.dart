// import 'package:notifications/services/local_notification_service.dart';
// import 'package:workmanager/workmanager.dart';

// class WorkManagerService {
//   /// Init work manager
//   static Future<void> init() async {
//     await Workmanager().initialize(
//       actionTask,
//       isInDebugMode: true,
//     );
//     registerMyTask();
//   }

//   static Future<void> registerMyTask() async {
//     // Workmanager().registerOneOffTask(
//     //   'id1',
//     //   'show simple notification',
//     // );
//     Workmanager().registerPeriodicTask(
//       'id1',
//       'show simple notification',
//       frequency: const Duration(
//         minutes: 15,
//       ), // the minimum period is 15 minutes, even i put 5 minuts or any less that 15 minutes
//     );
//   }

//   /// Cancel one task
//   static void cancelTask(String id) {
//     Workmanager().cancelByUniqueName(id);
//   }

//   /// Cancel all tasks
//   static void cancelAllTasks() {
//     Workmanager().cancelAll();
//   }
// }

// /// This function must to be out of the class (top levele)
// @pragma('vm:entry-point')
// Future<void> actionTask() async {
//   Workmanager().executeTask(
//     (task, inputData) {
//       LocalNotificationService.showDailySchedualedNotification();
//       return Future.value(true);
//     },
//   );
// }



// /// We need to add this config to the follwoing files 
// /// 
// /// 1. Android/build.gradle : modify the Kotlin version to tha latest one in buildscript
// /// 2. Android/build.gradle : in dependency , classpath, modify the version of com.android.tools.build:gradle:7.3.1
// /// 3. App/build.gradle : add to the dependency this line : implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"