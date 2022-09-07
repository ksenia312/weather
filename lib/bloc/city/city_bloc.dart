import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/bloc/selection/selection_bloc.dart';
import 'package:weather/data/models/city_model.dart';
import 'package:weather/data/repositories/city_repository.dart';

part 'city_event.dart';

part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository _cityRepository;

  CityBloc(this._cityRepository) : super(CityLoading()) {
    on<LoadCityEvent>((event, emit) async {
      emit(CityLoading());
      try {
        final city = await _cityRepository.loadCityByName(event.name);
        emit(CityLoaded(currentCity: city));
      } catch (e) {
        emit(CityError(error: e.toString()));
      }
    });
  }
}
