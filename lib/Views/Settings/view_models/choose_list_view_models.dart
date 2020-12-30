import 'package:ecommerceApp/Models/currency.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class ChooseListViewModel extends BaseViewModel{

  SettingsServices settingsServices = locator<SettingsServices>();
  NavigationService navigationService = locator<NavigationService>();
  List<Currency>currencies;
  Map<String,Locale>langauges;

  int _pageIndex;
  int get pageIndex => _pageIndex;
  int length=0;
  String _selected;



  String get selected => _selected;

  set selected(String value) {
    _selected = value;
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
    _selected = settingsServices.currencies.singleWhere((element) => element.currency
        ==settingsServices.userSettings.currency).currency;
    notifyListeners();
  }

  void loadLanguages(){
    _selected =  settingsServices.langauges.keys.toList().singleWhere((element) => element == settingsServices.userSettings.language);
    langauges = settingsServices.langauges;

    notifyListeners();
  }

  void search(String pattern){
    currencies =  settingsServices.currencies.where((element) => element.currency.toLowerCase().startsWith(pattern.toLowerCase())).toList();
    notifyListeners();
  }



}



