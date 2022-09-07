part of 'selection_bloc.dart';

@immutable
abstract class SelectionEvent {
  const SelectionEvent();
}

class LoadSelectionsEvent extends SelectionEvent {
  final String value;

  const LoadSelectionsEvent({required this.value});
}

class SetInitEvent extends SelectionEvent {}
