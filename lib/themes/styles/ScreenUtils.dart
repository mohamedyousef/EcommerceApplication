import 'package:flutter/material.dart';
class ScreenUtils{
  static screenWidth(BuildContext context,{double size=1}) => MediaQuery.of(context).size.width*size;
  static screenHeight(BuildContext context,{double size=1}) => MediaQuery.of(context).size.height*size;
}