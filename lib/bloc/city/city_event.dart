part of 'city_bloc.dart';

@immutable
abstract class CityEvent {
  const CityEvent();
}

class LoadCityEvent extends CityEvent {
  final String name;

  const LoadCityEvent({required this.name});
}
