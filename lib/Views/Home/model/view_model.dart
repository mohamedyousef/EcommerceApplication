import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/geo_services.dart';
 
class HomeViewModel extends BaseViewModel {
  AuthenticationService auth = locator<AuthenticationService>();
  Api api = locator<Api>();
  GeoServices geoServices = locator<GeoServices>();

  int _index = 0;
  bool _isLogggedIn = false;

  bool get isLogggedIn => _isLogggedIn;

  set isLogggedIn(bool value) {
    _isLogggedIn = value;
    notifyListeners();
  }

  int get index => _index;

  Stream ListentToUser() {
    return auth.user.stream;
  }

  set index(int value) {
    _index = value;
    notifyListeners();
  }

  void settings() {
    auth.checkIFLoggedIN();
   // categoryServices.getSettings();
    geoServices.getCountires();
  }
}
