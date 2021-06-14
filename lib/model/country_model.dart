// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);
import 'dart:convert';
import 'package:hive/hive.dart';
part 'country_model.g.dart';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class CountryModel {
  CountryModel({
    this.code,
    this.currency,
    this.name,
    this.emoji,
    this.states,
  });
  @HiveField(0)
  String? code;

  @HiveField(1)
  String? currency;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? emoji;

  @HiveField(4)
  List<dynamic>? states;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        code: json["code"],
        currency: json["currency"],
        name: json["name"],
        emoji: json["emoji"],
        states: List<dynamic>.from(json["states"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "currency": currency,
        "name": name,
        "emoji": emoji,
        "states": List<dynamic>.from(states!.map((x) => x)),
      };

  CountryModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    code = map['code'];
    emoji = map['emoji'];
    currency = map['currency'];
    states = (map['states'] as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map<String>((l) => l['name'])
        .toList();
  }
}
