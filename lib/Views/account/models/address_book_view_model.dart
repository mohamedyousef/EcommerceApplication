import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class AddressBookViewModel extends BaseViewModel{

  NavigationService navigationService = locator<NavigationService>();
  bool _showFirst = true;
  bool get showFirst => _showFirst;
  int _pageIndex= 0;


  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }

  set showFirst(bool value) {
    _showFirst = value;
    notifyListeners();
  }
}