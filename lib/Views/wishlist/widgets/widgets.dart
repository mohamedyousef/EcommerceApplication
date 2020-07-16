import 'package:flutter/material.dart';
class TabbarButtonWishList extends StatelessWidget {

  VoidCallback onPressed;
  bool isActive;
  String title;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: AnimatedContainer(
         duration: Duration(milliseconds: 400),
        color: (isActive)?Colors.black:Colors.transparent,
        child: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,style: TextStyle( color: (isActive)?Colors.white:Colors.black,
          fontWeight: FontWeight.bold
          ),),
        )),
      ),
    );
  }

  TabbarButtonWishList(this.title,this.onPressed, this.isActive);
}

