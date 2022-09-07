import 'package:flutter/material.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/utils/formatted_text.dart';
import 'package:weather/utils/bordered_container.dart';

/// Виджет [AdditionalInfoBox] для отображения дополнительной информации о погоде
class AdditionalInfoBox extends StatelessWidget {
  final WeatherModel? current;

  const AdditionalInfoBox({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
        isSecondary: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormattedText(
                title: 'Humidity: ',
                description:
                    current?.humidity != null ? '${current?.humidity}%' : ' - ',
                scale: 1.1),
            FormattedText(
                title: 'Wind Speed: ',
                description: current?.windKph != null
                    ? '${current?.windKph} km/hour'
                    : ' - ',
                scale: 1.1),
          ],
        ));
  }
}
