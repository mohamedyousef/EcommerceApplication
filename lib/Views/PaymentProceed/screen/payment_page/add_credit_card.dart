import 'package:ecommerceApp/Services/payment/payment-service.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';

class AddCreditCard extends StatefulWidget {
  AddCreditCard({Key key}) : super(key: key);

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<AddCreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Card"),
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,

                cardBgColor: Colors.black,
                showBackView:
                    isCvvFocused, //true when you want to show cvv(back) view
              ),
              CreditCardForm(
                themeColor: Colors.red,
                onCreditCardModelChange: (CreditCardModel data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    isCvvFocused = data.isCvvFocused;
                  });
                },
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 12),
          child: RawMaterialButton(
            onPressed: () async {
              int cvc = int.tryParse(cvvCode);
              int carNo =
              int.tryParse(cardNumber.replaceAll(RegExp(r"\s+\b|\b\s"), ""));
              int exp_year = int.tryParse(expiryDate.substring(3, 5));
              int exp_month = int.tryParse(expiryDate.substring(0, 2));

              print("cvc num: ${cvc.toString()}");
              print("card num: ${carNo.toString()}");
              print("exp year: ${exp_year.toString()}");
              print("exp month: ${exp_month.toString()}");
              print(cardNumber.replaceAll(RegExp(r"\s+\b|\b\s"), ""));
//
//          if(provider.userData.stripeId == null&&provider.userData.stripeId.isEmpty){
//           String stripeID = await StripeService.createStripeCustomer(
//               email: provider.userData.email, userId: provider.userData.username);

              final card = CreditCard(
                  expMonth: exp_month,
                  expYear: exp_year,
                  cvc: cvc.toString(),
                  number: carNo.toString());
              StripeService.addCard(card);
              },

            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 16),),
            ),
            fillColor: LightColor.black,
          ),
        ) ,
      ),

     );
  }
}
