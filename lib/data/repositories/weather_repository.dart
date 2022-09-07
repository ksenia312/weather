import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel> loadWeatherByName(String name) async {
    final response = await http
        .get(Uri.parse('${baseUrl}current.json?key=$apiKey&q=$name&aqi=no'))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException('Waiting time is up');
    });
    if (response.statusCode == 200) {
      return weatherModelFromJson(response.body);
    } else {
      throw Exception(json.decode(response.body)['error']['message']);
    }
  }
}
