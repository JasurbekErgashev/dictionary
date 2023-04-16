import 'package:dictionary/app/navigation/app_route.dart';
import 'package:dictionary/app/ui/screens/definition/definition_screen_view_model.dart';
import 'package:dictionary/app/ui/screens/home/home_screen_view_model.dart';
import 'package:dictionary/app/ui/screens/result/result_screen.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/data/dto/definition.dart';
import 'package:dictionary/data/dto/eng_uzb.dart';
import 'package:dictionary/data/dto/uzb_eng.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class EngUzbList extends StatelessWidget {
  const EngUzbList({
    required this.engUzbWords,
    required this.viewModel,
    super.key,
  });

  final List<EngUzb> engUzbWords;
  final HomeScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return engUzbWords.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () => viewModel.showWordDefDialog(
                  context,
                  engUzbWords[index].eng,
                  engUzbWords[index].uzb,
                ),
                onTap: () => context.push(
                  AppRoute.result,
                  extra: ResultScreenData(
                    title: engUzbWords[index].eng,
                    mainContent: engUzbWords[index].uzb,
                    subContent: engUzbWords[index].pron,
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
                child: ListItem(title: engUzbWords[index].eng),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemCount: engUzbWords.length,
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

class UzbEngList extends StatelessWidget {
  const UzbEngList({
    required this.uzbEngWords,
    required this.viewModel,
    super.key,
  });

  final List<UzbEng> uzbEngWords;
  final HomeScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return uzbEngWords.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () => viewModel.showWordDefDialog(
                  context,
                  uzbEngWords[index].uzb,
                  uzbEngWords[index].eng,
                ),
                onTap: () => context.push(
                  AppRoute.result,
                  extra: ResultScreenData(
                    title: uzbEngWords[index].uzb,
                    mainContent: uzbEngWords[index].eng,
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
                child: ListItem(title: uzbEngWords[index].uzb),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemCount: uzbEngWords.length,
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

class DefList extends StatelessWidget {
  const DefList({
    required this.defs,
    required this.viewModel,
    super.key,
  });

  final List<Definition> defs;
  final DefinitionScreenViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return defs.isNotEmpty
        ? ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () => viewModel.showWordDefDialog(
                  context,
                  defs[index].word,
                  defs[index].description,
                ),
                onTap: () => context.push(
                  AppRoute.result,
                  extra: ResultScreenData(
                    title: defs[index].word,
                    mainContent: defs[index].description,
                    subContent: defs[index].type,
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
                child: ListItem(title: defs[index].word),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 8);
            },
            itemCount: defs.length,
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

class ListItem extends StatelessWidget {
  const ListItem({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title, style: AppTypography.p),
    );
  }
}
