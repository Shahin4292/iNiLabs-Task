import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/controller/theme_controller.dart';
import 'package:inilabs_assignment/widget_repo_card.dart';
import 'github_controller.dart';

class HomePage extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final GitHubController githubController = Get.find();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repositories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterOptions(context),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: themeController.toggleTheme,
          ),
          Obx(() => IconButton(
            icon: Icon(githubController.viewMode.value == ViewMode.list
                ? Icons.grid_view
                : Icons.list),
            onPressed: githubController.toggleViewMode,
          )),
        ],
      ),
      body: Obx(() {
        if (githubController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (githubController.hasError.value) {
          return const Center(child: Text('Error loading data'));
        }

        final repos = githubController.filteredRepos;
        if (repos.isEmpty) {
          return const Center(child: Text('No repositories found.'));
        }

        return githubController.viewMode.value == ViewMode.list
            ? ListView.builder(
          itemCount: repos.length,
          itemBuilder: (context, index) =>
              RepoCard(repo: repos[index], isGrid: false),
        )
            : GridView.builder(
          itemCount: repos.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) =>
              RepoCard(repo: repos[index], isGrid: true),
        );
      }),
    );
  }

  void _showFilterOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Theme.of(context).colorScheme.surface,
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text('Sort by Name'),
              onTap: () {
                githubController.sortRepositories(SortOption.name);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Sort by Stars'),
              onTap: () {
                githubController.sortRepositories(SortOption.stars);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Sort by Date'),
              onTap: () {
                githubController.sortRepositories(SortOption.date);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}


class RepoCard extends StatelessWidget {
  final dynamic repo;
  final bool isGrid;

  const RepoCard({Key? key, required this.repo, this.isGrid = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double itemHeight = isGrid ? 220.0 : 100.0;

    final card = Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 56,
              height: 56,
              child: CircleAvatar(
                child: Text(
                  (repo?['name'] as String?)?.substring(0, 1).toUpperCase() ??
                      '',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repo?['name'] ?? 'Unknown',
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    repo?['description'] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: isGrid ? 4 : 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14),
                      const SizedBox(width: 4),
                      Text('${repo?['stars'] ?? 0}'),
                      const SizedBox(width: 12),
                      const Icon(Icons.code, size: 14),
                      const SizedBox(width: 4),
                      Text(repo?['language'] ?? ''),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return SizedBox(
      height: itemHeight,
      child: card,
    );
  }
}