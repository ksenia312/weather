import 'package:flutter/material.dart';
import 'package:weather/widgets/brightness_button.dart';

import 'widgets/city_picker.dart';
import 'widgets/quick_access.dart';

/// Первый экран куда попадает пользователь - [HomeScreen]
/// Содержит блоки, с помощью которых пользователь выбирает город
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather forecast'),
        actions: const [BrightnessButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: [
            const CityPicker(),
            // виджет выбора города

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text('Quick access',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            // заголовок

            const QuickAccess()
            // GridView с быстрым доступом к популярным городам
          ],
        ),
      ),
    );
  }
}
