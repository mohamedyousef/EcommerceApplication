import 'package:ecommerceApp/Models/country.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter/cupertino.dart';

class GeoServices{

  NavigationService navigationService = locator<NavigationService>();
  List<Country> _countires;

  getCountires()async{
    if(_countires==null)
     _countires =
         countryFromJson(await DefaultAssetBundle.of(navigationService.navigatorKey.currentContext)
             .loadString("assets/geo.json"));
  }




  List<Country> searchCountryByName(String name){
    return _countires.where((element) => element.name.toLowerCase().startsWith(name.toLowerCase())).take(3).toList();
  }

  List<String> getCitiesOfCountry(String countryName,String pattern){
    return _countires.singleWhere((element) => element.name==countryName).states.where((element) =>
        element.toLowerCase()
            .startsWith(pattern.toLowerCase()))
        .take(10).toList();
  }

}




