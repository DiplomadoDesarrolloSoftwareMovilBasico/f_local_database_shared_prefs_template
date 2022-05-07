import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/authentication_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationController controller = Get.find();
    return Center(
        child: ElevatedButton(
      key: const Key('profileLogout'),
      child: const Text('Logout'),
      onPressed: () {
        controller.logout();
      },
    ));
  }
}
