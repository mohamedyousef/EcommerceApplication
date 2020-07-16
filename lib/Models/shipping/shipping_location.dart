class ShippingLocation {
  ShippingLocation({
    this.code,
    this.type,
  });

  String code;
  String type;

  factory ShippingLocation.fromJson(Map<String, dynamic> json) =>
      ShippingLocation(
        code: json["code"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "type": type,
      };
}
