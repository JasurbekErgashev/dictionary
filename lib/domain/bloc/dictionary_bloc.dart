import 'package:dictionary/data/repositories/local_db_repository.dart';
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
      final engUzbWords = await LocalDBRepository.instance.getAllEngUzbWords();
      final uzbEngWords = await LocalDBRepository.instance.getAllUzbEngWords();
      emit(
        SuccessDictionaryState(
          engUzbWords: engUzbWords,
          uzbEngWords: uzbEngWords,
        ),
      );
    } on Object catch (_) {
      emit(FailedDictionaryState());
    }
  }
}
