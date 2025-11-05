import 'package:get/get.dart';
import 'package:inilabs_assignment/features/git_hub_home/repository/git_hub_home_repo.dart';

enum ViewMode { list, grid }

class GitHubHomeController extends GetxController {

  final GitHubHomeRepo _service = GitHubHomeRepo();

  final viewMode = ViewMode.list.obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var userData = {}.obs;
  var repos = [].obs;
  var filteredRepos = [].obs;
  // var viewMode = ViewMode.list.obs;
  // var sortOption = SortOption.name.obs;

  void toggleViewMode() {
    viewMode.value = viewMode.value == ViewMode.list ? ViewMode.grid : ViewMode.list;
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