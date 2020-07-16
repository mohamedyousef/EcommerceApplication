import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:stacked/stacked.dart';
import '../../../locator.dart';


class LoginModel extends BaseViewModel{

  final AuthenticationService _authenticationService =  locator<AuthenticationService>();
  final NavigationService navigationService  = locator<NavigationService>();

  String _errorLogin;

  String get  errorLogin => _errorLogin;

  set  errorLogin(String value) {
    _errorLogin = value;
    notifyListeners();
  }

  Future loginByEmail(String email,String password)async{
    setBusy(true);

    String msg =  await _authenticationService.loginWithEmail(email,password);
    setBusy(false);

    if(msg.contains("true"))
       navigationService.goBack();
      else
        _errorLogin = msg;

      notifyListeners();
  }
  Future loginByFacebook()async {
    setBusy(true);

    String msg =  await _authenticationService.loginByFacebook();
    setBusy(false);

    if(msg.contains("true"))
      navigationService.goBack();
    else
      _errorLogin = msg;

    notifyListeners();

  }
  Future loginByGoogle()async{
    setBusy(true);

    String msg =  await _authenticationService.loginByGoogle();
    setBusy(false);

    if(msg.contains("true"))
      navigationService.goBack();
    else
      _errorLogin = msg;

    notifyListeners();

  }

  Future loginByPhoneAuth(String phoneNumber) async {}

}