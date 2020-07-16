import 'package:ecommerceApp/Models/user.dart';

abstract class Authenticatable{
  Future<void>signIN();
  Future<void>signOut();
  User getUserInfo();
  Future<String> resetPassword(String email);
  Future<String> registerWithEmail(String email, String password);

}