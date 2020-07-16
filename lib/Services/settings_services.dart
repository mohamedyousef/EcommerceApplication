import 'dart:async';

import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/currency.dart';
import 'package:ecommerceApp/Models/settings.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'NavigationServices.dart';
import 'abstracts/api.dart';

class SettingsServices {
  Api api = locator<Api>();
  StreamController<UserSettings> userSettingsController = BehaviorSubject<UserSettings>();
  final key = locator<NavigationService>().navigatorKey;

  List<Currency>currencies;

  Settings settings;
  UserSettings userSettings;

//  Future<void> getSettings() async {
//    Settings setting = await api.getSettings();
////    print(setting.toJson());
////    print(settings.currency);
//
//    if (setting != null) settings = setting;
//  }

  Future<void> changeTheme(bool darkMode)async{
    userSettings.darkMode = darkMode;
    this.userSettingsController.add(userSettings);
    DataOP().saveUserSettings(userSettings);
  }

  Future<void> changeCurrency(String currency)async{
    userSettings.currency = currency;
    this.userSettingsController.add(userSettings);
    DataOP().saveUserSettings(userSettings);
  }

  Future<void> changeLanguage(String language)async{
    userSettings.language = language;
    this.userSettingsController.add(userSettings);
    DataOP().saveUserSettings(userSettings);
  }

  Future<void>  getUserSettings() async {
    Settings setting = await api.getSettings();
    if (setting != null) settings = setting;

    UserSettings userSetting = await DataOP().getSettings();
    if(userSetting!=null)
    userSettingsController.add(userSetting);
    else {
      userSetting= UserSettings(settings.currency, false, "English");
      userSettingsController.add(userSetting);
    }

    this.userSettings = userSetting;

  }

  Future<void>  loadCurrencies() async {
    if(currencies==null)
      currencies = currencyFromJson(await DefaultAssetBundle.of(key.currentContext)
          .loadString("assets/curr.json"));


  }

}
