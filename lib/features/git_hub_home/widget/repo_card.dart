import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/utils/dimensions.dart';
import 'package:inilabs_assignment/widget_repo_card.dart';

class RepoCard extends StatelessWidget {
  final dynamic repo;
  final bool isGrid;

  const RepoCard({
    super.key,
    required this.repo,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    final name = repo?['name'] ?? 'Unknown';
    final description = repo?['description'] ?? '';
    final stars = repo?['stargazers_count'] ?? 0;
    final language = repo?['language'] ?? '';
    final firstLetter = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return InkWell(
      onTap: () => Get.to(() => RepoDetailsScreen(repo: repo)),
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isGrid ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                    firstLetter,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),

              const SizedBox(width: 12),

              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // const SizedBox(height: 6),
                    if (description.isNotEmpty)
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2, overflow: TextOverflow.ellipsis,),

                    // const SizedBox(height: 8),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        const Icon(Icons.star, size: 16, color: Colors.amber),

                        const SizedBox(width: 4),

                        Text('$stars'),

                        const SizedBox(width: 15),

                        const Icon(Icons.code, size: 16),

                        const SizedBox(width: 4),

                        Text(language),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ) : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue.shade100,
                child: Text(
                    firstLetter,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (description.isNotEmpty)
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1, overflow: TextOverflow.ellipsis,),

                    Row(
                      children: [

                        const Icon(Icons.star, size: 16, color: Colors.amber),

                        const SizedBox(width: 4),

                        Text('$stars'),

                        const SizedBox(width: 15),

                        const Icon(Icons.code, size: 16),

                        const SizedBox(width: 4),

                        Text(language),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
