part of 'history_bloc.dart';

@immutable
abstract class HistoryState {
  List<HistoryModel?> get history => [];

  String? get error => null;
}

class HistoryLoading extends HistoryState {
  @override
  List<HistoryModel?> get history => [];
}

class HistoryLoaded extends HistoryState {
  final List<HistoryModel?> loadedHistory;

  HistoryLoaded({required this.loadedHistory});

  @override
  List<HistoryModel?> get history => loadedHistory;
}

class HistoryError extends HistoryState {
  final String err;

  HistoryError({required this.err});

  @override
  String? get error => err;
}
