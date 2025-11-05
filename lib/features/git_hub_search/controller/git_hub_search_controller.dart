import 'package:get/get.dart';
import 'package:inilabs_assignment/features/git_hub_search/repository/git_hub_search_repo.dart';

class GitHubSearchController extends GetxController {

  final GitHubSearchRepo _service = GitHubSearchRepo();
  var isLoading = false.obs;
  var hasError = false.obs;
  Map<String, dynamic>? userData;
  // var userData = {}.obs;


  Future<void> fetchUserData(String username) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final user = await _service.getUser(username);
      userData = user;
      // userData.value = user;
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}