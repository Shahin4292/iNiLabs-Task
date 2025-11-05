import 'package:get/get.dart';
import 'package:inilabs_assignment/services.dart';

enum ViewMode { list, grid }
enum SortOption { name, stars, date }

class GitHubController extends GetxController {
  final GitHubService _service = GitHubService();

  var isLoading = false.obs;
  var hasError = false.obs;
  var userData = {}.obs;
  var repos = [].obs;
  var filteredRepos = [].obs;
  var viewMode = ViewMode.list.obs;
  var sortOption = SortOption.name.obs;

  Future<void> fetchUserData(String username) async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final user = await _service.getUser(username);
      final repoList = await _service.getUserRepos(username);

      userData.value = user;
      repos.assignAll(repoList);
      filteredRepos.assignAll(repoList);
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void toggleViewMode() {
    viewMode.value =
    viewMode.value == ViewMode.list ? ViewMode.grid : ViewMode.list;
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
}
