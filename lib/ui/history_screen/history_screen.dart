import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/history/history_bloc.dart';
import 'package:weather/bloc/weather/weather_bloc.dart';
import 'package:weather/data/repositories/history_repository.dart';
import 'package:weather/utils/formatted_text.dart';
import 'package:weather/widgets/bug_report.dart';
import 'package:weather/widgets/location_box.dart';
import 'package:weather/widgets/unit_dropdown.dart';

import 'widgets/history_items.dart';

class HistoryScreen extends StatefulWidget {
  final WeatherState weather;

  const HistoryScreen({Key? key, required this.weather}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _sortByTemp = true;
  bool _showCelsius = true;

  _onChanged(bool? value) {
    setState(() {
      _showCelsius = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(
        RepositoryProvider.of<HistoryRepository>(context),
      )..add(LoadHistoryEvent(city: widget.weather.current?.city ?? '')),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather: Last 3 days',
          ),
        ),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, HistoryState state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: state is HistoryError
                  ? BugReport(error: state.error ?? 'Something went wrong')
                  : Column(
                      children: [
                        Hero(
                          tag: 'location',
                          child: SizedBox(
                              width: double.infinity,
                              child:
                                  LocationBox(current: widget.weather.current)),
                        ),
                        if (state is HistoryLoaded)
                          UnitDropdown(
                              showCelsius: _showCelsius, onChanged: _onChanged),
                        state is HistoryLoaded
                            ? HistoryItems(
                                state: state,
                                sortByTemp: _sortByTemp,
                                showCelsius: _showCelsius,
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                        if (state is HistoryLoaded) _switch
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  get _switch => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 150,
            child: FormattedText(
              title: 'Sort by decreasing average temperature',
              textAlign: TextAlign.center,
            ),
          ),
          Switch(
            value: _sortByTemp,
            onChanged: (bool value) {
              setState(() {
                _sortByTemp = value;
              });
            },
          ),
        ],
      );
}
