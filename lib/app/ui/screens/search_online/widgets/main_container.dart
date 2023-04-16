import 'package:dictionary/app/ui/screens/search_online/widgets/definition_item.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/dto/online_dictionary.dart';
import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({required this.od, required this.playAudio, super.key});

  final OnlineDictionary od;
  final Function(String) playAudio;

  @override
  Widget build(BuildContext context) {
    final filteredPhonetics = filterPhonetics(od.phonetics);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(od.word ?? '', style: AppTypography.h3),
              Text(od.phonetic ?? '', style: AppTypography.pSBGdef),
            ],
          ),
          const SizedBox(height: 8),
          Text('Phonetics', style: AppTypography.pBlue),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () => playAudio(
                        filteredPhonetics[index].audio!,
                      ),
                      icon: const Icon(Icons.volume_up_rounded),
                    ),
                    Text(
                      filteredPhonetics[index].text!,
                      style: AppTypography.pSBGdef,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 5);
              },
              itemCount: filteredPhonetics.length,
            ),
          ),
          const SizedBox(height: 8),
          od.meanings == null
              ? const SizedBox()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          od.meanings![i].partOfSpeech ?? '',
                          style: AppTypography.pBlue,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DefinitionItem(
                              def: od.meanings![i].definitions![index],
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: od.meanings![i].definitions!.length,
                        ),
                        const Divider(color: AppColors.black),
                        Text('synonyms:', style: AppTypography.pBlue),
                        Text(
                          od.meanings![i].synonyms!.join(', '),
                          style: AppTypography.pSmall,
                        ),
                        Text('antonyms:', style: AppTypography.pBlue),
                        Text(
                          od.meanings![i].antonyms!.join(', '),
                          style: AppTypography.pSmall,
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemCount: od.meanings!.length,
                ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  List<Phonetic> filterPhonetics(List<Phonetic>? phonetics) {
    if (phonetics == null) return [];
    return phonetics.where((phonetic) {
      if (phonetic.text == null || phonetic.audio == null) return false;
      if (phonetic.text!.isEmpty || phonetic.audio!.isEmpty) return false;
      return true;
    }).toList();
  }
}
