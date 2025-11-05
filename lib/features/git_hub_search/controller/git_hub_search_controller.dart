import 'package:get/get.dart';

import '../repository/git_hub_search_repo.dart';

class GitHubSearchController extends GetxController {

  final GitHubSearchRepo _service = GitHubSearchRepo();
  var isLoading = false.obs;
  var hasError = false.obs;
  var userData = {}.obs;


  Future<void> fetchUserData(String username) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final user = await _service.getUser(username);
      userData.value = user;
    } catch (e) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}