import 'package:flutter/foundation.dart';

class LineItem {
  LineItem({
    this.productId,
    this.quantity,
    this.variationId,
    this.total
  });

  int productId;
  int quantity;
  int variationId;
  String total;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    productId: json["product_id"],
    quantity: json["quantity"],
    variationId: json["variation_id"] == null ? null : json["variation_id"],
    total: json["total"],

  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
    "variation_id": variationId == null ? null : variationId,
  };
}

class ShippingLine {
  ShippingLine({
    this.methodId,
    this.methodTitle,
    this.total,
  });

  String methodId;
  String methodTitle;
  String total;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
    methodId: json["method_id"],
    methodTitle: json["method_title"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "method_id": methodId,
    "method_title": methodTitle,
    "total": total,
  };
}
