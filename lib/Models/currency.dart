// To parse this JSON data, do
//
//     final currency = currencyFromJson(jsonString);

import 'dart:convert';

List<Currency> currencyFromJson(String str) => List<Currency>.from(json.decode(str).map((x) => Currency.fromJson(x)));

String currencyToJson(List<Currency> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Currency {
  Currency({
    this.currency,
    this.country,
  });

  String currency;
  String country;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    currency: json["currency"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "country": country,
  };
}
