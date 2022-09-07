import 'package:flutter/material.dart';

class FormattedText extends StatelessWidget {
  final String title;
  final String description;
  final bool isLarge;
  final double scale;

  const FormattedText(
      {Key? key,
      required this.title,
      required this.description,
      this.isLarge = false,
      this.scale = 1.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = isLarge
        ? Theme.of(context).textTheme.bodyLarge
        : Theme.of(context).textTheme.bodySmall;
    return RichText(
      textScaleFactor: scale,
      text: TextSpan(
        text: title,
        style: style!.copyWith(fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: description,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
