import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather/weather_bloc.dart';
import 'package:weather/data/repositories/weather_repository.dart';
import 'package:weather/widgets/bug_report.dart';
import 'package:weather/widgets/location_box.dart';

import '../history_screen/history_screen.dart';
import 'widgets/additional_info_box.dart';
import 'widgets/temperature_box.dart';

/// Экран [WeatherScreen] содержит основную информацию
/// о прогнозе погоды на данный момент в выбранном городе
class WeatherScreen extends StatefulWidget {
  final String city;

  const WeatherScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(
        RepositoryProvider.of<WeatherRepository>(context),
      )..add(LoadWeatherEvent(name: widget.city)),
      // создание провайдера WeatherBloc с данными из WeatherRepository
      // сразу же добавление события подгрузки данных о погоде

      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, WeatherState state) {
          // BlocBuilder для получения доступа к WeatherState
          return Scaffold(
            appBar: AppBar(
              title: const Text('Weather: Now'),
              actions: [
                IconButton(
                    onPressed: state is WeatherLoaded
                        ? () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HistoryScreen(weather: state)),
                              // перенаправление на экран истории за 3 дня
                            );
                          }
                        : null,
                    icon: const Icon(Icons.list))
              ],
            ),
            body: state is WeatherLoaded
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            width: double.infinity,
                            child: TemperatureBox(current: state.current)),
                        SizedBox(
                            width: double.infinity,
                            child: AdditionalInfoBox(current: state.current)),
                        Hero(
                          tag: 'location',
                          child: SizedBox(
                              width: double.infinity,
                              child: LocationBox(current: state.current)),
                        ), // виджет для анимации между экранами
                      ],
                    ),
                  )
                : state is WeatherLoading
                    ? const Center(child: CircularProgressIndicator())
                    // виджет загрузки
                    : BugReport(error: state.error ?? 'Something went wrong'),
          ); // виджет с ошибкой
          // отрисовка контента в зависимости от состояния WeatherState
        },
      ),
    );
  }
}
