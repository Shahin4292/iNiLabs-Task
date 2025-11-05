import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';
import 'package:inilabs_assignment/features/git_hub_home/controller/git_hub_home_controller.dart';
import 'package:inilabs_assignment/features/git_hub_search/controller/git_hub_search_controller.dart';

class GitHubHomeScreen extends StatelessWidget {
  final GitHubHomeController gitHubHomeController = Get.put(GitHubHomeController());
  GitHubSearchController gitHubSearchController = Get.put(GitHubSearchController());
  final ThemeController themeController = Get.find();
  final String username;
  GitHubHomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (username.isNotEmpty) {
        gitHubHomeController.fetchReposData(username);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repositories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search repos',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Sort / Filter',
            onPressed: () {},
          ),

          Obx(() => IconButton(
            icon: Icon(gitHubHomeController.viewMode.value == ViewMode.list
                ? Icons.grid_view
                : Icons.list),
            tooltip: 'Toggle view',
            onPressed: gitHubHomeController.toggleViewMode,
          )),

          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: themeController.toggleTheme,
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: Obx(() {
        if (gitHubHomeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (gitHubHomeController.hasError.value) {
          return const Center(child: Text('Error loading data'));
        }
        final repos = gitHubHomeController.filteredRepos;
        if (repos.isEmpty) {
          return const Center(child: Text('No repositories found.'));
        }

        return Center(
          child: Text('Found ${repos.length}'),
        );

      }),
    );
  }
}
