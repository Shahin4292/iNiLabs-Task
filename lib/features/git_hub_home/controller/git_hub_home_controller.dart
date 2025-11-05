import 'package:get/get.dart';
import 'package:inilabs_assignment/features/git_hub_home/repository/git_hub_home_repo.dart';

enum ViewMode { list, grid }
enum SortOption { name, stars, date }

class GitHubHomeController extends GetxController {

  final GitHubHomeRepo _service = GitHubHomeRepo();

  final viewMode = ViewMode.list.obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var userData = {}.obs;
  var repos = [].obs;
  var filteredRepos = [].obs;
  var sortOption = SortOption.name.obs;

  void toggleViewMode() {
    viewMode.value = viewMode.value == ViewMode.list ? ViewMode.grid : ViewMode.list;
  }

  void sortRepositories(SortOption option) {
    sortOption.value = option;
    switch (option) {
      case SortOption.name:
        filteredRepos.sort((a, b) =>
            a['name'].toLowerCase().compareTo(b['name'].toLowerCase()));
        break;
      case SortOption.stars:
        filteredRepos.sort((b, a) =>
            (a['stargazers_count'] as int).compareTo(b['stargazers_count']));
        break;
      case SortOption.date:
        filteredRepos.sort((b, a) => DateTime.parse(a['created_at'])
            .compareTo(DateTime.parse(b['created_at'])));
        break;
    }
  }

  Future<void> fetchReposData(String username) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final repoList = await _service.getUserRepos(username);
      repos.assignAll(repoList);
      filteredRepos.assignAll(repoList);
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}