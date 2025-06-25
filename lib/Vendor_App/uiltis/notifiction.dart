// import 'dart:math';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   // FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   // void requrstNotificationPermission() async {
//   // NotificationSettings settings = await messaging.requestPermission(
//   //     alert: true,
//   //     announcement: true,
//   //     badge: true,
//   //     carPlay: true,
//   //     criticalAlert: true,
//   //     provisional: true,
//   //     sound: true);
//   //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//   //     print("user granted permission");
//   //   } else if (settings.authorizationStatus ==
//   //       AuthorizationStatus.provisional) {
//   //     print("user granted provisional permission");
//   //   } else {
//   //     print("user denied permission");
//   //   }
//   // }
//
//   void initLocalNotifications(
//       BuildContext context, RemoteMessage message) async {
//     var androidInitializationSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSetting = InitializationSettings(
//       android: androidInitializationSettings,
//     );
//     await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
//         onDidReceiveNotificationResponse: (payload) {
//       handleMessage(context, message);
//     });
//   }
//
//   // void firebaseinit(BuildContext context) {
//   //   FirebaseMessaging.onMessage.listen((message) {
//   //     print(message.notification!.title.toString());
//   //     print(message.notification!.body.toString());
//   //     initLocalNotifications(context, message);
//   //     showNotification(message);
//   //   });
//   // }
//
//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//         Random.secure().nextInt(100000).toString(),
//         "High Importance Notification ",
//         importance: Importance.max);
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             channel.id.toString(), channel.name.toString(),
//             channelDescription: "Your Channel Description",
//             importance: Importance.high,
//             priority: Priority.high,
//             ticker: "ticker");
//     NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);
//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification!.title.toString(),
//           message.notification!.body.toString(),
//           notificationDetails);
//     });
//   }
//   //
//   // Future<String> getDeviceToken() async {
//   //   String? token = await messaging.getToken();
//   //
//   //   return token!;
//   // }
//
//   // void isDeviceTokenRefresh() async {
//   //   messaging.onTokenRefresh.listen((event) {
//   //     event.toString();
//   //   });
//   // }
//
//   // Future<void> setupIntractMessage(BuildContext context) async {
//   //   RemoteMessage? initialMessage =
//   //       await FirebaseMessaging.instance.getInitialMessage();
//   //   if (initialMessage != null) {
//   //     handleMessage(context, initialMessage);
//   //   }
//   //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
//   //     handleMessage(context, event);
//   //   });
//   // }
//
//   void handleMessage(BuildContext context, RemoteMessage message) {
//     if (message.data['type'] == 'assign') {
//       // Navigator.push(context,
//       //     MaterialPageRoute(builder: (context) => const BookingPage()));
//     }
//   }
// }
