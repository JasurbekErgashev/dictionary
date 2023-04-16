import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/dto/online_dictionary.dart';
import 'package:flutter/material.dart';

class DefinitionItem extends StatelessWidget {
  const DefinitionItem({this.def, super.key});

  final Definition? def;

  @override
  Widget build(BuildContext context) {
    if (def == null) {
      return const SizedBox();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(def!.definition ?? ''),
          const Text('synonyms:', style: AppTypography.p),
          Text(def!.synonyms!.join(', '), style: AppTypography.pSmall),
          const Text('antonyms:', style: AppTypography.p),
          Text(def!.antonyms!.join(', '), style: AppTypography.pSmall),
          Text('Exp: ${def!.example ?? ''}', style: AppTypography.pSItalic),
        ],
      );
    }
  }
}
