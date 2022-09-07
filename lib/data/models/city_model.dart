import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

class CityModel {
  final String name;
  final String region;
  final String country;
  final double tempC;
  final double tempF;
  final String text;
  final String icon;
  final double windKph;
  final int humidity;
  final double feelsLikeC;
  final double feelsLikeF;

  CityModel( {
    required this.name,
    required this.region,
    required this.country,
    required this.tempC,
    required this.tempF,
    required this.text,
    required this.icon,
    required this.windKph,
    required this.humidity,
    required this.feelsLikeC,
    required this.feelsLikeF,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        name: json["location"]["name"] ?? "",
        region: json["location"]["region"] ?? "",
        country: json["location"]["country"] ?? "",
        tempC: json["current"]["temp_c"] ?? "",
    tempF: json["current"]["temp_f"] ?? "",
        text: json["current"]["condition"]["text"] ?? "",
        icon: json["current"]["condition"]["icon"] ?? "",
        windKph: json["current"]["wind_mph"] ?? "",
        humidity: json["current"]["humidity"] ?? "",
        feelsLikeC: json["current"]["feelslike_c"] ?? "",
        feelsLikeF: json["current"]["feelslike_f"] ?? "",
      );
}
