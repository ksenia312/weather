import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme with ChangeNotifier {
  bool _isDark = false;

  ThemeMode get currentTheme {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeData _basicTheme({required AppColors appColors}) => ThemeData(
        scaffoldBackgroundColor: appColors.scaffold,
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
            bodySmall: _textStyle(appColors: appColors, fontSize: 12),
            bodyMedium: _textStyle(appColors: appColors, fontSize: 16),
            bodyLarge: _textStyle(appColors: appColors, fontSize: 18)),
        appBarTheme: AppBarTheme(
          backgroundColor: appColors.appBar,
          foregroundColor: appColors.foreground,
          iconTheme: IconThemeData(color: appColors.foreground),
          elevation: 3,
        ),
      );

  TextStyle _textStyle(
          {required AppColors appColors, required double fontSize}) =>
      TextStyle(color: appColors.foreground, fontSize: fontSize);

  ThemeData get light => _basicTheme(appColors: ColorsLight());

  ThemeData get dark => _basicTheme(appColors: ColorsDark());

  toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

AppTheme appTheme = AppTheme();
