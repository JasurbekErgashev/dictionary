import 'package:dictionary/constants/app_fonts.dart';
import 'package:dictionary/domain/bloc/dictionary_bloc.dart';
import 'package:dictionary/domain/event/dictionary_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefinitionViewModel {
  DefinitionViewModel();

  void getWords(BuildContext context) {
    BlocProvider.of<DictionaryBloc>(context).add(GetWordsEvent());
  }

  void showWordDefDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: AppTypography.h3Bold),
          content: Text(content, style: AppTypography.pSmallBlueGrey),
        );
      },
    );
  }
}
