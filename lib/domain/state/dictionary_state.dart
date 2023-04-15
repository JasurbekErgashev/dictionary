import 'package:dictionary/data/dto/eng_uzb.dart';
import 'package:dictionary/data/dto/uzb_eng.dart';
import 'package:equatable/equatable.dart';
import 'package:dictionary/domain/state/base_state.dart';

abstract class DictionaryState extends BaseState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class InitialDictionaryState extends DictionaryState {}

class LoadingDictionaryState extends DictionaryState {}

class FailedDictionaryState extends DictionaryState {}

class SuccessDictionaryState extends DictionaryState {
  SuccessDictionaryState({
    required this.engUzbWords,
    required this.uzbEngWords,
  });
  final List<EngUzb> engUzbWords;
  final List<UzbEng> uzbEngWords;

  @override
  List<Object> get props => [...super.props, engUzbWords, uzbEngWords];
}
