import 'package:flutter/material.dart';
import 'package:weather/ui/city_screen/city_screen.dart';

class AppNavigator {
  final BuildContext context;

  AppNavigator.of(this.context);

  void pushToCity({required String city}) {
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CityScreen(
          city: city,
        ),
      ),
    );
  }
}
