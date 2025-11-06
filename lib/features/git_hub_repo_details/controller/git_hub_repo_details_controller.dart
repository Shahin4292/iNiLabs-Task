import 'package:get/get.dart';
import 'package:inilabs_assignment/features/git_hub_home/model/git_hub_home_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubRepoDetailsController extends GetxController {
  final GitHubHomeModel repo;
  GitHubRepoDetailsController(this.repo);

  Future<void> openGitUrl() async {
    final url = Uri.parse(repo.htmlUrl ?? '');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $url';
    }
  }

  String formatDateTime(DateTime? date) {
    if (date == null) return 'Unknown';
    final dhakaTime = date.toUtc().add(const Duration(hours: 6));
    return DateFormat('yyyy-MM-dd hh:mm a').format(dhakaTime);
  }

}