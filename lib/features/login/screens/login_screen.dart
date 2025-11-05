import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Explorer'),
        actions: [IconButton(onPressed: themeController.toggleTheme, icon: Icon(Icons.brightness_6))],
      ),
    );
  }
}
