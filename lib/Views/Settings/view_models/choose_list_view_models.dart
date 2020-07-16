import 'package:ecommerceApp/Models/currency.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class ChooseListViewModel extends BaseViewModel{

  SettingsServices settingsServices = locator<SettingsServices>();
  NavigationService navigationService = locator<NavigationService>();
  List<Currency>currencies;

  int _pageIndex;
  int get pageIndex => _pageIndex;
  int length=0;
  String _currency;


  String get currency => _currency;

  set currency(String value) {
    _currency = value;
    notifyListeners();
  }

  set pageIndex(int value) {
    _pageIndex = value;
    notifyListeners();
  }


  void loadCurrencies()async{
    await settingsServices.loadCurrencies();
    if(settingsServices.currencies!=null)
    currencies = settingsServices.currencies.toList();
    _currency = settingsServices.currencies.singleWhere((element) => element.currency
        ==settingsServices.userSettings.currency).currency;
    notifyListeners();
  }

 void search(String pattern){
    currencies =  settingsServices.currencies.where((element) => element.currency.toLowerCase().startsWith(pattern.toLowerCase())).toList();
    notifyListeners();
  }

}



