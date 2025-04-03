// import 'dart:io';
// import 'dart:math';

// import 'dart:math';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/foundation.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/core/utils.dart';
import 'package:hmwssb/presentation/auth/splash_screen.dart';
import 'package:screen_protector/screen_protector.dart';

Future<void> main() async {
  await mainDefinedFunc();
  HttpOverrides.global = MyHttpOverrides(); // Override SSL check
  runApp(const MyApp());
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
Future<void> mainDefinedFunc() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await LocalStorages.init();
  await ScreenUtil.ensureScreenSize();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // if (Platform.isAndroid) {
  //   await ScreenProtector.preventScreenshotOn();
  // }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // late FirebaseMessaging _messaging;

  // PushNotification? _notificationInfo;

  // void registerNotification() async {
  //   await initNotification();

  //   // 1. Initialize the Firebase app
  //   try {
  //     await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //         apiKey: 'AIzaSyBEFL3SeV71_JZztZNrll_ci2Jpd46q98A',
  //         appId: '1:432800171156:android:a357d7f4a0e6483e1fe081',
  //         messagingSenderId: '432800171156',
  //         projectId: 'citizen-e5635',
  //         storageBucket: 'citizen-e5635.firebasestorage.app',
  //       ),
  //     );
  //   } catch (e) {
  //     if (e.toString().contains("duplicate-app")) {
  //       print("Firebase app already initialized");
  //     } else {
  //       rethrow;
  //     }
  //   }

  //   // 2. Instantiate Firebase Messaging
  //   _messaging = FirebaseMessaging.instance;

  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //   // 3. On iOS, this helps to take the user permissions
  //   NotificationSettings settings = await _messaging.requestPermission(
  //     announcement: true,
  //     provisional: true,
  //     criticalAlert: true,
  //   );
  //   // print('settings');
  //   // print(settings.authorizationStatus.name);

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     // print('User granted permission');
  //     _messaging.setForegroundNotificationPresentationOptions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );

  //     RemoteMessage? initialMessage = await _messaging.getInitialMessage();
  //     if (initialMessage != null) {
  //       showNotification(
  //         id: Random().nextInt(10000000),
  //         title: initialMessage.notification?.title.toString() ?? '',
  //         body: initialMessage.notification?.body.toString() ?? '',
  //       );
  //     }

  //     // For handling the received notifications
  //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //       // Parse the message received
  //       PushNotification notification = PushNotification(
  //         title: message.notification?.title.toString() ?? '',
  //         body: message.notification?.body.toString() ?? '',
  //       );

  //       setState(() {
  //         _notificationInfo = notification;
  //       });

  //       if (_notificationInfo != null) {
  //         showNotification(
  //           id: Random().nextInt(10000000),
  //           title: _notificationInfo?.title.toString() ?? '',
  //           body: _notificationInfo?.body.toString() ?? '',
  //         );
  //       }
  //     });
  //   } else {
  //     // print('User declined or has not accepted permission');
  //   }

  //   FlutterError.onError = (FlutterErrorDetails details) {
  //     // FlutterError.presentError(details);
  //     FirebaseCrashlytics.instance.recordFlutterError(details);
  //   };

  //   PlatformDispatcher.instance.onError =
  //       (Object error, StackTrace stackTrace) {
  //     FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  //     return true;
  //   };
  // }

  @override
  void initState() {
    // registerNotification();
    _initializeScreenProtection();
    super.initState();
  }

  Future<void> _initializeScreenProtection() async {
    // Enable screen protection
    await ScreenProtector.preventScreenshotOn();
  }

  @override
  void dispose() {
    // Disable screen protection
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: Utils.navigatorKey,
          // showPerformanceOverlay: true,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFFFFFFF),
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            useMaterial3: true,
            fontFamily: 'Roboto',
          ),
          builder: EasyLoading.init(
            builder: (BuildContext context, Widget? child) {
              ScreenUtil.init(context);
              return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!);
            },
          ),
          home: const SplashScreen()),
    );
  }
}

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> initNotification() async {
//   // Android initialization
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('splash_logo');

//   // ios initialization
//   const DarwinInitializationSettings initializationSettingsIOS =
//       DarwinInitializationSettings();

//   const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   // the initialization settings are initialized after they are setted
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// }

// Future<void> showNotification({
//   required int id,
//   required String title,
//   required String body,
// }) async {
//   await flutterLocalNotificationsPlugin.show(
//     id,
//     title,
//     body,
//     const NotificationDetails(
//         // Android details
//         android: AndroidNotificationDetails(
//           'main_channel',
//           'Main Channel',
//           importance: Importance.max,
//           priority: Priority.max,
//           color: Colors.white,
//           // ledColor: WHITE_COLOR,
//           // icon: 'app_logo',
//           // sound: RawResourceAndroidNotificationSound('slow_spring_board'),
//         ),
//         // iOS details
//         iOS: DarwinNotificationDetails(
//             presentAlert: true, presentBadge: true, presentSound: true)),
//     payload: title,
//   );
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // print("Handling a background message: ${message.messageId}");
//   showNotification(
//     id: Random().nextInt(10000000),
//     title: message.notification?.title.toString() ?? '',
//     body: message.notification?.body.toString() ?? '',
//   );
// }

// class PushNotification {
//   PushNotification({
//     this.title,
//     this.body,
//   });
//   String? title;
//   String? body;
// }
