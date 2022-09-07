import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:weather/data/models/selection_model.dart';

import '../config.dart';

class SelectionRepository {
  Future<List<SelectionModel>> loadSelections(String value) async {
    final response = await http
        .get(Uri.parse('${baseUrl}search.json?key=$apiKey&q=$value'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw TimeoutException('The waiting time has expired');
    });
    if (response.statusCode == 200) {
      return selectionModelFromJson(response.body);
    } else {
      throw Exception("Failed to load city");
    }
  }
}
