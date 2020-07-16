import 'package:ecommerceApp/Models/country.dart';
import 'package:flutter/cupertino.dart';

class CountiresProvider extends ChangeNotifier{

  Country _country ;
  String _state;
  String countryCode;
  String phoneNumber;
  String fullName;
  String address;

  String get state => _state;

  set state(String value) {
    _state = value;
    notifyListeners();
  }

  Country get country => _country;


  set country(Country value) {
    _country = value;
    notifyListeners();
  }



}