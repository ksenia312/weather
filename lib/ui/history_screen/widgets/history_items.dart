import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/history/history_bloc.dart';
import 'package:weather/data/models/history_model.dart';
import 'package:weather/utils/bordered_container.dart';
import 'package:weather/utils/formatted_text.dart';

/// Виджет [HistoryItems] для отображения блоков погоды за последние 3 дня
class HistoryItems extends StatefulWidget {
  final HistoryState state;
  final bool sortByTemp;
  final bool showCelsius;

  const HistoryItems(
      {Key? key,
      required this.state,
      required this.sortByTemp,
      required this.showCelsius})
      : super(key: key);

  @override
  State<HistoryItems> createState() => _HistoryItemsState();
}

class _HistoryItemsState extends State<HistoryItems> {
  List<HistoryModel?> createCopy(HistoryState state) =>
      List.from(state.history);

  @override
  Widget build(BuildContext context) {
    return _drawItems(widget.state);
  }

  Column _drawItems(HistoryState state) {
    var sortedHistory = createCopy(state);
    // создание локальной копии списка элементов истории для сортировки или
    // возвращения исходного состояния
    if (widget.sortByTemp) {
      widget.showCelsius
          ? sortedHistory.sort((a, b) => a!.avgTempC.compareTo(b!.avgTempC))
          : sortedHistory.sort((a, b) => a!.avgTempF.compareTo(b!.avgTempF));
      // реализация сортировки по возрастанию средней температуры
    } else {
      sortedHistory = createCopy(state);
      // возвращения исходного состояния если сортировка не включена
    }
    return Column(
        children: sortedHistory.map((e) {
      DateTime date = DateTime.parse(e?.date ?? ' ');
      String formattedDate = DateFormat('dd.MM').format(date);
      // форматирование даты
      String relatedDate = getRelatedDateName(date);
      // создание относительной даты (сегодня/вчера)

      return BorderedContainer(
          isSecondary: true,
          child: Column(
            children: [
              FormattedText(
                title: relatedDate,
                description: ' ($formattedDate)',
                isLarge: true,
              ),
              Divider(
                  thickness: 1.5,
                  color: Theme.of(context).textTheme.bodySmall!.color),
              _drawTemperatures(e),
              if (sortedHistory.indexOf(e) == 0 && widget.sortByTemp)
                _drawColdest(e)
            ],
          ));
    }).toList());
  }

  _drawColdest(HistoryModel? e) => Container(
        // блок с информированием о том, что в этот день температура самая низкая
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).highlightColor, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Text(
          widget.showCelsius
              ? 'THE COLDEST DAY: ${e?.avgTempC} °C'
              : 'THE COLDEST DAY: ${e?.avgTempF} F',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Theme.of(context).highlightColor),
        ),
      );

  _drawTemperatures(HistoryModel? e) => Row(
        // отрисовка температур в формате колонок
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              FormattedText(title: 'max'),
              FormattedText(
                title: 'average',
                isLarge: true,
              ),
              FormattedText(title: 'min'),
            ],
          ),
          SizedBox(
              height: 50,
              child: VerticalDivider(
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                  color: Theme.of(context).textTheme.bodySmall!.color)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormattedText(
                  description: widget.showCelsius
                      ? '${e?.maxTempC} °C'
                      : '${e?.maxTempF} F'),
              FormattedText(
                description: widget.showCelsius
                    ? '${e?.avgTempC} °C'
                    : '${e?.avgTempF} F',
                isLarge: true,
              ),
              FormattedText(
                  description: widget.showCelsius
                      ? '${e?.minTempC} °C'
                      : '${e?.minTempF} F'),
            ],
          )
        ],
      );

  String getRelatedDateName(DateTime date) {
    // функция получения относительной даты
    var dateNow = DateTime.now();
    var difference = dateNow.difference(date).inDays;
    switch (difference) {
      case 0:
        return 'Today';
      case 1:
        return 'Yesterday';
      case 2:
        return '2 days ago';
      default:
        return '';
    }
  }
}
