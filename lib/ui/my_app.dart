import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/authentication_controller.dart';
import 'pages/pages/authentication/login_page.dart';
import 'pages/pages/home/content.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationController authenticationController = Get.find();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Authentication Flow',
        themeMode: ThemeMode.system,
        home: GetX<AuthenticationController>(
          builder: (controller) {
            if (controller.logged) {
              return Content();
            }
            return LoginPage();
          },
        ));
  }
}
