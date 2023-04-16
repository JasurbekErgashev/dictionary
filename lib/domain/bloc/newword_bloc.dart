import 'package:dictionary/data/dto/definition.dart';
import 'package:dictionary/data/dto/eng_uzb.dart';
import 'package:dictionary/data/dto/uzb_eng.dart';
import 'package:dictionary/data/repositories/local_db_repository.dart';
import 'package:dictionary/domain/bloc/base_bloc.dart';
import 'package:dictionary/domain/event/add_word_event.dart';
import 'package:dictionary/domain/state/add_word_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewWordBloc extends BaseBloc<AddWordEvent, AddWordState> {
  AddNewWordBloc() : super(InitialAddWordState()) {
    on<UploadNewWordEvent>(_uploadNewWord);
  }

  Future<void> _uploadNewWord(
    UploadNewWordEvent event,
    Emitter<AddWordState> emit,
  ) async {
    emit(LoadingAddWordState());
    try {
      if (event.index == 1) {
        await LocalDBRepository.instance.addItemToEngUzb(
          item: EngUzb(
            eng: event.text1,
            pron: '',
            uzb: event.text2,
            isFav: 0,
            isHistory: 0,
          ),
        );
      } else if (event.index == 2) {
        await LocalDBRepository.instance.addItemToUzbEng(
          item: UzbEng(
            uzb: event.text1,
            eng: event.text2,
            eng1: '',
            eng2: '',
            isFav: 0,
            isHistory: 0,
          ),
        );
      } else {
        await LocalDBRepository.instance.addItemToDef(
          item: Definition(
            word: event.text1,
            type: '',
            description: event.text2,
            idAlphabet: 1,
          ),
        );
      }
      emit(SuccessAddWordState());
    } on Object catch (_) {
      emit(FailedAddWordState());
    }
  }
}
