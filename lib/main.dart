import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/features/login/screens/login_screen.dart';
import 'package:inilabs_assignment/repo_details_page.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';
import 'home.dart';
import 'login.dart';


void main() {
  runApp(const GitHubApp());
}

class GitHubApp extends StatelessWidget {
  const GitHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(() => GetMaterialApp(
        title: 'GitHub Explorer',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: themeController.themeMode.value,
        debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      ),
    );
  }
}
