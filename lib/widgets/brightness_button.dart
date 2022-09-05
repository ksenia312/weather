import 'package:flutter/material.dart';
import 'package:weather/utils/theme.dart';

class BrightnessButton extends StatelessWidget {
  const BrightnessButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          appTheme.toggleTheme();
        },
        icon: Icon(appTheme.currentTheme == ThemeMode.light
            ? Icons.wb_sunny
            : Icons.brightness_2));
  }
}
