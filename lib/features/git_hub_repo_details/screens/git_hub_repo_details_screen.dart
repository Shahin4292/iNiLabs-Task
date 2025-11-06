import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';
import 'package:inilabs_assignment/features/git_hub_home/model/git_hub_home_model.dart';
import 'package:inilabs_assignment/features/git_hub_repo_details/controller/git_hub_repo_details_controller.dart';
import 'package:inilabs_assignment/utils/dimensions.dart';

class RepoDetailsScreen extends StatelessWidget {
  final GitHubHomeModel detailsRepo;
  final ThemeController themeController = Get.find();
  RepoDetailsScreen({super.key, required this.detailsRepo});

  @override
  Widget build(BuildContext context) {

    final GitHubRepoDetailsController gitHubRepoDetailsController = Get.put(GitHubRepoDetailsController(detailsRepo));
    final name = detailsRepo.name ?? 'Unknown';
    final description = detailsRepo.description ?? 'No description available';
    final stars = detailsRepo.stargazersCount ?? 0;
    final language = detailsRepo.language ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge)),
        actions: [

          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: gitHubRepoDetailsController.openGitUrl,
          ),

          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: themeController.toggleTheme,
            tooltip: 'Toggle theme',
          ),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              name,
              style:  TextStyle(fontWeight: FontWeight.bold,fontSize: Dimensions.fontSizeExtraLarge),
              maxLines: 1, overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: Dimensions.paddingSizeSmall),

            Text(
              description,
              style: TextStyle(fontSize: Dimensions.fontSizeDefault)
            ),

            SizedBox(height: Dimensions.paddingSizeDefault),

            Row(
              children: [
                 Icon(Icons.star, size: Dimensions.fontSizeExtraLarge, color: Colors.amber),

                SizedBox(width: Dimensions.paddingSizeExtraSmall),

                Text('Stars: $stars'),
              ],
            ),

            SizedBox(height: Dimensions.paddingSizeSmall),

            Row(
              children: [

                Icon(Icons.code, size: Dimensions.fontSizeExtraLarge),

                SizedBox(width: Dimensions.paddingSizeExtraSmall),

                Text('Language: $language'),
              ],
            ),

            SizedBox(height: Dimensions.paddingSizeSmall),

            if (detailsRepo.updatedAt != null)
              Row(
                children: [
                  Icon(Icons.update, size: Dimensions.fontSizeExtraLarge),

                  SizedBox(width: Dimensions.paddingSizeExtraSmall),

                  Text(
                    'Updated at: ${gitHubRepoDetailsController.formatDateTime(detailsRepo.updatedAt ?? DateTime.now())}',
                  ),
                ],
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_new),
                label: const Text('View on GitHub'),
                onPressed: gitHubRepoDetailsController.openGitUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
