import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class ProfileScreenViewModel extends BaseViewModel{
  SettingsServices  settingsServices = locator<SettingsServices>();
  NavigationService   navigationService = locator<NavigationService>();

  String get currency => _currency;

  set currency(String value) {
    _currency = value;
    notifyListeners();
  }

  String _currency ;
  String _language;
  List<String> currencies;
  bool _darkMode;


  bool get darkMode => _darkMode;

  set darkMode(bool value) {
    _darkMode = value;

    notifyListeners();
  }

  void listenToUserSettings(){
     settingsServices.userSettingsController.stream.listen((event) {
       _currency = event.currency;
       _language = event.language;
       _darkMode = event.darkMode;
       notifyListeners();
     });
  }

  String get language => _language;
  set language(String value) {
    _language = value;
    notifyListeners();
  }

}