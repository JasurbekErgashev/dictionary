import 'package:dictionary/constants/constants.dart';
import 'package:dictionary/domain/bloc/definition_bloc.dart';
import 'package:dictionary/domain/event/definition_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefinitionScreenViewModel {
  DefinitionScreenViewModel();

  void getDefs(BuildContext context) {
    BlocProvider.of<DefinitionBloc>(context).add(GetDefsEvent());
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
