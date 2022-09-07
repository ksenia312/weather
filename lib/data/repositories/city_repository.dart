import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/city_model.dart';

class CityRepository {
  Future<CityModel> loadCityByName(String name) async {
    final response = await http
        .get(Uri.parse('${baseUrl}current.json?key=$apiKey&q=$name&aqi=no'))
        .timeout(const Duration(seconds: 10), onTimeout: () {
      throw TimeoutException('Waiting time is up');
    });
    if (response.statusCode == 200) {
      return cityModelFromJson(response.body);
    } else {
      throw Exception(json.decode(response.body)['error']['message']);
    }
  }
}
