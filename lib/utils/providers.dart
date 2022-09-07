import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather/data/repositories/history_repository.dart';

import '../data/repositories/weather_repository.dart';
import '../data/repositories/selection_repository.dart';
import 'theme.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => AppTheme()),
  RepositoryProvider(create: (context) => WeatherRepository()),
  RepositoryProvider(create: (context) => SelectionRepository()),
  RepositoryProvider(create: (context) => HistoryRepository()),
];
