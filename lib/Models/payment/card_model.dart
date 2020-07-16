import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel{
  static const ID = 'id';
  static const USER_ID = 'userId';
  static const MONTH = 'exp_month';
  static const YEAR = 'exp_year';
  static const LAST_FOUR = 'last4';
  static const BRAND = "brand";

  CardModel({this.id, this.userId, this.brand, this.month, this.year, this.last4});

  String id;
  String userId,brand;
  int month;
  int year;
  int last4;



  CardModel.fromSnapshot(DocumentSnapshot snapshot){
    id = snapshot.data[ID];
    userId = snapshot.data[USER_ID];
    month = snapshot.data[MONTH];
    year = snapshot.data[YEAR];
    last4 = snapshot.data[LAST_FOUR];
    brand = snapshot.data[BRAND];
  }

  CardModel.fromMap(Map data, {String customerId}){
    id = data[ID];
    userId = data[USER_ID];
     month = data[MONTH];
    year = data[YEAR];
    last4 = data[LAST_FOUR];
    brand = data[BRAND];

  }

  Map<String, dynamic> toMap(){
    return {
      ID:  id,
      USER_ID:  userId,
      MONTH:  month,
      YEAR: year,
      LAST_FOUR:  last4,
      BRAND: brand
    };
  }

}