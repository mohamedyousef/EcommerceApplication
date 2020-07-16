import 'package:ecommerceApp/Models/image.dart';
import 'package:ecommerceApp/Models/product.dart';

class Variation {
  Variation({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.description,
    this.permalink,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.onSale,
    this.status,
    this.purchasable,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.stockStatus,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.weight,
    this.dimensions,
    this.shippingClass,
    this.shippingClassId,
    this.image,
    this.attributes,
    this.menuOrder,
  });

  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String description;
  String permalink;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  bool onSale;
  String status;
  bool purchasable;
  bool virtual;
  bool downloadable;
  List<dynamic> downloads;
  int downloadLimit;
  int downloadExpiry;
  String taxStatus;
  String taxClass;
  bool manageStock;
  dynamic stockQuantity;
  String stockStatus;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  String weight;
  Dimensions dimensions;
  String shippingClass;
  int shippingClassId;
  Image image;
  List<DefaultAttribute> attributes;
  int menuOrder;

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    id: json["id"],
    attributes: List.from(json["attributes"]).map((e) =>  DefaultAttribute.fromJson(e)).toList(),
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModified: DateTime.parse(json["date_modified"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    description: json["description"],
    permalink: json["permalink"],
    sku: json["sku"],
    price: json["price"],
    regularPrice: json["regular_price"],
    salePrice: json["sale_price"],
    dateOnSaleFrom: json["date_on_sale_from"],
    dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
    dateOnSaleTo: json["date_on_sale_to"],
    dateOnSaleToGmt: json["date_on_sale_to_gmt"],
    onSale: json["on_sale"],
    status: json["status"],
    purchasable: json["purchasable"],
    virtual: json["virtual"],
    downloadable: json["downloadable"],
    downloads: List<dynamic>.from(json["downloads"].map((x) => x)),
    downloadLimit: json["download_limit"],
    downloadExpiry: json["download_expiry"],
    taxStatus: json["tax_status"],
    taxClass: json["tax_class"],
    manageStock: (json["manage_stock"]=="true")?true:false,
    stockQuantity: json["stock_quantity"],
    stockStatus: json["stock_status"],
    backorders: json["backorders"],
    backordersAllowed: json["backorders_allowed"],
    backordered: json["backordered"],
    weight: json["weight"],
    dimensions: Dimensions.fromJson(json["dimensions"]),
    shippingClass: json["shipping_class"],
    shippingClassId: json["shipping_class_id"],
    image: Image.fromJson(json["image"]),
    menuOrder: json["menu_order"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
//    "date_created": dateCreated.toIso8601String(),
//    "date_created_gmt": dateCreatedGmt.toIso8601String(),
//    "date_modified": dateModified.toIso8601String(),
//    "date_modified_gmt": dateModifiedGmt.toIso8601String(),
    "description": description,
    "permalink": permalink,
    "sku": sku,
    "price": price,
    "regular_price": regularPrice,
    "sale_price": salePrice,
    "date_on_sale_from": dateOnSaleFrom,
    "date_on_sale_from_gmt": dateOnSaleFromGmt,
    "date_on_sale_to": dateOnSaleTo,
    "date_on_sale_to_gmt": dateOnSaleToGmt,
    "on_sale": onSale,
    "status": status,
    "purchasable": purchasable,
    "virtual": virtual,
    "downloadable": downloadable,
    "downloads": List<dynamic>.from(downloads.map((x) => x)),
    "download_limit": downloadLimit,
    "download_expiry": downloadExpiry,
    "tax_status": taxStatus,
    "tax_class": taxClass,
    "manage_stock": manageStock,
    "stock_quantity": stockQuantity,
    "stock_status": stockStatus,
    "backorders": backorders,
    "backorders_allowed": backordersAllowed,
    "backordered": backordered,
    "weight": weight,
    "dimensions": dimensions.toJson(),
    "shipping_class": shippingClass,
    "shipping_class_id": shippingClassId,
    "image": image.toJson(),
    "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
    "menu_order": menuOrder,
  };


  String getPrice(){
    String price ;
    price = (onSale)?salePrice:(regularPrice);
    if(price==null)
      price = this.price;
    return price;
  }
  int getPercentage(){
    double percent = (double.parse(salePrice)/double.parse(regularPrice))*100;
    percent = 100 - percent;
    return percent.toDouble().round();
  }


}


//class VariationAttribute {
//  VariationAttribute({
//    this.id,
//    this.name,
//    this.option,
//  });
//
//  int id;
//  String name;
//  String option;
//
//  factory VariationAttribute.fromJson(Map<String, dynamic> json) => VariationAttribute(
//    id: json["id"],
//    name: json["name"],
//    option:(json['option']!=null)?json['option']:null,
//  );
//
//  Map<String, dynamic> toJson() => {
//    "id": id,
//    "name": name,
//    "option": option,
//  };
//
//
//  @override
//  bool operator ==(Object other) => other is VariationAttribute && other.option == option&&other.id == id;
//
//}





