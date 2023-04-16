import 'package:equatable/equatable.dart';
import 'package:dictionary/domain/event/base_event.dart';

abstract class DefinitionEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class GetDefsEvent extends DefinitionEvent {}
