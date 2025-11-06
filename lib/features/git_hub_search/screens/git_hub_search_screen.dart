import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';
import 'package:inilabs_assignment/features/git_hub_home/screens/git_hub_home_screen.dart';
import 'package:inilabs_assignment/features/git_hub_search/controller/git_hub_search_controller.dart';
import 'package:inilabs_assignment/utils/dimensions.dart';

class GitHubSearchScreen extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final GitHubSearchController gitHubSearchController = Get.put(GitHubSearchController());

  GitHubSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Explorer', style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
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
                controller: gitHubSearchController.usernameController,
                style: TextStyle(fontSize: Dimensions.fontSizeLarge),
                decoration: InputDecoration(
                  hintText: 'Search by username',
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
                  if (gitHubSearchController.usernameController.text.isNotEmpty) {
                    gitHubSearchController.fetchUserData(gitHubSearchController.usernameController.text.trim());
                    Get.to(() => GitHubHomeScreen());
                  }else{Get.snackbar('Error', 'Please enter a username', snackPosition: SnackPosition.BOTTOM);}
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
