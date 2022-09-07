import 'package:flutter/material.dart';
import 'package:weather/utils/navigator.dart';

/// Виджет [QuickAccess] содержит кнопки с переходом на экран
/// прогноза погоды для популярных городов
class QuickAccess extends StatefulWidget {
  const QuickAccess({Key? key}) : super(key: key);

  @override
  State<QuickAccess> createState() => _QuickAccessState();
}

class _QuickAccessState extends State<QuickAccess> {
  static const quickAccessCities = [
    'London',
    'Saint-Petersburg',
    'Moscow',
    'Los-Angeles',
    'Tokio',
    'New York',
    'Rome',
    'Paris',
    'Dubai',
    'Riga'
  ];

  // статический список популярных городов
  // масштабируется до получения популярных городов с API
  // или добавление ближайших городов по локации пользователя
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.only(bottom: 10.0),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        childAspectRatio: 25 / 9,
        shrinkWrap: true,
        children: quickAccessCities
            .map((city) => ElevatedButton(
                  onPressed: () {
                    AppNavigator.of(context).pushToCity(city: city);
                    // перенаправление на новый экран кастомным навигатором
                  },
                  child: Center(
                      child: Text(
                    city,
                    textAlign: TextAlign.center,
                  )),
                ))
            .toList());
  }
}
