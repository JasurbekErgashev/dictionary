import 'package:dictionary/domain/bloc/online_dictionary_bloc.dart';
import 'package:dictionary/domain/event/online_dictionary_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchOnlineScreenViewModel {
  SearchOnlineScreenViewModel();

  void searchKeyword(BuildContext context, {required String keyword}) {
    BlocProvider.of<OnlineDictionaryBloc>(context).add(
      GetResults(keyword: keyword),
    );
  }

  void setInitial(BuildContext context) {
    BlocProvider.of<OnlineDictionaryBloc>(context).add(SetInitial());
  }
}
