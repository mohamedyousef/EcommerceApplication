import 'package:ecommerceApp/Models/user.dart';

abstract class IProvider{
  Future<String>handle_signIN();
  Future<void>handle_signOut();
  User getUser();
}