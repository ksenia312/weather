import 'package:flutter/material.dart';
import 'package:weather/ui/weather_screen/weather_screen.dart';

/// Утилита [AppNavigator] для быстрого объявления перехода на новый экран с
/// дополнительными процессами
class AppNavigator {
  final BuildContext context;

  AppNavigator.of(this.context);

  void pushToCity({required String city}) {
    FocusScope.of(context).unfocus();
    // убрать фокус с текстового поля
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WeatherScreen(
          city: city,
        ),
      ),
    );
  }
}
