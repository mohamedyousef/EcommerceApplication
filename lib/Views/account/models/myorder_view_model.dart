import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class MyOrderViewModel extends FutureViewModel<List<Order>>{

  Api api  = locator<Api>();
  NavigationService navigationService =  locator<NavigationService>();
  int  _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  @override
  Future<List<Order>> futureToRun()=> api.getAllOrders();


}