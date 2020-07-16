import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/country.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';

class ShippingViewModel extends BaseViewModel{

  AuthApi authApi =  locator<AuthApi>();
  AuthenticationService authenticationService   = locator<AuthenticationService>();
  Ing _ing;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _phoneNumber ="";
  String get phoneNumber => _phoneNumber;
  PhoneNumber _phoneNumberGl ;
  PhoneNumber get phoneNumberGl => _phoneNumberGl;

  set phoneNumberGl(PhoneNumber value) {
    _phoneNumberGl = value;
    notifyListeners();
  }

  set phoneNumber(String value) {
    _phoneNumber = value;notifyListeners();
  }

  Ing get ing => _ing;

  set ing(Ing value) {
    _ing = value;
    notifyListeners();
  }

  Country _country ;
  String _state;
  String get state => _state;
  bool _set_as_default = true;

  bool get set_as_default => _set_as_default;

  set set_as_default(bool value) {
    _set_as_default = value;
    notifyListeners();
  }

  set state(String value) {
    _state = value;
    notifyListeners();
  }

  Country get country => _country;
  set country(Country value) {
    _country = value;
    notifyListeners();
  }

  void saveDataToFirebase(Ing ing)async{
   FirebaseUser firebaseuser =  await _firebaseAuth.currentUser();
   ing.email = firebaseuser.email;
   ing.company = "";

    authApi.updateShippingUser(firebaseuser.uid, ing);
    authenticationService.updateUserShippingMethod(ing);
  }

  void load_default(){
    if( authenticationService.userData!=null)
    _ing =  authenticationService.userData.shipping;
    notifyListeners();
  }
}