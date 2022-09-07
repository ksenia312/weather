import 'dart:convert';

/// [selectionModelFromJson] - вызов фабричного конструктора с декодированным json
List<SelectionModel> selectionModelFromJson(String str) =>
    (json.decode(str) as List).map((e) => SelectionModel.fromJson(e)).toList();

/// Модель данных [SelectionModel] - содержит вид данных опции
class SelectionModel {
  final String name;
  final String region;
  final String country;

  SelectionModel({
    required this.name,
    required this.region,
    required this.country,
  });

  factory SelectionModel.fromJson(Map<String, dynamic> json) => SelectionModel(
        name: json["name"] ?? "",
        region: json["region"] ?? "",
        country: json["country"] ?? "",
      );
}
