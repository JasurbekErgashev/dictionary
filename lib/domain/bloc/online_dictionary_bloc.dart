import 'package:dictionary/data/repositories/online_dictionary_repository.dart';
import 'package:dictionary/domain/bloc/base_bloc.dart';
import 'package:dictionary/domain/event/online_dictionary_event.dart';
import 'package:dictionary/domain/state/online_dictionary_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineDictionaryBloc
    extends BaseBloc<OnlineDictionaryEvent, OnlineDictionaryState> {
  OnlineDictionaryBloc() : super(InitialOnlineDictionaryState()) {
    on<GetResults>(_getResults);
    on<SetInitial>(_setInitial);
  }

  final OnlineDictionaryRepository repository = OnlineDictionaryRepository();

  void _setInitial(SetInitial event, Emitter<OnlineDictionaryState> emit) {
    emit(InitialOnlineDictionaryState());
  }

  Future<void> _getResults(
    GetResults event,
    Emitter<OnlineDictionaryState> emit,
  ) async {
    emit(LoadingOnlineDictionaryState());
    try {
      final results = await repository.searchKeyword(keyword: event.keyword);

      results.fold<void>(
        (failure) {
          if (failure == Failure.e404) {
            emit(NotFoundOnlineDictionaryState());
          } else {
            emit(FailedOnlineDictionaryState());
          }
        },
        (results) => emit(SuccessOnlineDictionaryState(results: results)),
      );
    } on Object catch (_) {
      emit(FailedOnlineDictionaryState());
    }
  }
}
