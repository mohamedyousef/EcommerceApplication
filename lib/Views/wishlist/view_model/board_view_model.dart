import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/wishlist_models/board.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class BoardViewModel extends BaseViewModel {
  bool _select = false;

  set select(bool value) {
    _select = value;
    notifyListeners();
  }

  Api api = locator<Api>();
  Board _board;


  Board get board => _board;

  set board(Board value) {
    _board = value;
    notifyListeners();
  }

  bool get select => _select;

  void add(Product product) {
    _board.productsIds.add(product);
    _board.images.add(product.images[0].src);
  }

  void remove(Product product) {
    _board.productsIds.remove(product);
    _board.images.remove(product.images[0].src);
  }

  void Delete(){
    DataOP().removeFromBoard(_board);
    notifyListeners();
  }

}
