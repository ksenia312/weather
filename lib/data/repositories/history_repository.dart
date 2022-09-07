import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:weather/data/models/history_model.dart';

import '../config.dart';

class HistoryRepository {
  Future<HistoryModel> loadWeatherByDate(String date, String city) async {
    final response = await http
        .get(Uri.parse('${baseUrl}history.json?key=$apiKey&q=$city&dt=$date'))
        .timeout(const Duration(seconds: 5), onTimeout: () {
      throw TimeoutException('The waiting time has expired');
    });
    if (response.statusCode == 200) {
      return historyModelFromJson(response.body);
    } else {
      throw Exception("Failed to load city");
    }
  }
}
