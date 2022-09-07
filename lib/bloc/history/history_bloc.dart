import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/models/history_model.dart';
import 'package:weather/data/repositories/history_repository.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository historyRepository;

  HistoryBloc(this.historyRepository) : super(HistoryLoading()) {
    on<LoadHistoryEvent>((event, emit) async {
      try {
        DateTime date = DateTime.now();
        List<HistoryModel?> loadedHistory = [];
        for (int i = 1; i <= 3; i++) {
          loadedHistory.add(await historyRepository.loadWeatherByDate(
              date.subtract(Duration(days: i)).toString().substring(0, 10),
              event.city));
        }
        emit(HistoryLoaded(loadedHistory: loadedHistory));
      } catch (e) {
        emit(HistoryError(err: e.toString()));
      }
    });
  }
}
