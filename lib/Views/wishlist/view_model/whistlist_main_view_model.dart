import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class WishListViewModelMain extends BaseViewModel{

  NavigationService navigationService = locator<NavigationService>();

  bool _isEmpty =false;
  bool get isEmpty => _isEmpty;

  set isEmpty(bool value) {
    _isEmpty = value;
    notifyListeners();
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }
  void checkIFEmptyOrNo()async{
    bool a =await DataOP().hasWishList();
    if(a)
      _isEmpty = a;

    notifyListeners();
  }

}