import 'package:flutter/material.dart';

class UnitDropdown extends StatelessWidget {
  final bool showCelsius;
  final void Function(bool?)? onChanged;

  const UnitDropdown(
      {Key? key, required this.showCelsius, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<bool>(
        value: showCelsius,
        style: Theme.of(context).textTheme.bodyMedium,
        iconEnabledColor: Theme.of(context).dividerColor,
        dropdownColor:Theme.of(context).primaryColorLight,
        isExpanded: true,
        underline: Divider(
          thickness: 1,
          height: 1,
          color: Theme.of(context).dividerColor,
        ),
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
        onChanged: onChanged);
  }
}
