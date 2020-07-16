import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceApp/Models/payment/card_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CardServices {
  static const USER_ID = 'userId';

  String collection = "cards";
  Firestore _firestore = Firestore.instance;
  FirebaseUser firebaseUser;

  void getCurrentUser()async{
   firebaseUser =   await FirebaseAuth.instance.currentUser();
  }

  CardServices(){
    getCurrentUser();
  }


  void createCard(CardModel cardModel) {
    _firestore
        .collection(collection)
        .document(cardModel.id)
        .setData(cardModel.toMap());
  }

  void updateDetails(Map<String, dynamic> values) {
    _firestore.collection(collection).document(values["id"]).updateData(values);
  }

  void deleteCard(Map<String, dynamic> values) {
    _firestore.collection(collection).document(values["id"]).delete();
  }

//  Future<List<CardModel>> getPurchaseHistory({String customerId}) async =>
//      _firestore
//          .collection(collection)
//          .where(USER_ID, isEqualTo: customerId)
//          .getDocuments()
//          .then((result) {
//        List<CardModel> listOfCards = [];
//        result.documents.map((item) {
//          listOfCards.add(CardModel.fromSnapshot(item));
//        });
//        return listOfCards;
//      });

  var streamTransformer = StreamTransformer<
     QuerySnapshot,
      List<CardModel>>.fromHandlers(handleData: (snapshotList, sink) {
        List<CardModel> cards = [];
    for (DocumentSnapshot item in snapshotList.documents) {
      cards.add(CardModel.fromSnapshot(item));
      print(" CARDS ${cards.length}");
     }
    sink.add(cards);
  });

  Stream<List<CardModel>> getCards() async* {
    yield*    _firestore.collection(collection).where(USER_ID, isEqualTo: firebaseUser.uid)
        .snapshots().transform(streamTransformer);

//    List<CardModel> cards = [];
//    //print("=== RESULT SIZE ${result.documents.length}");
//    for (DocumentSnapshot item in data.documents) {
//      cards.add(CardModel.fromSnapshot(item));
//      print(" CARDS ${cards.length}");
//    }
//
//    yield cards;
  }
}
