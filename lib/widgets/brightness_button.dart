import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/utils/theme.dart';

class BrightnessButton extends StatelessWidget {
  const BrightnessButton({Key? key}) : super(key: key);

  Future<void> toggleTheme(AppTheme appTheme) async {
    appTheme.toggleTheme();
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('isDark', appTheme.themeMode == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Provider.of<AppTheme>(context);
    bool _isLight = Theme.of(context).brightness == Brightness.light;
    return IconButton(
        onPressed: () async {
          await toggleTheme(appTheme);
        },
        icon: Icon(_isLight ? Icons.wb_sunny : Icons.brightness_2));
  }
}
