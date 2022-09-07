import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/city/city_bloc.dart';
import 'package:weather/data/repositories/city_repository.dart';
import 'package:weather/widgets/bug_report.dart';

import 'widgets/additional_info_box.dart';
import 'widgets/location_box.dart';
import 'widgets/temperature_box.dart';

class CityScreen extends StatefulWidget {
  final String city;

  const CityScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CityBloc(
        RepositoryProvider.of<CityRepository>(context),
      )..add(LoadCityEvent(name: widget.city)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forecast: ${widget.city}'),
        ),
        body: BlocBuilder<CityBloc, CityState>(
          builder: (context, CityState state) {
            return state is CityLoaded
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            width: double.infinity,
                            child: TemperatureBox(city: state.city)),
                        SizedBox(
                            width: double.infinity,
                            child: AdditionalInfoBox(city: state.city)),
                        SizedBox(
                            width: double.infinity,
                            child: LocationBox(city: state.city)),
                      ],
                    ),
                  )
                : state is CityLoading
                    ? const Center(child: CircularProgressIndicator())
                    : BugReport(error: state.err ?? 'Something went wrong');
          },
        ),
      ),
    );
  }
}
