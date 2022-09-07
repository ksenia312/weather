import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/home_screen/home_screen.dart';
import 'utils/providers.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  AppTheme.setTheme(isDark: _prefs.getBool('isDark') ?? true);
  runApp(MultiProvider(providers: providers, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(
        builder: (BuildContext context, AppTheme appTheme, Widget? child) {
      return MaterialApp(
        title: 'Weather',
        debugShowCheckedModeBanner: false,
        theme: appTheme.light,
        darkTheme: appTheme.dark,
        themeMode: appTheme.themeMode,
        home: const HomeScreen(),
      );
    });
  }
}
