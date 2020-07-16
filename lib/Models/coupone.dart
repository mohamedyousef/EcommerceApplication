class Coupon {
  Coupon({
    this.id,
    this.code,
    this.amount,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountType,
    this.description,
    this.dateExpires,
    this.dateExpiresGmt,
    this.usageCount,
    this.individualUse,
    this.productIds,
    this.excludedProductIds,
    this.usageLimit,
    this.usageLimitPerUser,
    this.limitUsageToXItems,
    this.freeShipping,
    this.productCategories,
    this.excludedProductCategories,
    this.excludeSaleItems,
    this.minimumAmount,
    this.maximumAmount,
    this.emailRestrictions,
    this.usedBy,
  });

  int id;
  String code;
  String amount;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  DateTime dateModified;
  DateTime dateModifiedGmt;
  String discountType;
  String description;
  dynamic dateExpires;
  dynamic dateExpiresGmt;
  int usageCount;
  bool individualUse;
  List<dynamic> productIds;
  List<dynamic> excludedProductIds;
  dynamic usageLimit;
  dynamic usageLimitPerUser;
  dynamic limitUsageToXItems;
  bool freeShipping;
  List<dynamic> productCategories;
  List<dynamic> excludedProductCategories;
  bool excludeSaleItems;
  String minimumAmount;
  String maximumAmount;
  List<dynamic> emailRestrictions;
  List<dynamic> usedBy;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    id: json["id"],
    code: json["code"],
    amount: json["amount"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    dateModified: DateTime.parse(json["date_modified"]),
    dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
    discountType: json["discount_type"],
    description: json["description"],
    dateExpires: json["date_expires"],
    dateExpiresGmt: json["date_expires_gmt"],
    usageCount: json["usage_count"],
    individualUse: json["individual_use"],
    productIds: List<dynamic>.from(json["product_ids"].map((x) => x)),
    excludedProductIds: List<dynamic>.from(json["excluded_product_ids"].map((x) => x)),
    usageLimit: json["usage_limit"],
    usageLimitPerUser: json["usage_limit_per_user"],
    limitUsageToXItems: json["limit_usage_to_x_items"],
    freeShipping: json["free_shipping"],
    productCategories: List<dynamic>.from(json["product_categories"].map((x) => x)),
    excludedProductCategories: List<dynamic>.from(json["excluded_product_categories"].map((x) => x)),
    excludeSaleItems: json["exclude_sale_items"],
    minimumAmount: json["minimum_amount"],
    maximumAmount: json["maximum_amount"],
    emailRestrictions: List<dynamic>.from(json["email_restrictions"].map((x) => x)),
    usedBy: List<dynamic>.from(json["used_by"].map((x) => x)),
  );

  toJson(){
    return {
    'code': code,
    'discount' : amount,
    'meta_data' : [
    {
      'key' : 'coupon_data'
    ,
    'value' : {
      'id': id,
      'code': code,
      'amount':  amount,
      /* ... and so on ... */
    }
  }
    ]

  };
  }
}


class CouponeDiscountType{
  static final String fixed_cart = "fixed_cart";
  static final String fixed_product = "fixed_product";
  static final String percent = "percent";
}


