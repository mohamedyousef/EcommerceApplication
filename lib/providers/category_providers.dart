import 'package:ecommerceApp/Models/category.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier{

  List<Category>_categories;
  List<Category> get categories => _categories;

  set categories(List<Category> value) {
    _categories = value;
    notifyListeners();
  }


}