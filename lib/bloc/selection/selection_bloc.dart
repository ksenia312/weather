import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/models/selection_model.dart';
import 'package:weather/data/repositories/selection_repository.dart';

part 'selection_event.dart';

part 'selection_state.dart';

/// [SelectionBloc] - для локального state-management'а опций ввода
class SelectionBloc extends Bloc<SelectionEvent, SelectionState> {
  final SelectionRepository selectionRepository;

  SelectionBloc(this.selectionRepository) : super(SelectionInit()) {
    on<LoadSelectionsEvent>((event, emit) async {
      // когда вызывается LoadSelectionsEvent выполняются действия ниже
      emit(SelectionLoading());
      try {
        final currentSelections =
            await selectionRepository.loadSelections(event.value);
        emit(SelectionLoaded(currentSelections: currentSelections));
      } catch (e) {
        emit(SelectionError(err: e.toString()));
      }
    });
    on<SetInitEvent>((event, emit) async {
      // когда вызывается SetInitEvent выполняются действия ниже
      emit(SelectionInit());
    });
    // в конце всегда возвращаем обновленное состояние SelectionState
  }
}
