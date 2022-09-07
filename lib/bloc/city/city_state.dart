part of 'city_bloc.dart';

@immutable
abstract class CityState {
  CityModel? get city => null;

  String? get err => null;
}

class CityLoading extends CityState {
  @override
  CityModel? get city => null;
}

class CityLoaded extends CityState {
  final CityModel currentCity;

  CityLoaded({required this.currentCity});

  @override
  CityModel? get city => currentCity;
}

class CityError extends CityState {
  final String error;

  CityError({required this.error});

  @override
  String get err => error;
}
