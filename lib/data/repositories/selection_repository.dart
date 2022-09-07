import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/data/models/selection_model.dart';

import '../config.dart';

/// [SelectionRepository] используется для получения опций поиска из API
class SelectionRepository {
  Future<List<SelectionModel>> loadSelections(String value) async {
    final response =
        await http.get(Uri.parse('${baseUrl}search.json?key=$apiKey&q=$value'))
            // запрос на получение данных
            .timeout(const Duration(seconds: 5), onTimeout: () {
      throw TimeoutException('The waiting time has expired');
    });
    // обработка долгого ожидания
    if (response.statusCode == 200) {
      return selectionModelFromJson(response.body);
      // возвражение данных в формате SelectionModel
    } else {
      throw Exception(json.decode(response.body)['error']['message']);
      // обозначение Exception, если появилась ошибка
    }
  }
}
