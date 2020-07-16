import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Services/authentication/provider/facebook_provider.dart';
import 'package:ecommerceApp/Services/authentication/provider/google_authentication.dart';
import 'package:ecommerceApp/Services/authentication/provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'base/authenticatble.dart';

class FirebaseAuthenticationServices extends Authenticatable {
  IProvider iProvider;

  FirebaseAuthenticationServices();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signIN() async {
    return await iProvider.handle_signIN();
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    if (iProvider == null) {
      await GoogleAuthentication().handle_signOut();
      await FacebookAuthentication().handle_signOut();
    }
  }

  @override
  User getUserInfo() {
    return iProvider.getUser();
  }

  @override
  Future<String> resetPassword(String email) async {
    String msg= "true";
    try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        return msg;
    }catch(e){
     if(e.code=="ERROR_USER_NOT_FOUND")
       {
         msg = "Email Not Found";
       }
    }
    return msg;
  }

  @override
  Future<String> registerWithEmail(String email, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                value.user.sendEmailVerification(),
               });
      errorMessage = "true";
    } catch (e) {
      switch (e.code) {
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Anonymous accounts are not enabled";
          break;
        case "ERROR_WEAK_PASSWORD":
          errorMessage = "Your password is too weak";
          break;
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email is invalid";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "Email is already in use on different account";
          break;
        case "ERROR_INVALID_CREDENTIAL":
          errorMessage = "Your email is invalid";
          break;

        default:
          errorMessage = "An undefined Error happened.";
      }
    }

    return errorMessage ;
  }
}
