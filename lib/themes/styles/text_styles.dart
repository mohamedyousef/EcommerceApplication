import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextStyles{

 static TextStyle title_brand = TextStyle(fontSize: 19,fontFamily: "roboto");
 static TextStyle second_title_sans = TextStyle(fontSize: 16,fontFamily: "SansBoldArabic");
 static TextStyle second_title_cairofont = TextStyle(fontSize: 16,fontFamily: "cairo");
 static TextStyle second_title_extralightsans = TextStyle(fontSize: 16,fontFamily: "sansextra");
 static TextStyle second_title_stc = TextStyle(fontSize: 16,fontFamily: "stc");
 static TextStyle second_titleFontLIGHTDNC = TextStyle(fontSize: 16,fontFamily: "din");


 static String FilterDate(DateTime now){
  if(now!=null) {
   String formattedDate = DateFormat('yyyy-MM-dd \t kk:mm').format(now);
   return formattedDate;
  }
   return "";
 }
}
