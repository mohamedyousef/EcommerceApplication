import 'dart:convert';
import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/authentication/provider/provider.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;


class FacebookAuthentication extends IProvider{


  User _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin _facebookLogin = new FacebookLogin();
  AuthApi api = locator<AuthApi>();


  @override
  User getUser(){
    return _user;
  }

  @override
  Future<String> handle_signIN()async{
    FacebookLoginResult onValue =
    await _facebookLogin.logIn(['email', 'public_profile']);
    if (onValue != null)
      switch (onValue.status) {
        case FacebookLoginStatus.loggedIn:
          print(onValue.accessToken.token);

          final AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: onValue.accessToken.token);

          final AuthResult authResult = await _auth
              .signInWithCredential(credential)
              .catchError((err) => "error");

          final FirebaseUser user = await authResult.user;

          assert(!user.isAnonymous);
          assert(await user.getIdToken() != null);
          if (user != null) {
           // String photoUrl = "https://graph.facebook.com/" + user.uid+ "/picture?height=500";


         //   photoUrl = photoUrl + "?height=500";
          //  UserUpdateInfo userUpdateInfo=UserUpdateInfo();
          //  userUpdateInfo.photoUrl=photoUrl;
           // user.updateProfile(userUpdateInfo);
            var graphResponse = await http.get(
                'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${
                    onValue.accessToken.token}');
            var profile = json.decode(graphResponse.body);
           print(profile['name']);
            print(profile.toString());
           // _user = await UserAPI().getUser(uid:user.uid,photoUrl: photoUrl);

            _user = await api.getUser(user.uid,
                photoUrl: "https://graph.facebook.com/v3.1/${profile['id']}/picture?height=500",
                firstname: profile['first_name'],
                last_Name: profile['last_name']);
          }

          break;

        case FacebookLoginStatus.cancelledByUser:
          break;
        case FacebookLoginStatus.error:
          print(onValue.errorMessage);
          break;
      }
  }

  @override
  Future<void> handle_signOut() {
    _facebookLogin.logOut();
  }



}