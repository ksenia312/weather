import 'package:flutter/material.dart';

class FormattedText extends StatelessWidget {
  final String? title;
  final String? description;
  final bool isLarge;
  final double scale;
  final TextAlign textAlign;

  const FormattedText(
      {Key? key,
      this.title,
      this.description,
      this.isLarge = false,
      this.scale = 1.0,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = isLarge
        ? Theme.of(context).textTheme.bodyLarge
        : Theme.of(context).textTheme.bodySmall;
    return RichText(
      textScaleFactor: scale,
      textAlign: textAlign,
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
