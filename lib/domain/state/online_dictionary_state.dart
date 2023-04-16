import 'package:dictionary/data/dto/online_dictionary.dart';
import 'package:equatable/equatable.dart';
import 'package:dictionary/domain/state/base_state.dart';

abstract class OnlineDictionaryState extends BaseState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitialOnlineDictionaryState extends OnlineDictionaryState {}

class LoadingOnlineDictionaryState extends OnlineDictionaryState {}

class FailedOnlineDictionaryState extends OnlineDictionaryState {}

class NotFoundOnlineDictionaryState extends OnlineDictionaryState {}

class SuccessOnlineDictionaryState extends OnlineDictionaryState {
  SuccessOnlineDictionaryState({required this.results});
  final List<OnlineDictionary> results;

  @override
  List<Object> get props => [...super.props, results];
}
