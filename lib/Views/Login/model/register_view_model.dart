import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel{

  AuthenticationService _authenticationService = locator<AuthenticationService>();
  NavigationService navigationService = locator<NavigationService>();

  String _errorRegister;
  String get errorRegister => _errorRegister;
  set errorRegister(String value) {
    _errorRegister = value;
    notifyListeners();
  }


  void registerWithEmail(String email,String password)async{
    setBusy(true);
    String   err = await _authenticationService.register(email, password);
    setBusy(false);

    print(err);

    if(err.contains("true")) {
      Navigator.pushReplacementNamed(navigationService.navigatorKey.currentContext,HomeRoute);
    }else
      errorRegister = err;
    // goto widgets password confirm

  }
  Future loginByFacebook()async {
    setBusy(true);

    String msg =  await _authenticationService.loginByFacebook();
    setBusy(false);

    if(msg.contains("true"))
      navigationService.goBack();
    else
      _errorRegister = msg;

    notifyListeners();

  }
  Future loginByGoogle()async{
    setBusy(true);

    String msg =  await _authenticationService.loginByGoogle();
    setBusy(false);

    if(msg.contains("true"))
      navigationService.goBack();
    else
      _errorRegister = msg;
    notifyListeners();

  }

}