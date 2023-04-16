import 'package:equatable/equatable.dart';
import 'package:dictionary/domain/event/base_event.dart';

abstract class OnlineDictionaryEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class GetResults extends OnlineDictionaryEvent {
  GetResults({required this.keyword});
  final String keyword;

  @override
  List<Object?> get props => [...super.props, keyword];
}

class SetInitial extends OnlineDictionaryEvent {}
