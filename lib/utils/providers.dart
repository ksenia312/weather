import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/city_repository.dart';
import '../data/repositories/selection_repository.dart';
import 'theme.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => AppTheme()),
  RepositoryProvider(create: (context) => CityRepository()),
  RepositoryProvider(create: (context) => SelectionRepository()),
];
