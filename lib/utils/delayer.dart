import 'dart:async';

/// Класс [Delayer] для поиска по началу ввода с задержкой
class Delayer {
  final int milliseconds;
  Timer? _timer;

  Delayer({required this.milliseconds});

  run(Function() action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  cancel() {
    _timer?.cancel();
  }
}
