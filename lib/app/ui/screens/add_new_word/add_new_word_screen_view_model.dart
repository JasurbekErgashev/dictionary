import 'package:dictionary/domain/bloc/newword_bloc.dart';
import 'package:dictionary/domain/event/add_word_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewWordScreenViewModel {
  AddNewWordScreenViewModel();

  void uploadNewWord(
    BuildContext context, {
    required String text1,
    required String text2,
    required int index,
  }) {
    BlocProvider.of<AddNewWordBloc>(context).add(
      UploadNewWordEvent(text1: text1, text2: text2, index: index),
    );
  }
}
