import 'package:dictionary/app/ui/widgets/mic_grower.dart';
import 'package:dictionary/app/ui/widgets/scroll_behaviour.dart';
import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/domain/bloc/dictionary_bloc.dart';
import 'package:dictionary/domain/event/dictionary_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HomeScreenViewModel {
  HomeScreenViewModel();

  void getWords(BuildContext context) {
    BlocProvider.of<DictionaryBloc>(context).add(GetWordsEvent());
  }

  void showWordDefDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: AppTypography.h3Bold),
          content: HtmlWidget(content, textStyle: AppTypography.pSmallBlueGrey),
        );
      },
    );
  }

  void showVoiceModalSheet(BuildContext context, String text) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const MicGrower(),
                  Text(text),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
