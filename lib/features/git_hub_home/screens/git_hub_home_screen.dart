import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';
import 'package:inilabs_assignment/features/git_hub_home/controller/git_hub_home_controller.dart';
import 'package:inilabs_assignment/features/git_hub_home/widget/repo_card.dart';
import 'package:inilabs_assignment/features/git_hub_search/controller/git_hub_search_controller.dart';
import 'package:inilabs_assignment/utils/dimensions.dart';

class GitHubHomeScreen extends StatelessWidget {
  final GitHubHomeController gitHubHomeController = Get.put(GitHubHomeController());
  GitHubSearchController gitHubSearchController = Get.put(GitHubSearchController());
  final ThemeController themeController = Get.find();
  GitHubHomeScreen({super.key, });

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (gitHubSearchController.usernameController.text.isNotEmpty) {
        gitHubHomeController.fetchReposData(gitHubSearchController.usernameController.text);
      }
    });

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back),
          onPressed: (){
          gitHubSearchController.usernameController.clear();
          Get.back();
          },
        ),
        title: Text('Repositories', style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
        actions: [

          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Sort / Filter',
            onPressed: () => _showFilterOptions(context,),
          ),

          Obx(() => IconButton(
            icon: Icon(gitHubHomeController.viewMode.value == ViewMode.list ? Icons.grid_view : Icons.list),
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

        final users = gitHubSearchController.userData.value!;
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              CircleAvatar( radius: 50, backgroundImage: NetworkImage(users.avatarUrl), ),

              Text(
                users.name,
                style: TextStyle(fontSize: Dimensions.fontSizeOverLarge, fontWeight: FontWeight.bold)),
          
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  spacing: Dimensions.paddingSizeSmall,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Repository: ${users.publicRepos}"),
                        Text(users.login),
                        Text("View Type: ${users.userViewType}"),
                      ],
                    ),

                    Text(
                      users.bio,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          
              gitHubHomeController.viewMode.value == ViewMode.list ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: repos.length,
                padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                itemBuilder: (context, index) => RepoCard(repo: repos[index], isGrid: false),
              ) : GridView.builder(itemCount: repos.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2/2.1, crossAxisSpacing: Dimensions.paddingSizeSmall),
                itemBuilder: (context, index) => RepoCard(repo: repos[index], isGrid: true),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showFilterOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radiusLarge),
            topRight: Radius.circular(Dimensions.radiusLarge),
          ),
        ),
        child: Wrap(
          children: [

            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text('Sort by Name'),
              onTap: () {
                gitHubHomeController.sortRepositories(SortOption.name);
                Get.back();
              },
            ),

            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Sort by Stars'),
              onTap: () {
                gitHubHomeController.sortRepositories(SortOption.stars);
                Get.back();
              },
            ),

            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Sort by Date'),
              onTap: () {
                gitHubHomeController.sortRepositories(SortOption.date);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
