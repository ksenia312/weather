import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme with ChangeNotifier {
  static bool _isDark = true;

  ThemeMode get themeMode {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeData _theme({required AppColors appColors}) => ThemeData(
        brightness: _isDark ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: appColors.scaffold,
        dividerColor: appColors.dividerColor,
        primaryColorLight: appColors.primaryLight,
        errorColor: appColors.error,
        highlightColor: appColors.highlight,
        textTheme: _textTheme(appColors),
        iconTheme: IconThemeData(color: appColors.accentForeground),
        appBarTheme: _appBarTheme(appColors),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: appColors.foreground),
        outlinedButtonTheme: _outlinedButtonTheme(appColors),
      );

  TextTheme _textTheme(AppColors appColors) => TextTheme(
        bodySmall: TextStyle(color: appColors.foreground, fontSize: 13),
        bodyMedium: TextStyle(color: appColors.foreground, fontSize: 16),
        bodyLarge: TextStyle(color: appColors.foreground, fontSize: 18),
      );

  AppBarTheme _appBarTheme(appColors) => AppBarTheme(
        backgroundColor: appColors.appBarBackground,
        foregroundColor: appColors.accentForeground,
        iconTheme: IconThemeData(color: appColors.accentForeground),
        elevation: 3,
      );

  OutlinedButtonThemeData _outlinedButtonTheme(appColors) =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color?>(appColors.foreground),
            side: MaterialStateProperty.all<BorderSide?>(
                BorderSide(color: appColors.foreground))),
      );

  ThemeData get light => _theme(appColors: ColorsLight());

  ThemeData get dark => _theme(appColors: ColorsDark());

  toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  static setTheme({required bool isDark}) {
    _isDark = isDark;
  }
}
