import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/authentication/provider/provider.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication implements IProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User _user;

  @override
  User getUser() {
    return _user;
  }

  @override
  Future<String> handle_signIN() async{
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (user != null) {
//      _user = await UserAPI().addUserToData(user.uid,currentUser.displayName,currentUser.photoUrl);
      _user = await locator<AuthApi>().getUser(user.uid,photoUrl: user.photoUrl,firstname: user.displayName,
      last_Name: "");
    }
  }

  @override
  Future<void> handle_signOut() async{
    if (googleSignIn != null) await googleSignIn.signOut();
  }
}

