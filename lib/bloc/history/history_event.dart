part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {
  const HistoryEvent();
}

class LoadHistoryEvent extends HistoryEvent {
  final String city;

  const LoadHistoryEvent({required this.city});
}
