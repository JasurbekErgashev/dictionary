import 'package:dictionary/data/dictionary_db.dart';
import 'package:dictionary/domain/bloc/base_bloc.dart';
import 'package:dictionary/domain/event/dictionary_event.dart';
import 'package:dictionary/domain/state/dictionary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryBloc extends BaseBloc<DictionaryEvent, DictionaryState> {
  DictionaryBloc() : super(InitialDictionaryState()) {
    on<GetWordsEvent>(_getWords);
  }

  Future<void> _getWords(
    GetWordsEvent event,
    Emitter<DictionaryState> emit,
  ) async {
    emit(LoadingDictionaryState());
    try {
      final engUzbWords = await DictionaryDatabase.instance.getAllEngUzbWords();
      final uzbEngWords = await DictionaryDatabase.instance.getAllUzbEngWords();
      final defWords = await DictionaryDatabase.instance.getAllDefWords();
      emit(
        SuccessDictionaryState(
          engUzbWords: engUzbWords,
          uzbEngWords: uzbEngWords,
          defWords: defWords,
        ),
      );
    } on Object catch (_) {
      emit(FailedDictionaryState());
    }
  }
}
