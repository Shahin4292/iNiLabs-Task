import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('GitHub Explorer'),
        actions: [IconButton(onPressed: themeController.toggleTheme, icon: Icon(Icons.brightness_6))],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15,
            children: [
              const Text('Enter GitHub Username', style: TextStyle(fontSize: 18)),
              TextField(
                decoration: InputDecoration(
                  hintText: 'e.g. shahin4292',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height * 0.07)
                ),
                onPressed: () {
                  // Implement login logic here
                },
                child:  Text('Search',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
