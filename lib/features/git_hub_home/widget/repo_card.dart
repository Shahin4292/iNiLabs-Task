import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/features/git_hub_home/widget/repo_info_row.dart';
import 'package:inilabs_assignment/features/git_hub_repo_details/screens/git_hub_repo_details_screen.dart';
import 'package:inilabs_assignment/utils/dimensions.dart';

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
        margin: EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: isGrid ? Column(
            spacing: Dimensions.paddingSizeExtraSmall,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CircleAvatar(
                radius: Dimensions.radiusSizeExtraLarge,
                child: Text(firstLetter, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),

              Text(
                name,
                style:  TextStyle(fontWeight: FontWeight.bold,fontSize: Dimensions.fontSizeLarge),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),

              if (description.isNotEmpty)
                Text(
                  description,
                  style: TextStyle(fontSize: Dimensions.fontSizeDefault),
                  maxLines: 1, overflow: TextOverflow.ellipsis,),

              RepoInfoRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  text: "$stars", language: language,
              ),
            ],
          ) : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Dimensions.paddingSizeSmall,
            children: [

              CircleAvatar(
                radius: Dimensions.radiusSizeExtraLarge,
                child: Text(firstLetter, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),

              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      name,
                      style:  TextStyle(fontWeight: FontWeight.bold,fontSize: Dimensions.fontSizeLarge),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (description.isNotEmpty)
                      Text(
                        description,
                        style: TextStyle(fontSize: Dimensions.fontSizeDefault),
                        maxLines: 1, overflow: TextOverflow.ellipsis),

                    RepoInfoRow(text: "$stars", language: language),
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
