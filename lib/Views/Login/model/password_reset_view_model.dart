import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:stacked/stacked.dart';

class PasswordResetViewModel extends BaseViewModel {

  AuthenticationService _authenticationService  = locator<AuthenticationService>();

  String _errorMsg;

  String get errorMsg => _errorMsg;

  set errorMsg(String value) {
    _errorMsg = value;
    notifyListeners();
  }

  resetPassword(String email)async{
    setBusy(true);
    errorMsg = await _authenticationService.resetPassword(email);
    setBusy(false);
  }

}