import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Services/authentication/FirebaseAuthentication.dart';
import 'package:ecommerceApp/Services/authentication/provider/email_provider.dart';
import 'package:ecommerceApp/Services/authentication/provider/facebook_provider.dart';
import 'package:ecommerceApp/Services/authentication/provider/google_authentication.dart';
import '../locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthenticationService {

   FirebaseAuthenticationServices _api = locator<FirebaseAuthenticationServices>();
   StreamController<User> user = BehaviorSubject<User>();
   User userData;



   Future<String> loginWithEmail(String email,String password)async{
     _api.iProvider = EmailProvider(email,password);
     String err = await _api.signIN();
     bool hasUser = _api.getUserInfo() != null;
     if(hasUser) {
       user.add(_api.getUserInfo());
       userData =  _api.getUserInfo();
     }
     return err;
   }
   Future<String> loginByFacebook()async{
     _api.iProvider = FacebookAuthentication();
     String err = await _api.signIN();
     bool hasUser = _api.getUserInfo() != null;
     if(hasUser) {
       user.add(_api.getUserInfo());
       userData =  _api.getUserInfo();
     }
     return err;
   }
   Future<String> loginByGoogle()async{
     _api.iProvider = GoogleAuthentication();
     String err = await _api.signIN();
     bool hasUser = _api.getUserInfo() != null;
     if(hasUser) {
       user.add(_api.getUserInfo());
       userData =  _api.getUserInfo();
     }
     return err;
   }
   Future<String> register(String email,String password)async{
       return _api.registerWithEmail(email, password);
   }
   Future<void> logout() async{
     user.add(null);
     userData = null;
    return await _api.signOut();
  }
   Future<String> resetPassword(String email)async{
     return  await _api.resetPassword(email);
   }
   Future<void> checkIFLoggedIN()async{
     FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
     if(firebaseUser!=null) {
      User userfromFirestore =  await getUserFromFirebase(firebaseUser.uid);
      if(userfromFirestore!=null) {
        user.add(userfromFirestore);
        userData = userfromFirestore;
      }
      else
        logout();
     }
   }
   Future<User> getUserFromFirebase(String uid)async{
     DocumentSnapshot documentSnapshot = await Firestore.instance.collection("Users").document(uid).get();
     if(documentSnapshot.exists)
     return User.fromJson(documentSnapshot.data,uid: documentSnapshot.documentID);
     return null;
   }

   void updateUserShippingMethod(Ing ing){
     if(userData!=null) {
       userData.shipping = ing;
       user.add(userData);
     }
   }

   void updateDetails(Map<String,dynamic>values){
     Firestore.instance.collection("Users").document(values["id"]).updateData(values);
   }

}


