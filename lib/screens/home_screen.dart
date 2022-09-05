import 'package:flutter/material.dart';
import 'package:weather/utils/theme.dart';
import 'package:weather/widgets/brightness_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добро пожаловать!'),
        actions: const [BrightnessButton()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ddddddddd',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'dfffffffffff',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'dgggggggggg',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
