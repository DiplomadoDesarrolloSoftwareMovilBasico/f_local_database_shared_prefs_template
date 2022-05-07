import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/use_case/authentication.dart';
import 'ui/controllers/authentication_controller.dart';
import 'ui/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  Get.put(UserRepository());
  Get.lazyPut<Authentication>(() => Authentication());
  Get.put(AuthenticationController());
  runApp(MyApp());
}
