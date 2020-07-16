import 'dart:convert';

List<Country> countryFromJson(String str) => List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

String countryToJson(List<Country> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Country {
  Country({
    this.name,
    this.states,
    this.code
  });

  String name,code;
  List<String> states;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json["name"],
    states: List<String>.from(json["states"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "states": List<dynamic>.from(states.map((x) => x)),
  };

}
