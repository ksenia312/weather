import 'package:flutter/material.dart';
import 'package:weather/data/models/city_model.dart';
import 'package:weather/utils/formatted_text.dart';

class TemperatureBox extends StatefulWidget {
  final CityModel? city;

  const TemperatureBox({Key? key, this.city}) : super(key: key);

  @override
  State<TemperatureBox> createState() => _TemperatureBoxState();
}

class _TemperatureBoxState extends State<TemperatureBox> {
  bool _showCelsius = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_showCelsius)
          FormattedText(
            title: '',
            description: '${widget.city?.tempC ?? ' - '} °C',
            isLarge: true,
            scale: 1.5,
          ),
        if (_showCelsius)
          FormattedText(
            title: 'Feels like: ',
            description: '${widget.city?.feelsLikeC ?? ' - '} °C',
            scale: 1.5,
          ),
        if (!_showCelsius)
          FormattedText(
              title: '',
              description: '${widget.city?.tempF ?? ' - '} F',
              scale: 1.5,
              isLarge: true),
        if (!_showCelsius)
          FormattedText(
            title: 'Feels like: ',
            description: '${widget.city?.feelsLikeF ?? ' - '} F',
            scale: 1.5,
          ),
        _descriptionRow,
        _dropdownButton,
      ],
    );
  }

  get _dropdownButton => DropdownButton<bool>(
      value: _showCelsius,
      style: Theme.of(context).textTheme.bodyMedium,
      iconEnabledColor: Theme.of(context).dividerColor,
      isExpanded: true,
      underline: const Divider(height: 5),
      items: const <DropdownMenuItem<bool>>[
        DropdownMenuItem<bool>(
          key: ValueKey(true),
          value: true,
          child: Text('Display in °C'),
        ),
        DropdownMenuItem<bool>(
          key: ValueKey(false),
          value: false,
          child: Text('Display in F'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _showCelsius = value!;
        });
      });

  get _descriptionRow => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.city?.text != null ? '${widget.city?.text} ' : ' - ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Image.network(
            widget.city?.icon != null ? 'https:${widget.city?.icon}' : '',
            width: 30,
            height: 30,
            errorBuilder: (_, __, ___) {
              return const Icon(Icons.emoji_emotions_outlined);
            },
          ),
        ],
      );
}
