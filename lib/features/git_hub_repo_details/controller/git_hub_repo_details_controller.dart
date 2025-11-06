import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class GitHubRepoDetailsController extends GetxController {
  final dynamic repo;
  GitHubRepoDetailsController(this.repo);

  Future<void> openGitUrl() async {
    final url = Uri.parse(repo['html_url'] ?? '');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $url';
    }
  }

  String formatDateTime(DateTime date) {
    final dhakaTime = date.toUtc().add(const Duration(hours: 6));
    return DateFormat('yyyy-MM-dd hh:mm a').format(dhakaTime);
  }


}