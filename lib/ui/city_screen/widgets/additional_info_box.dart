import 'package:flutter/material.dart';
import 'package:weather/data/models/city_model.dart';
import 'package:weather/utils/formatted_text.dart';
import 'package:weather/utils/bordered_container.dart';

class AdditionalInfoBox extends StatelessWidget {
  final CityModel? city;

  const AdditionalInfoBox({Key? key, required this.city}) : super(key: key);

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
                    city?.humidity != null ? '${city?.humidity}%' : ' - ',
                scale: 1.1),
            FormattedText(
                title: 'Wind Speed: ',
                description:
                    city?.windKph != null ? '${city?.windKph} km/hour' : ' - ',
                scale: 1.1),
          ],
        ));
  }
}
