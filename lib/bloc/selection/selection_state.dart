part of 'selection_bloc.dart';

@immutable
abstract class SelectionState {
  List<SelectionModel?> get selections => [];

  String? get err => null;
}

class SelectionInit extends SelectionState {
  @override
  List<SelectionModel?> get selections => [];
}

class SelectionLoading extends SelectionState {
  @override
  List<SelectionModel?> get selections => [];
}

class SelectionLoaded extends SelectionState {
  final List<SelectionModel?> currentSelections;

  SelectionLoaded({required this.currentSelections});

  @override
  List<SelectionModel?> get selections => currentSelections;
}

class SelectionError extends SelectionState {
  final String error;

  SelectionError({required this.error});

  @override
  String get err => error;
}
