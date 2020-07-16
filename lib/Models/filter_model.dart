class Filter {

  String category;
  double startPrice,endPrice;
  String parentAttribute;
  List<String>attributes;
  bool onSale,featured;
  double averageRating;

  Filter(
      {this.category,
      this.startPrice,
      this.endPrice,
      this.parentAttribute,
      this.attributes,this.averageRating,this.onSale,this.featured});
}