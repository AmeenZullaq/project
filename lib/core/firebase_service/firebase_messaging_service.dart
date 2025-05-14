// import 'dart:async';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FirebaseMessagingService {
//   static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initNotifications() async {
//     await getToken();
//     await firebaseMessaging.requestPermission();
//     initBackgroundNotifications();
//     initForegroundNotifications();
//     initLocalNotifications();
//   }

//   static Future<void> initLocalNotifications() async {
//     InitializationSettings settings = const InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: DarwinInitializationSettings(),
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: onClickForegroundNotification,
//     );
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//   }

//   static Future<void> initBackgroundNotifications() async {
//     /// this callback will call when receive background notification
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundNotifications);

//     /// this callback will call when user click on notification when the app in terminated state
//     firebaseMessaging.getInitialMessage().then(onClickTerminatedMessage);

//     /// this callback will call when user click on notification when the app in background state
//     FirebaseMessaging.onMessageOpenedApp.listen(onClickBackgroundMessage);
//   }

//   static Future<void> handleBackgroundNotifications(
//     RemoteMessage message,
//   ) async {}

//   static void onClickBackgroundMessage(
//     RemoteMessage message,
//   ) {
//     // navigatorKey.currentState?.push(MaterialPageRoute(
//     //   builder: (context) => const NotificationsView(),
//     // ));
//   }

//   static Future<void> onClickTerminatedMessage(
//     RemoteMessage? message,
//   ) async {
//     if (message == null) {
//       return;
//     } else {
//       //     navigatorKey.currentState?.push(MaterialPageRoute(
//       //   builder: (context) => const NotificationsView(),
//       // ));
//     }
//   }

//   static Future<void> initForegroundNotifications() async {
//     FirebaseMessaging.onMessage.listen(handleForegroundNotifications);
//   }

//   static Future<void> handleForegroundNotifications(
//     RemoteMessage message,
//   ) async {
//     showBasicNotification(
//       message: message,
//     );
//   }

//   static Future<void> showBasicNotification({
//     required RemoteMessage message,
//   }) async {
//     /// To show network image in the notification
//     // final http.Response response = await http.get(
//     //   Uri.parse(message.notification?.android?.imageUrl ?? ''),
//     // );
//     // BigPictureStyleInformation bigPictureStyleInformation =
//     //     BigPictureStyleInformation(
//     //   ByteArrayAndroidBitmap.fromBase64String(
//     //     base64Encode(response.bodyBytes),
//     //   ),
//     //   largeIcon: ByteArrayAndroidBitmap.fromBase64String(
//     //     base64Encode(response.bodyBytes),
//     //   ),
//     // );

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
//         // styleInformation: bigPictureStyleInformation,
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
//       // payload: 'basic payload',
//     );
//   }

//   Future<void> subscribeToTopic({
//     required String topic,
//   }) async {
//     await firebaseMessaging.subscribeToTopic(topic);
//   }

//   Future<void> unSubscribeFromTopic({
//     required String topic,
//   }) async {
//     await firebaseMessaging.unsubscribeFromTopic(topic);
//   }

//   static Future<String?> getToken() async {
//     final String? token = await firebaseMessaging.getToken();
//     // store the token in shared prefernces
//     return token;
//   }

//   static Future<void> deleteToken() async {
//     firebaseMessaging.deleteToken();
//     // set null in the token variable in shared preferences
//   }

//   static Future<void> sendTokenToServer({
//     required String token,
//   }) async {
//     // option 1 => API
//     // option 2 => firebase
//   }

//   static onClickForegroundNotification(
//     NotificationResponse notificationResponse,
//   ) async {
//     // navigatorKey.currentState?.push(MaterialPageRoute(
//     //   builder: (context) {
//     //     return const NotificationsView();
//     //   },
//     // ));
//   }

//   static Future<void> cancelAllNotifications() async {
//     flutterLocalNotificationsPlugin.cancelAll();
//   }
// }

// // Notes
// /// 1. if we want to change the sound of the notification in the foreground in firebase
// ///     we can achive this in local notification because we use it in foreground
// ///     But if we need to change the sound in background we need to add a native code
// ///     and here is a video in the playlist
