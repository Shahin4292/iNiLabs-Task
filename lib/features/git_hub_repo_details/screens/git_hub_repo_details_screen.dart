import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoDetailsScreen extends StatelessWidget {
  final dynamic repo;

  const RepoDetailsScreen({super.key, required this.repo});

  Future<void> _openGitUrl() async {
    final url = Uri.parse(repo['html_url'] ?? '');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = repo['name'] ?? 'Unknown';
    final description = repo['description'] ?? 'No description available';
    final stars = repo['stargazers_count'] ?? 0;
    final language = repo['language'] ?? 'Unknown';
    final updatedAt = repo['updated_at'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: _openGitUrl,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(description),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.star, size: 18, color: Colors.amber),
                const SizedBox(width: 6),
                Text('Stars: $stars'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.code, size: 18),
                const SizedBox(width: 6),
                Text('Language: $language'),
              ],
            ),
            const SizedBox(height: 10),
            if (updatedAt.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.update, size: 18),
                  const SizedBox(width: 6),
                  Text('Updated at: $updatedAt'),
                ],
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.open_in_new),
                label: const Text('View on GitHub'),
                onPressed: _openGitUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}