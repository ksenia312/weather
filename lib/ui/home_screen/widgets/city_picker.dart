import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/selection/selection_bloc.dart';
import 'package:weather/data/repositories/selection_repository.dart';
import 'package:weather/utils/delayer.dart';
import 'package:weather/utils/bordered_container.dart';
import 'package:weather/utils/navigator.dart';

import 'selections.dart';

class CityPicker extends StatefulWidget {
  const CityPicker({Key? key}) : super(key: key);

  @override
  State<CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final Delayer _delayer = Delayer(milliseconds: 600);
  String? _currentOption;
  bool _showOptions = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        _showOptions = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  void _selectOption(el) {
    setState(() {
      _currentOption = el?.name;
    });
    _textEditingController.text = el?.name ?? '';
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: _textEditingController.text.length),
    );
  }

  void _setNoOption() {
    setState(() {
      _currentOption = null;
    });
  }

  void _onFieldChanged(String value, SelectionBloc bloc) {
    if (value.length > 2) {
      _delayer.run(() {
        bloc.add(LoadSelectionsEvent(value: value));
      });
    } else {
      _delayer.cancel();
      bloc.add(SetInitEvent());
    }
    _setNoOption();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SelectionBloc(
              RepositoryProvider.of<SelectionRepository>(context),
            ),
        child: picker);
  }

  BorderedContainer get picker {
    return BorderedContainer(child: BlocBuilder<SelectionBloc, SelectionState>(
      builder: (context, SelectionState state) {
        SelectionBloc bloc = BlocProvider.of<SelectionBloc>(context);
        return Column(mainAxisSize: MainAxisSize.min, children: [
          _label,
          _textField(bloc),
          _submit,
          if (_showOptions)
            Selections(
              state: state,
              currentOption: _currentOption,
              selectOption: _selectOption,
            )
        ]);
      },
    ));
  }

  Text get _label => Text(
        'City selection',
        style: Theme.of(context).textTheme.bodyLarge,
      );

  TextFormField _textField(SelectionBloc bloc) => TextFormField(
      focusNode: _focusNode,
      controller: _textEditingController,
      onChanged: (String value) {
        _onFieldChanged(value, bloc);
      },
      decoration: _inputDecoration(bloc));

  InputDecoration _inputDecoration(bloc) => InputDecoration(
      labelStyle: Theme.of(context).textTheme.bodySmall,
      hintText: 'Moscow',
      iconColor: Theme.of(context).textTheme.bodySmall?.color,
      suffixIcon: _clear(bloc),
      icon: Icon(
        Icons.location_city,
        color: Theme.of(context).textTheme.bodySmall?.color,
      ),
      labelText: 'Enter a city name');

  IconButton _clear(SelectionBloc bloc) => IconButton(
        color: Theme.of(context).textTheme.bodySmall?.color,
        icon: Icon(
          Icons.clear,
          size: 18.0,
        ),
        onPressed: _textEditingController.text.isNotEmpty
            ? () {
                _textEditingController.clear();
                _setNoOption();
                _focusNode.requestFocus();
                bloc.add(SetInitEvent());
              }
            : null,
      );

  ElevatedButton get _submit => ElevatedButton(
      onPressed: _currentOption != null
          ? () {
              AppNavigator.of(context).pushToCity(city: _currentOption!);
            }
          : null,
      child: const Text('Go to forecast'));
}
