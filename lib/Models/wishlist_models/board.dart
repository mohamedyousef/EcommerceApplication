import 'package:ecommerceApp/Models/product.dart';

class Board {
  int id;
  String title;

  List<dynamic> images = [];
  List<dynamic> productsIds = [];

  Board(this.title, {this.images, this.productsIds});

  toJson() {
    return {
      "title": title,
      "images": (images!=null)?images:[],
      "productIds":(productsIds!=null)? List<dynamic>.from(productsIds.map((e) => e.toJson())):[],
    };
  }

  factory Board.fromJson(Map<String, dynamic> json) => Board(
        json['title'],
      images:(json["images"]!=null)? List<dynamic>.from(json["images"].map((x) => x)):[],
      productsIds:
      (json["productIds"]!=null)? List<Product>.from(json["productIds"].map((x) => Product.fromJson(x))):[],

  );
}
