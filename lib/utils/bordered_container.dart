import 'package:flutter/material.dart';

/// [BorderedContainer] - обертка контейнером с заданной обводкой
class BorderedContainer extends StatelessWidget {
  final Widget child;
  final bool isSecondary;

  const BorderedContainer(
      {Key? key, required this.child, this.isSecondary = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: _decoration(context),
      child: child,
    );
  }

  BoxDecoration _decoration(context) => BoxDecoration(
        color: isSecondary
            ? Theme.of(context).hoverColor
            : Theme.of(context).primaryColorLight,
        border: Border.all(
            color: isSecondary
                ? Theme.of(context).focusColor
                : Theme.of(context).dividerColor,
            width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      );
// отрисовка 2 видов - по дефолту primary, можно задать secondary
}
