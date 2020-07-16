import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/variation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingCartProvider extends ChangeNotifier {
  List<ProductCart> _products = List<ProductCart>();
  List<ProductCart> get products => _products;

  void increment(int productID, {int varID}) {
    int index = _products.indexWhere((element) =>
        element.product.id == productID && element.variation.id == varID);
    _products[index].quantity++;
    notifyListeners();
  }

  void decrement(int productID, {int varID = 0}) {
    int index2 = _products.indexWhere((element) =>
        element.product.id == productID  && element.variation.id == varID);

    if(index2>=0&&_products.isNotEmpty)
      _products[index2].quantity--;

    notifyListeners();
  }

  void addProduct(Product product, Variation variation) {
    int lineItem = _products.indexWhere((element) =>
        element.product.id == product.id &&
        element.variation.id == ((variation != null) ? variation.id : 0));

    if (lineItem >=0 &&_products.isNotEmpty) {
      _products[lineItem].quantity++;
    } else
      this._products.add(ProductCart(product, variation, 1));
    notifyListeners();
  }

  void removeProduct(int productID, {int varID}) {
    int index2 = _products.indexWhere((element) =>
        element.product.id == productID && element.variation.id == varID);
    _products.removeAt(index2);
    notifyListeners();
  }

  void clear() {
    _products.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    double price = 0;
    for (var item in _products)
      price += item.getTotalPrice();
    return price;
  }

  getTotalNumbers(){
    int number  = 0;
    for (var item in _products)
      number += item.quantity;


    return number;
  }
//

  toJson() {
    return [for (var item in _products) item.toJson()];
  }
}


class ProductCart {
  Product product;
  Variation variation;
  int quantity = 1;

  double getTotalPrice() {
    double variationPrice = 0;
    double productPrice = 0;
    print(product.salePrice);

    if (variation.id==0)
      productPrice = (product.onSale)
          ? double.parse(product.salePrice.toString())
          : double.parse(product.regularPrice.toString());
    else
      variationPrice = (variation.onSale == false)
          ? double.parse(variation.regularPrice.toString())
          : double.parse(variation.salePrice.toString());

//    print(variationPrice);
//    print(productPrice);

    return (variationPrice + productPrice)*quantity;
  }

  String getImage(){
    print(product.images[0].src);
    return (variation.id!=0)?variation.image.src :product.images[0].src;
  }

  toJson() => {
        "product_id": product.id,
          if(variation.id!=0)
        "variation_id": variation.id,
        "quantity": quantity
      };


  ProductCart(this.product, this.variation, this.quantity) {
    if(variation==null)
       variation = Variation(id: 0);

  }
}
