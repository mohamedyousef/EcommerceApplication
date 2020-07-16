import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyWidget  extends StatelessWidget {
  String photo;
  String title;
  String subTitle;
  Widget bottomChild;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(photo,width: 74,height: 74,),
          SizedBox(height: 16,),
          Text(title,style: GoogleFonts.robotoMono()
              .copyWith(fontSize: 21,color: Colors.black87,fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 12,),
          Text(subTitle,style: AppTheme.titleStyle
              .copyWith(color: Colors.grey.shade700),),
          SizedBox(height: 21,),
          if(bottomChild!=null)
          bottomChild
        ],
      ),
    );
  }

  EmptyWidget({this.photo,@required this.title,  this.subTitle,this.bottomChild});
}
