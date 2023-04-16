import 'package:equatable/equatable.dart';
import 'package:dictionary/domain/state/base_state.dart';

abstract class AddWordState extends BaseState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitialAddWordState extends AddWordState {}

class LoadingAddWordState extends AddWordState {}

class FailedAddWordState extends AddWordState {}

class SuccessAddWordState extends AddWordState {}
