import 'dart:async';
import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/locator.dart';

import 'abstracts/api.dart';

class CategoryServices {
  Api api = locator<Api>();
  List<Category> categoires = List<Category>();

  Future<List<Category>> getCategoires() async {
    List<Category> data;

    if (categoires != null) {
      data = await api.getCategories();
      if (data.isNotEmpty) {
        if (categoires.isEmpty) categoires.addAll(data);
      }
    } else
      data = categoires;

    data.removeWhere((element) => element.parent != 0);

    return data;
  }
}
