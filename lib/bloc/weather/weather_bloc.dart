import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repositories/weather_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository _cityRepository;

  WeatherBloc(this._cityRepository) : super(WeatherLoading()) {
    on<LoadWeatherEvent>((event, emit) async {
      emit(WeatherLoading());
      try {
        final city = await _cityRepository.loadWeatherByName(event.name);
        emit(WeatherLoaded(weather: city));
      } catch (e) {
        emit(WeatherError(err: e.toString()));
      }
    });
  }
}
