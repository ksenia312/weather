import 'package:flutter/material.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/utils/formatted_text.dart';
import 'package:weather/utils/bordered_container.dart';

class LocationBox extends StatelessWidget {
  final WeatherModel? current;

  const LocationBox({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FormattedText(
            title: '', description: current?.city ?? ' - ', isLarge: true),
        FormattedText(title: 'Region: ', description: current?.region ?? ' - '),
        FormattedText(title: 'County: ', description: current?.country ?? ' - '),
      ],
    ));
  }
}
