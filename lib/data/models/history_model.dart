import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

class HistoryModel {
  final String date;
  final double maxTempC;
  final double maxTempF;
  final double minTempC;
  final double minTempF;
  final double avgTempC;
  final double avgTempF;

  HistoryModel({
    required this.date,
    required this.maxTempC,
    required this.maxTempF,
    required this.minTempC,
    required this.minTempF,
    required this.avgTempC,
    required this.avgTempF,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        date: json["forecast"]["forecastday"].first["date"] ?? "",
        maxTempC:
            json["forecast"]["forecastday"].first["day"]["maxtemp_c"] ?? "",
        maxTempF:
            json["forecast"]["forecastday"].first["day"]["maxtemp_f"] ?? "",
        minTempC:
            json["forecast"]["forecastday"].first["day"]["mintemp_c"] ?? "",
        minTempF:
            json["forecast"]["forecastday"].first["day"]["mintemp_f"] ?? "",
        avgTempC:
            json["forecast"]["forecastday"].first["day"]["avgtemp_c"] ?? "",
        avgTempF:
            json["forecast"]["forecastday"].first["day"]["avgtemp_f"] ?? "",
      );
}
