import 'package:equatable/equatable.dart';
import 'package:dictionary/domain/event/base_event.dart';

abstract class AddWordEvent extends BaseEvent with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class UploadNewWordEvent extends AddWordEvent {
  UploadNewWordEvent({
    required this.text1,
    required this.text2,
    required this.index,
  });
  final String text1;
  final String text2;
  final int index;

  @override
  List<Object?> get props => [...super.props, text1, text2];
}
