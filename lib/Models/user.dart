import 'dart:convert';
import 'package:ecommerceApp/Models/shipping_biilling.dart';

String customerToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.billing,
    this.shipping,
    this.avatarUrl,
   // this.uid,
    this.customerID,
    this.uid
  });

  String email;
  String firstName="";
  String lastName="";
  String username;
  Ing billing;
  Ing shipping;
  String avatarUrl;
  String uid;
  int customerID;


  factory User.fromJson(Map<String, dynamic> json,{String uid}) => User(
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    billing: Ing.fromJson(json["billing"]),
    shipping: Ing.fromJson(json["shipping"]),
    avatarUrl: json["avatar_url"],
    customerID: json["customerID"],
    uid: uid
  );
  Map<String, dynamic> toJson() => {
    "email": email,
    "customerID":customerID,
    "first_name": firstName,
    "last_name": lastName,
    "username": email.split("@")[0],
    "billing":(billing!=null)?billing.toJson():{
      "first_name": "${firstName}",
      "last_name": "${lastName}",
      "company": "",
      "address_1": "",
      "address_2": "",
      "city": "",
      "state":"",
      "postcode": "",
      "country": "",
      "email": "${email}",
      "phone": "",
    },
    "shipping":(shipping!=null)?shipping.toJson():{
      "first_name": "${firstName}",
      "last_name": "${lastName}",
      "company": "",
      "address_1": "",
      "address_2": "",
      "city": "",
      "state":"",
      "postcode": "",
      "country": "",
      "email": "${email}",
      "phone": "",
    },
    if(avatarUrl!=null&&avatarUrl!="")
    "avatar_url": avatarUrl
  };

  String getFullName(){
      return email.split("@")[0];
  }
}