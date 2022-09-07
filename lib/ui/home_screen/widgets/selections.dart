import 'package:flutter/material.dart';
import 'package:weather/bloc/selection/selection_bloc.dart';
import 'package:weather/data/models/selection_model.dart';

class Selections extends StatefulWidget {
  final SelectionState state;

  final String? currentOption;

  final void Function(SelectionModel?) selectOption;

  const Selections(
      {Key? key,
      required this.state,
      required this.currentOption,
      required this.selectOption})
      : super(key: key);

  @override
  State<Selections> createState() => _SelectionsState();
}

class _SelectionsState extends State<Selections> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 0, maxHeight: 185),
      child: ListView(
        shrinkWrap: true,
        children:
            widget.state is SelectionLoaded || widget.state is SelectionInit
                ? widget.state.selections.map((el) => _option(el)).toList()
                : widget.state is SelectionLoading
                    ? [const Center(child: CircularProgressIndicator())]
                    : [Center(child: Text(widget.state.error ?? ''))],
      ),
    );
  }

  GestureDetector _option(SelectionModel? el) => GestureDetector(
        onTap: () {
          widget.selectOption(el);
        },
        child: Container(
          color: widget.currentOption == el?.name
              ? Theme.of(context).focusColor
              : Theme.of(context).hoverColor,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                el?.name ?? '',
                textAlign: TextAlign.center,
              ),
              Text(
                '${el?.region != null && el!.region.isNotEmpty ? '${el.region}, ' : ''}${el?.country ?? ''}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
}
