import 'package:flutter/material.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/utils/formatted_text.dart';
import 'package:weather/widgets/unit_dropdown.dart';

/// Виджет [TemperatureBox] для отображение данных о температуре на данных момент
class TemperatureBox extends StatefulWidget {
  final WeatherModel? current;

  const TemperatureBox({Key? key, this.current}) : super(key: key);

  @override
  State<TemperatureBox> createState() => _TemperatureBoxState();
}

class _TemperatureBoxState extends State<TemperatureBox> {
  bool _showCelsius = true;

  void _onChanged(bool? value) {
    setState(() {
      _showCelsius = value!;
    });
  } // функция переключения отображаемых единиц измерения

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FormattedText(
          description: _showCelsius
              ? '${widget.current?.tempC} °C'
              : '${widget.current?.tempF} F',
          isLarge: true,
          scale: 1.5,
        ),
        FormattedText(
          title: 'Feels like: ',
          description: _showCelsius
              ? '${widget.current?.feelsLikeC} °C'
              : '${widget.current?.feelsLikeF} F',
          scale: 1.5,
        ),
        _descriptionRow,
        UnitDropdown(showCelsius: _showCelsius, onChanged: _onChanged)
        // кастомный dropdown с выбором единиц измерения
      ],
    );
  }

  get _descriptionRow => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.current?.text != null ? '${widget.current?.text} ' : ' - ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // отображение состояния погоды текстовым описанием
          Image.network(
            widget.current?.icon != null ? 'https:${widget.current?.icon}' : '',
            width: 30,
            height: 30,
            errorBuilder: (_, __, ___) {
              return const Icon(Icons.emoji_emotions_outlined);
              // отображается, если иконка с сервера недоступна
            },
          ), // отображение иконки из API
        ],
      );
}
