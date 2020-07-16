class ShippingZone {
  ShippingZone({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory ShippingZone.fromJson(Map<String, dynamic> json) => ShippingZone(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
