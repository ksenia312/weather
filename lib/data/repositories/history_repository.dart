import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather/data/models/history_model.dart';

import '../config.dart';

/// [HistoryRepository] используется для получения истории за 3 дня из API
class HistoryRepository {
  Future<HistoryModel> loadWeatherByDate(String date, String city) async {
    final response = await http
        .get(Uri.parse('${baseUrl}history.json?key=$apiKey&q=$city&dt=$date'))
        // запрос на получение данных
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw TimeoutException('The waiting time has expired');
    });
    // обработка долгого ожидания
    if (response.statusCode == 200) {
      return historyModelFromJson(response.body);
      // возвражение данных в формате HistoryModel
    } else {
      throw Exception(json.decode(response.body)['error']['message']);
      // обозначение Exception, если появилась ошибка
    }
  }
}
