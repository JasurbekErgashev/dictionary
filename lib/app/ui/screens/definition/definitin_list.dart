import 'package:dictionary/app/navigation/app_route.dart';
import 'package:dictionary/app/ui/screens/definition/result_definition.dart';
import 'package:dictionary/app/ui/screens/home/home_screen_view_model.dart';
import 'package:dictionary/app/ui/widgets/dictionary_list.dart';
import 'package:dictionary/constants/app_assets.dart';
import 'package:dictionary/data/dto/definition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DefinitionList extends StatelessWidget {
  const DefinitionList({
    required this.defWords,
    required this.viewModel,
    super.key,
  });

  final List<Definition> defWords;
  final HomeScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return defWords.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () => viewModel.showWordDefDialog(
                  context,
                  defWords[index].word,
                  defWords[index].description,
                ),
                onTap: () => context.push(
                  AppRoute.resultDefinition,
                  extra: ResultDefinitionScreenData(
                    title: defWords[index].word,
                    type: defWords[index].type,
                    description: defWords[index].description
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
                child: ListItem(title: defWords[index].word),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemCount: defWords.length,
          )
        : Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: SvgPicture.asset(AppAssets.notFound),
            ),
          );
  }
}
