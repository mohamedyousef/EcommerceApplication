//class ShippingMethod {
//  ShippingMethod({
//    this.id,
//    this.instanceId,
//    this.title,
//    this.order,
//    this.enabled,
//    this.methodId,
//    this.methodTitle,
//    this.methodDescription,
//    this.settings,
//   });
//
//  int id;
//  int instanceId;
//  String title;
//  int order;
//  bool enabled;
//  String methodId;
//  String methodTitle;
//  String methodDescription;
//  ShippingMethodSettings settings;
//
//  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
//    id: json["id"],
//    instanceId: json["instance_id"],
//    title: json["title"],
//    order: json["order"],
//    enabled: json["enabled"],
//    methodId: json["method_id"],
//    methodTitle: json["method_title"],
//    methodDescription: json["method_description"],
//    settings: ShippingMethodSettings.fromJson(json["settings"]),
//  );
//
//
//}
//
//
//class ShippingMethodSettings {
//  ShippingMethodSettings({
//    this.title,
//    this.taxStatus,
//    this.cost,
//    this.type,
//    this.requires,
//    this.minAmount
//  });
//
//  ClassCost42 title;
//  ClassCost42 taxStatus;
//  ClassCost42 cost;
//  ClassCost42 type;
//  ClassCost42 requires, minAmount;
//
//  factory ShippingMethodSettings.fromJson(Map<String, dynamic> json) => ShippingMethodSettings(
//    title: (json['title']!=null)?ClassCost42.fromJson(json["title"]):null,
//    taxStatus:(json['tax_status']!=null)? ClassCost42.fromJson(json["tax_status"]):null,
//    cost: (json["cost"]!=null)?ClassCost42.fromJson(json["cost"]):null,
//    type: (json["type"]!=null)?ClassCost42.fromJson(json["type"]):null,
//    requires:(json["requires"]!=null)?ClassCost42.fromJson(json["requires"]):null,
//    minAmount:(json["min_amount"]!=null)?ClassCost42.fromJson(json["min_amount"]):null,
//  );
//
//
//}
//
//class ClassCost42 {
//  ClassCost42({
//    this.id,
//    this.label,
//    this.description,
//    this.type,
//    this.value,
//    this.classCost42Default,
//    this.tip,
//     this.options,
//  });
//
//  String id;
//  String label;
//  String description;
//  Type type;
//  String value;
//  String classCost42Default;
//  String tip;
//   Options options;
//
//  factory ClassCost42.fromJson(Map<String, dynamic> json) => ClassCost42(
//    id: json["id"],
//    label: json["label"],
//    description: json["description"],
//     value: json["value"] == null ? null : json["value"],
//    classCost42Default:   json["default"],
//    tip: json["tip"],
//     options: json["options"] == null ? null : Options.fromJson(json["options"]),
//  );
//
//  Map<String, dynamic> toJson() => {
//    "id": id,
//    "label": label,
//    "description": description,
//    "value": value == null ? null : value,
//    "default":  classCost42Default,
//    "tip": tip,
//    "options": options == null ? null : options.toJson(),
//  };
//}
//
//class Options {
//  Options({
//    this.taxable,
//    this.none,
//    this.optionsClass,
//    this.order,
//  });
//
//  String taxable;
//  String none;
//  String optionsClass;
//  String order;
//
//  factory Options.fromJson(Map<String, dynamic> json) => Options(
//    taxable: json["taxable"] == null ? null : json["taxable"],
//    none: json["none"] == null ? null : json["none"],
//    optionsClass: json["class"] == null ? null : json["class"],
//    order: json["order"] == null ? null : json["order"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "taxable": taxable == null ? null : taxable,
//    "none": none == null ? null : none,
//    "class": optionsClass == null ? null : optionsClass,
//    "order": order == null ? null : order,
//  };
//}

enum FreeShippingOption{
  coupon,min_amount,either,both
}

extension ParseToString on FreeShippingOption {
  String toShortString() {
    return this.toString().split('.').last;
  }
}


class ShippingZoneMethod {
  ShippingZoneMethod({
    this.id,
    this.instanceId,
    this.title,
    this.order,
    this.enabled,
    this.methodId,
    this.methodTitle,
    this.methodDescription,
    this.settings,
    this.links,
  });

  int id;
  int instanceId;
  String title;
  int order;
  bool enabled;
  String methodId;
  String methodTitle;
  String methodDescription;
  ShippingZoneMethodSettings settings;
  Links links;

