import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/selection/selection_bloc.dart';
import 'package:weather/data/models/selection_model.dart';
import 'package:weather/data/repositories/selection_repository.dart';
import 'package:weather/utils/delayer.dart';
import 'package:weather/utils/bordered_container.dart';
import 'package:weather/utils/navigator.dart';

import 'selections.dart';

/// Виджет [CityPicker] для ввода города
/// Подгружает предполагаемые города по началу ввода (минимум 3 символа)
/// Использует https://www.weatherapi.com/
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
    // слушатель состояния фокуса текстового поля,
    // нужен для открытия/закрытия кастомных подсказок
    super.initState();
  }

  void _selectOption(SelectionModel? el) {
    // функция выбора опции
    setState(() {
      _currentOption = el?.name;
    });
    // установка опции в state
    _textEditingController.text = el?.name ?? '';
    // заполнение текстового поля выбранной опцией
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: _textEditingController.text.length),
    );
    // перемещение ползунка в конец строки
  }

  void _setNoOption() {
    // установка состояния "опция не выбрана"
    setState(() {
      _currentOption = null;
    });
  }

  void _onFieldChanged(String value, SelectionBloc bloc) {
    if (value.length > 2) {
      _delayer.run(() {
        bloc.add(LoadSelectionsEvent(value: value));
      });
      // добавление в SelectionBloc события "подгрузить подсказки"
      // delayer нужен для поиска только в момент, когда пользователь перестал печатать,
      // иначе поиск производился бы на каждый символ
    } else {
      _delayer.cancel();
      bloc.add(SetInitEvent());
    }
    // добавление в SelectionBloc события "ничего не загружено"
    // нам не нужны подсказки, если пользователь ввел меньше 3 символов
    // закрытие delayer нужно для того, чтобы предыдущие подсказки не подгрузились
    _setNoOption();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SelectionBloc(
              RepositoryProvider.of<SelectionRepository>(context),
            ),
        // использование BlocProvider для создания доступа к SelectionBloc
        // с данными из RepositoryProvider
        child: picker);
  }

  BorderedContainer get picker {
    return BorderedContainer(child: BlocBuilder<SelectionBloc, SelectionState>(
      builder: (context, SelectionState state) {
        // BlocBuilder для доступа к state, где хранятся данные
        SelectionBloc bloc = BlocProvider.of<SelectionBloc>(context);
        // получение bloc из провайдера SelectionBloc - для возможности добавлять события
        return Column(mainAxisSize: MainAxisSize.min, children: [
          _label,
          _textField(bloc),
          _submit,
          if (_showOptions)
            // открытие подсказок
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
      // для управление фокусом текстового поля
      controller: _textEditingController,
      // для управления введенным текстом
      onChanged: (String value) {
        _onFieldChanged(value, bloc);
      },
      decoration: _inputDecoration(bloc));

  InputDecoration _inputDecoration(bloc) {
    var bodySmall = Theme.of(context).textTheme.bodySmall;
    return InputDecoration(
        labelStyle: bodySmall,
        hintText: 'Moscow',
        iconColor: bodySmall?.color,
        suffixIcon: _clear(bloc),
        icon: Icon(
          Icons.location_city,
          color: bodySmall?.color,
        ),
        labelText: 'Enter a city name');
  }

  IconButton _clear(SelectionBloc bloc) => IconButton(
        color: Theme.of(context).textTheme.bodySmall?.color,
        icon: const Icon(
          Icons.clear,
          size: 18.0,
        ),
        onPressed: _textEditingController.text.isNotEmpty
            ? () {
                _textEditingController.clear();
                // очиска ввода
                _setNoOption();
                // очистка выбранной опции
                _focusNode.requestFocus();
                // фокусируем текстовое поле, чтобы можно было сразу набирать текст
                bloc.add(SetInitEvent());
                // очиска всех имеющихся в State опций
              }
            : null,
        // кнопка заблокирована когда onPressed: null
      );

  ElevatedButton get _submit => ElevatedButton(
      onPressed: _currentOption != null
          ? () {
              AppNavigator.of(context).pushToCity(city: _currentOption!);
              // перенаправление на новый экран кастомным навигатором
            }
          : null,
      child: const Text('Go to forecast'));
}
