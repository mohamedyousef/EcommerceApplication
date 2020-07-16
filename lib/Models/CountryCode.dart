import 'dart:convert';

List<IsoCode> isoCodeFromJson(String str) => List<IsoCode>.from(json.decode(str).map((x) => IsoCode.fromJson(x)));

String isoCodeToJson(List<IsoCode> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IsoCode {
  IsoCode({
    this.code,
    this.name,
  });

  String code;
  String name;

  factory IsoCode.fromJson(Map<String, dynamic> json) => IsoCode(
    code: json["Code"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Code": code,
    "Name": name,
  };
}
