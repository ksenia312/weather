import 'package:flutter/material.dart';
import 'package:weather/utils/navigator.dart';

class QuickAccess extends StatefulWidget {
  const QuickAccess({Key? key}) : super(key: key);
  static const quickAccessCities = [
    'London',
    'Saint-Petersburg',
    'Moscow',
    'Los-Angeles',
    'Tokio',
    'New York',
    'Rome',
    'Paris',
    'Dubai',
    'Ri'
  ];

  @override
  State<QuickAccess> createState() => _QuickAccessState();
}

class _QuickAccessState extends State<QuickAccess> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: const EdgeInsets.only(bottom: 10.0),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        childAspectRatio: 25 / 9,
        shrinkWrap: true,
        children: QuickAccess.quickAccessCities
            .map((city) => ElevatedButton(
                  onPressed: () {
                    AppNavigator.of(context).pushToCity(city: city);
                  },
                  child: Center(
                      child: Text(
                    city,
                    textAlign: TextAlign.center,
                  )),
                ))
            .toList());
  }
}
