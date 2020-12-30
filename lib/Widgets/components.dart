import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget phoneNumberTextField(TextEditingController _textEditingControllerPhoneNumber) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      keyboardType: TextInputType.phone,
     // maxLength: 11,
      controller: _textEditingControllerPhoneNumber,
      validator:(value){
        if(value.isEmpty)
          return  "Required";

        return null;
      },
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
        //    NumberTextInputFormatter(),
      ],
      decoration: InputDecoration(
         // icon: Icon(Icons.phone_iphone),
          hintText: "Phone Number",
          hintStyle: TextStyle(fontFamily: "SansBoldArabic")
      ),
    ),
  );
}
Widget textForm(TextEditingController _textEditingController,String hint,{
  Color borderColor = Colors.transparent,
  TextInputType textInputType=TextInputType.text,bool obsecure=false,
Color cursorColor = LightColor.skyBlue
  ,Function function(String value), bool req=true,double padding=4.0,double margin=4.0}){
  return Container(
    margin: EdgeInsets.all(margin),
    padding: EdgeInsets.all(padding),
    child: TextFormField(
      style: TextStyle(
        fontSize: 16
      ),
      cursorColor: cursorColor,
      controller: _textEditingController,
      validator: (value){
        if(req)
        if(value.isEmpty)
          return "required";
        return null;
      },
onChanged: (vale){
        function(vale);
},
      onFieldSubmitted: (vale){
        function(vale);
      },
      obscureText: obsecure,
      keyboardType: textInputType,

      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          labelText: hint,
       //   hintText: hint,
          labelStyle: TextStyle(color: Colors.grey.shade600)

      ),
    ),
  );
}

Widget photoUrl(String photourl,{double elevation = 0,Color color=Colors.white,double height=130.0,double width=200,BoxFit fit=BoxFit.cover}){
  return  Material(
    color: color,
    elevation: elevation,
    child: (photourl!=null&&photourl.isNotEmpty)?CachedNetworkImage(
      placeholder: (context, url) => Container(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Colors.yellowAccent.shade700),
        ),
        width: width,
        height: height,
        padding: EdgeInsets.all(70.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Material(
        child: Image.asset(
          'images/img_not_available.jpeg',
          width: width,
          height: height,
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
        clipBehavior: Clip.hardEdge,
      ),
      imageUrl: photourl,
      width: width,
      height: height,
      fit: fit,
    ):
    Container(color:Colors.transparent,),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    clipBehavior: Clip.hardEdge,
  );
}

Widget photoUrlWithoutBorder(String photourl,{BoxFit boxFit = BoxFit.contain,double height=130.0,double width=200}){
  return (photourl!=null&&photourl.isNotEmpty)?CachedNetworkImage(
    placeholder: (context, url) => Container(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            Colors.yellowAccent.shade700),
      ),
      width: width,
      height: height,
      padding: EdgeInsets.all(70.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    ),
    errorWidget: (context, url, error) => Material(
      child: Image.asset(
        'assets/images/nf2.png',
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),

      clipBehavior: Clip.hardEdge,
    ),
    imageUrl: photourl,
    width: width,
    height: height,
    fit: boxFit,
  ):
  Material(
    child: Image.asset(
      'assets/images/nf.png',
      width: width,
      height: height,
      fit: BoxFit.cover,
    ),

    clipBehavior: Clip.hardEdge,
  );
}

Widget photoAssets(String photourl,{bool shape =false,double height=130.0,double width=200}){
  return  Material(
    shape:(shape)?CircleBorder():RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(6.0)),),
    child: Image.asset(
      photourl,
      width: width,
      height: height,
      fit: BoxFit.cover,
    ),

    clipBehavior: Clip.hardEdge,
  );
}
Widget CirclePhotoUrl(String photourl,{double rad = 50}){
  return CircleAvatar(
    radius: rad,
    backgroundImage: (photourl!=null)?CachedNetworkImageProvider(photourl):AssetImage("assets/images/nf.png"),
  );
}
