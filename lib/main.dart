import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controller/general_controller.dart';
import 'controller/local_notification.dart';
import 'modules/splash/view.dart';
import 'route_generator.dart';
import 'utils/theme.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Get.put(GeneralController());

  LocalNotificationService.display(message);
  log(message.data.toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await GetStorage.init();

  Get.put(GeneralController());
  runApp(const InitClass());
}

class InitClass extends StatefulWidget {
  const InitClass({Key? key}) : super(key: key);

  @override
  _InitClassState createState() => _InitClassState();
}

class _InitClassState extends State<InitClass> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    LocalNotificationService.initialize(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyApp(),
      getPages: routes(),
      themeMode: ThemeMode.light,
      theme: lightTheme(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    /// on app closed
    FirebaseMessaging.instance.getInitialMessage().then((message) {});

    ///forground messages
    FirebaseMessaging.onMessage.listen((message) {
      log('foreground messages----->>');
      log(message.notification.toString());
      if (message.notification != null) {
        log(message.notification!.body.toString());
        log(message.notification!.title.toString());
      }
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      log('Notifications--->>$message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }
}
