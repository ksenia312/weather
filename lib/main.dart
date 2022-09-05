import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'utils/theme.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(appTheme.currentTheme);
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: appTheme.currentTheme,
      home: const HomeScreen(),
    );
  }
}
