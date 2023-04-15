import 'package:equatable/equatable.dart';
import 'package:dictionary/domain/event/base_event.dart';

abstract class DictionaryEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class GetWordsEvent extends DictionaryEvent {}
