import 'package:flutter/material.dart';
import 'package:weather/widgets/brightness_button.dart';

import 'widgets/city_picker.dart';
import 'widgets/quick_access.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void deactivate() {
    print('deactivate HomeScreen');
    super.deactivate();
  }
  @override
  void dispose() {
    print('dispose HomeScreen');
    super.dispose();
  }
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text('Quick access',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            const QuickAccess()
          ],
        ),
      ),
    );
  }
}
