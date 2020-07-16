import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/category_services.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class CategoriesViewModel extends FutureViewModel<List<Category>>{

  CategoryServices api = locator<CategoryServices>();
  NavigationService  navigationService = locator<NavigationService>() ;

  @override
  Future<List<Category>> futureToRun() async => await api.getCategoires();

  List<Category> getAllCategoriesByCatName(int parent){
    return api.categoires.where((element) => element.parent==parent).toList();
  }
}
