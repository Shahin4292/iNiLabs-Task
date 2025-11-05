import 'package:flutter/material.dart';
import 'package:inilabs_assignment/utils/dimensions.dart';

class RepoInfoRow extends StatelessWidget {
  final String text;
  final String language;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const RepoInfoRow({
    super.key,
    required this.text,
    required this.language,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: [

        Icon(Icons.star, size: Dimensions.fontSizeLarge, color: Colors.amber),

         SizedBox(width: Dimensions.paddingSizeExtraSmall),

        Text(text, style: Theme.of(context).textTheme.bodyMedium),

        SizedBox(width: Dimensions.paddingSizeDefault),

         Icon(Icons.code, size: Dimensions.fontSizeLarge),

        SizedBox(width: Dimensions.paddingSizeExtraSmall),

        Flexible(child: Text(language, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium)),
      ],
    );
  }
}
