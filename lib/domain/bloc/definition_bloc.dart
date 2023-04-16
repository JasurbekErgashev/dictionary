import 'package:dictionary/data/repositories/local_db_repository.dart';
import 'package:dictionary/domain/bloc/base_bloc.dart';
import 'package:dictionary/domain/event/definition_event.dart';
import 'package:dictionary/domain/state/definition_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefinitionBloc extends BaseBloc<DefinitionEvent, DefinitionState> {
  DefinitionBloc() : super(InitialDefinitionState()) {
    on<GetDefsEvent>(_getDefs);
  }

  Future<void> _getDefs(
    GetDefsEvent event,
    Emitter<DefinitionState> emit,
  ) async {
    emit(LoadingDefinitionState());
    try {
      final defs = await LocalDBRepository.instance.getAllDefinitions();
      emit(SuccessDefinitionState(defs: defs));
    } on Object catch (_) {
      emit(FailedDefinitionState());
    }
  }
}
