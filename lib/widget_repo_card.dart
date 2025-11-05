import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepoCard extends StatelessWidget {
  final Map<String, dynamic> repo;
  final bool isGrid;
  const RepoCard({super.key, required this.repo, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/repo', arguments: repo),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment:
            isGrid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(repo['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(repo['language'] ?? 'Unknown'),
              const Spacer(),
              Row(
                mainAxisAlignment: isGrid
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text('${repo['stargazers_count']}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
