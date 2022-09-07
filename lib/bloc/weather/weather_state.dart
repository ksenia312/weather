part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {
  WeatherModel? get current => null;

  String? get error => null;
}

class WeatherLoading extends WeatherState {
  @override
  WeatherModel? get current => null;
}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;

  WeatherLoaded({required this.weather});

  @override
  WeatherModel? get current => weather;
}

class WeatherError extends WeatherState {
  final String err;

  WeatherError({required this.err});

  @override
  String get error => err;
}
