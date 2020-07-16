import 'package:ecommerceApp/Models/image.dart';

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
    this.display,
    this.image,
    this.menuOrder,
    this.count,
    this.desc,
    this.parent
  });

  int id;
  String name;
  String slug;
  String display;
  Image image;
  int menuOrder;
  int count;
  String desc;
  int parent;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    display: json["display"],
    image: (json["image"]==null)?null:Image.fromJson(json["image"]),
    menuOrder: json["menu_order"],
    count: json["count"],
    desc: json['description'],
    parent: json['parent']
  );

}
