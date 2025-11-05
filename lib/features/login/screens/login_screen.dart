import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';
import 'package:inilabs_assignment/utils/dimensions.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final ThemeController themeController = Get.find();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Explorer', style: TextStyle(fontSize: Dimensions.fontSizeOverLarge)),
        actions: [IconButton(onPressed: themeController.toggleTheme, icon: Icon(Icons.brightness_6))],
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Dimensions.paddingSizeDefault,
            children: [

              Text('Enter GitHub Username', style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),

              TextField(
                controller: usernameController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                decoration: InputDecoration(
                  hintText: 'e.g. shahin4292',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                  fixedSize: Size(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height * 0.07)
                ),
                onPressed: () {
                  if (usernameController.text.isNotEmpty) {
                    // Get.put(GitHubController())
                    //     .fetchUserData(usernameController.text.trim());
                    Get.toNamed('/home', arguments: usernameController.text.trim());
                  }
                },
                child:  Text('Search',style: TextStyle(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.onPrimary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
