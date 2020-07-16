import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Models/payment/card_model.dart';
import 'package:ecommerceApp/Services/payment/card_service.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/providers/checkout_provider.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChooseCreditCardScreen extends StatelessWidget {

  CheckOutProvider checkOutProvider;


  @override
  Widget build(BuildContext context) {
    checkOutProvider  = Provider.of<CheckOutProvider>(context,listen: false);

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 16),
          child: RawMaterialButton(
            onPressed: (){
              Navigator.pushNamed(context, AddCreditCardRoute);
            },
            fillColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Add Card",style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text("Credit or Debit Card"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.left_chevron),
        ),
      ),
      body: SizedBox.expand(
        child: StreamBuilder<List<CardModel>>(
          stream: CardServices().getCards(),
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    LightColor.lightcoffee
                  ),
                ),);
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if(snapshot.hasData){

                }

                break;
            }
            return Container();
          }
        ),
      )
    );
  }

  void showConfrimDialog(){}



}