  factory ShippingZoneMethod.fromJson(Map<String, dynamic> json) => ShippingZoneMethod(
    id: json["id"],
    instanceId: json["instance_id"],
    title: json["title"],
    order: json["order"],
    enabled: json["enabled"],
    methodId: json["method_id"],
    methodTitle: json["method_title"],
    methodDescription: json["method_description"],
    settings: ShippingZoneMethodSettings.fromJson(json["settings"]),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "instance_id": instanceId,
    "title": title,
    "order": order,
    "enabled": enabled,
    "method_id": methodId,
    "method_title": methodTitle,
    "method_description": methodDescription,
    "settings": settings.toJson(),
    "_links": links.toJson(),
  };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.describes,
  });

  List<Collection> self;
  List<Collection> collection;
  List<Collection> describes;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
    describes: List<Collection>.from(json["describes"].map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "describes": List<dynamic>.from(describes.map((x) => x.toJson())),
  };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class ShippingZoneMethodSettings {
  ShippingZoneMethodSettings({
    this.title,
    this.requires,
    this.minAmount,
    this.ignoreDiscounts,
    this.taxStatus,
    this.cost,
    this.classCosts,
    this.classCost42,
    this.classCost43,
    this.noClassCost,
    this.type,
  });

  Title title;
  Title requires;
  Title minAmount;
  Title ignoreDiscounts;
  Title taxStatus;
  Title cost;
  Title classCosts;
  Title classCost42;
  Title classCost43;
  Title noClassCost;
  Title type;

  factory ShippingZoneMethodSettings.fromJson(Map<String, dynamic> json) => ShippingZoneMethodSettings(
    title: Title.fromJson(json["title"]),
    requires: json["requires"] == null ? null : Title.fromJson(json["requires"]),
    minAmount: json["min_amount"] == null ? null : Title.fromJson(json["min_amount"]),
    ignoreDiscounts: json["ignore_discounts"] == null ? null : Title.fromJson(json["ignore_discounts"]),
    taxStatus: json["tax_status"] == null ? null : Title.fromJson(json["tax_status"]),
    cost: json["cost"] == null ? null : Title.fromJson(json["cost"]),
    classCosts: json["class_costs"] == null ? null : Title.fromJson(json["class_costs"]),
    classCost42: json["class_cost_42"] == null ? null : Title.fromJson(json["class_cost_42"]),
    classCost43: json["class_cost_43"] == null ? null : Title.fromJson(json["class_cost_43"]),
    noClassCost: json["no_class_cost"] == null ? null : Title.fromJson(json["no_class_cost"]),
    type: json["type"] == null ? null : Title.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title.toJson(),
    "requires": requires == null ? null : requires.toJson(),
    "min_amount": minAmount == null ? null : minAmount.toJson(),
    "ignore_discounts": ignoreDiscounts == null ? null : ignoreDiscounts.toJson(),
    "tax_status": taxStatus == null ? null : taxStatus.toJson(),
    "cost": cost == null ? null : cost.toJson(),
    "class_costs": classCosts == null ? null : classCosts.toJson(),
    "class_cost_42": classCost42 == null ? null : classCost42.toJson(),
    "class_cost_43": classCost43 == null ? null : classCost43.toJson(),
    "no_class_cost": noClassCost == null ? null : noClassCost.toJson(),
    "type": type == null ? null : type.toJson(),
  };
}

class Title {
  Title({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.titleDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String id;
  String label;
  String description;
  String type;
  String value;
  String titleDefault;
  String tip;
  Placeholder placeholder;
  Options options;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    id: json["id"],
    label: json["label"],
    description: json["description"],
    type: json["type"],
    value: json["value"],
    titleDefault: json["default"],
    tip: json["tip"],
    placeholder: placeholderValues.map[json["placeholder"]],
    options: json["options"] == null ? null : Options.fromJson(json["options"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "label": label,
    "description": description,
    "type": type,
    "value": value,
    "default": titleDefault,
    "tip": tip,
    "placeholder": placeholderValues.reverse[placeholder],
    "options": options == null ? null : options.toJson(),
  };
}

class Options {
  Options({
    this.empty,
    this.coupon,
    this.minAmount,
    this.either,
    this.both,
    this.taxable,
    this.none,
    this.optionsClass,
    this.order,
  });

  Placeholder empty;
  String coupon;
  String minAmount;
  String either;
  String both;
  String taxable;
  String none;
  String optionsClass;
  String order;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
    empty: json[""] == null ? null : placeholderValues.map[json[""]],
    coupon: json["coupon"] == null ? null : json["coupon"],
    minAmount: json["min_amount"] == null ? null : json["min_amount"],
    either: json["either"] == null ? null : json["either"],
    both: json["both"] == null ? null : json["both"],
    taxable: json["taxable"] == null ? null : json["taxable"],
    none: json["none"] == null ? null : json["none"],
    optionsClass: json["class"] == null ? null : json["class"],
    order: json["order"] == null ? null : json["order"],
  );

  Map<String, dynamic> toJson() => {
    "": empty == null ? null : placeholderValues.reverse[empty],
    "coupon": coupon == null ? null : coupon,
    "min_amount": minAmount == null ? null : minAmount,
    "either": either == null ? null : either,
    "both": both == null ? null : both,
    "taxable": taxable == null ? null : taxable,
    "none": none == null ? null : none,
    "class": optionsClass == null ? null : optionsClass,
    "order": order == null ? null : order,
  };
}

enum Placeholder { N_A, EMPTY }

final placeholderValues = EnumValues({
  "": Placeholder.EMPTY,
  "N/A": Placeholder.N_A
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}





