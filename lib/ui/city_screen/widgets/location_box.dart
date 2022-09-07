import 'package:flutter/material.dart';
import 'package:weather/data/models/city_model.dart';
import 'package:weather/utils/formatted_text.dart';
import 'package:weather/utils/bordered_container.dart';

class LocationBox extends StatelessWidget {
  final CityModel? city;

  const LocationBox({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FormattedText(
            title: '', description: city?.name ?? ' - ', isLarge: true),
        FormattedText(title: 'Region: ', description: city?.region ?? ' - '),
        FormattedText(title: 'County: ', description: city?.country ?? ' - '),
      ],
    ));
  }
}
