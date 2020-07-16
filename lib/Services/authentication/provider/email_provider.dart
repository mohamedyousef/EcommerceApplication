import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/authentication/provider/provider.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailProvider extends IProvider{

  User _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email,password;

  AuthApi api = locator<AuthApi>();


  EmailProvider(this.email, this.password);

  @override
  User getUser() {
    return _user;
  }

  @override
  Future<String> handle_signIN()async{
    String errorMessage;

    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (authResult.user != null)
        _user = await api.getUser(authResult.user.uid,email: email,firstname: "",last_Name: "",photoUrl: "");
      return "true";
    }
    catch(error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }

    return errorMessage;
  }

  @override
  Future<void> handle_signOut() {
    _auth.signOut();
  }

}