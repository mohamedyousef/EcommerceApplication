class Review {
  Review({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.productId,
    this.status,
    this.reviewer,
    this.reviewerEmail,
    this.review,
    this.rating,
    this.verified,
    this.reviewerAvatarUrls,
  });

  int id;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  int productId;
  String status;
  String reviewer;
  String reviewerEmail;
  String review;
  dynamic rating;
  bool verified;
  Map<String, String> reviewerAvatarUrls;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    dateCreated: DateTime.parse(json["date_created"]),
    dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
    productId: json["product_id"],
    status: json["status"],
    reviewer: json["reviewer"],
    reviewerEmail: json["reviewer_email"],
    review: json["review"],
    rating: json["rating"],
    verified: json["verified"],
    reviewerAvatarUrls: Map.from(json["reviewer_avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "reviewer": reviewer,
    "reviewer_email": reviewerEmail,
    "review": review,
    "rating": rating,
  };
}
