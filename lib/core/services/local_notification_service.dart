// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;

// class LocalNotificationService {
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   static StreamController<NotificationResponse> streamController =
//       StreamController();

//   static Future init() async {
//     InitializationSettings settings = const InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveBackgroundNotificationResponse:
//           onTap, // when i press on notification in background
//       onDidReceiveNotificationResponse:
//           onTap, // when i press on notification in forground
//     );
//   }

//   static Future<void> showBasicNotification({
//     required RemoteMessage message,
//   }) async {
//     /// To show network image in the notification
//     final http.Response response = await http.get(
//       Uri.parse(message.notification?.android?.imageUrl ?? ''),
//     );
//     BigPictureStyleInformation bigPictureStyleInformation =
//         BigPictureStyleInformation(
//       ByteArrayAndroidBitmap.fromBase64String(
//         base64Encode(response.bodyBytes),
//       ),
//       largeIcon: ByteArrayAndroidBitmap.fromBase64String(
//         base64Encode(response.bodyBytes),
//       ),
//     );

//     /// To show local image, uncompleted
//     // final String filePath = '${directory.path}/$fileName';
//     // final BigPictureStyleInformation bigPictureStyleInformation =
//     //     BigPictureStyleInformation(
//     //   FilePathAndroidBitmap(filePath),
//     //   largeIcon: FilePathAndroidBitmap(filePath),
//     // );

//     NotificationDetails notificationDetails = NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channel_id',
//         'channel_name',
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//         styleInformation: bigPictureStyleInformation,
//         sound: RawResourceAndroidNotificationSound(
//           'sound.wav'.split('.').first,
//         ),
//       ),
//     );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification?.title,
//       message.notification?.body,
//       notificationDetails,
//       payload: 'basic payload',
//     );
//   }

//   static Future<void> showRebeatedNotification() async {
//     NotificationDetails notificationDetails = const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channelId repeated',
//         'channelName repeated',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//     );
//     flutterLocalNotificationsPlugin.periodicallyShow(
//       1,
//       'ameen',
//       'notification rebeated',
//       RepeatInterval.everyMinute,
//       notificationDetails,
//       payload: 'reapeated Payload',
//     );
//   }

//   static Future<void> showSchedualedNotification() async {
//     NotificationDetails notificationDetails = const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channelId schedualed',
//         'channelName schedualed',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//     );
//     tz.initializeTimeZones();
//     // log(tz.TZDateTime.now(tz.local).hour.toString());
//     log('Befor flutter time zone : ${tz.local.name}');
//     final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
//     log('After flutter time zone : $currentTimeZone');
//     // tz.setLocalLocation(
//     //   tz.getLocation('Asia/Damascus'),
//     // ); // this will solve the error of determine the time zone, but that a static and will not work in other countries, so we used flutter time zone package
//     tz.setLocalLocation(
//       tz.getLocation(currentTimeZone),
//     );
//     flutterLocalNotificationsPlugin.zonedSchedule(
//         2,
//         'ameen',
//         'schedualed notifications',
//         tz.TZDateTime.now(tz.local).add(
//           const Duration(
//             seconds: 5,
//           ), // here ther is no bug, it sends a notification after 3 seconds dependently on device time
//         ),
//         // tz.TZDateTime(
//         //   tz.local,
//         //   2024,
//         //   9,
//         //   28,
//         //   7,
//         //   41,
//         // ), // but here there is a bug, it determines wrong time zone, so we use flutter time zone to solve this
//         notificationDetails,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         payload: 'Sechudaled payload');
//   }

//   static Future<void> showDailySchedualedNotification() async {
//     NotificationDetails notificationDetails = const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channelId Daily schedualed',
//         'channelName Daily schedualed',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//     );
//     tz.initializeTimeZones();
//     log('Befor flutter time zone : ${tz.local.name}');
//     final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
//     log('After flutter time zone : $currentTimeZone');
//     tz.setLocalLocation(
//       tz.getLocation(currentTimeZone),
//     );
//     var now = DateTime.now();
//     var scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       9,
//     );
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate.add(const Duration(days: 1));
//     }
//     flutterLocalNotificationsPlugin.zonedSchedule(
//       2,
//       'ameen',
//       'Daily schedualed notifications',
//       scheduledDate,
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       payload: 'Daily Sechudaled payload',
//     );
//   }

//   static Future<void> cancelAllNotifications() async {
//     flutterLocalNotificationsPlugin.cancelAll();
//   }

//   static Future<void> cancel(int id) async {
//     flutterLocalNotificationsPlugin.cancel(id);
//   }

//   static onTap(NotificationResponse notificationResponse) async {
//     streamController.add(notificationResponse);
//   }
// }



// // ///5. we need to add voice to android/app/src/main/res/create folder named raw and then add the voice in it.

// // /// every type of notifications functions [basic, repeated, notification] should take a different Id
// // /// if two functions take the same id, these two functions will show in the same place
