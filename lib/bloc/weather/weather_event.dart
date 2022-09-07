part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
  const WeatherEvent();
}

class LoadWeatherEvent extends WeatherEvent {
  final String name;

  const LoadWeatherEvent({required this.name});
}
