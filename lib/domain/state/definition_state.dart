import 'package:dictionary/data/dto/definition.dart';
import 'package:equatable/equatable.dart';
import 'package:dictionary/domain/state/base_state.dart';

abstract class DefinitionState extends BaseState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitialDefinitionState extends DefinitionState {}

class LoadingDefinitionState extends DefinitionState {}

class FailedDefinitionState extends DefinitionState {}

class SuccessDefinitionState extends DefinitionState {
  SuccessDefinitionState({required this.defs});
  final List<Definition> defs;

  @override
  List<Object> get props => [...super.props, defs];
}
