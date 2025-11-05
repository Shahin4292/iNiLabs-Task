import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoDetailsPage extends StatelessWidget {
  final VoidCallback onToggleTheme;
  const RepoDetailsPage({super.key, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    final repo = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final formatter = DateFormat('yyyy-MM-dd HH:mm');

    return Scaffold(
      appBar: AppBar(
        title: Text(repo['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: onToggleTheme,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(repo['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(repo['description'] ?? 'No description provided.'),
            const Divider(height: 30),
            _infoRow('Language', repo['language'] ?? 'N/A'),
            _infoRow('Stars', '${repo['stargazers_count']}'),
            _infoRow('Forks', '${repo['forks_count']}'),
            _infoRow('Watchers', '${repo['watchers_count']}'),
            _infoRow('Created', formatter.format(DateTime.parse(repo['created_at']))),
            _infoRow('Updated', formatter.format(DateTime.parse(repo['updated_at']))),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in GitHub'),
              onPressed: () async {
                final url = Uri.parse(repo['html_url']);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
