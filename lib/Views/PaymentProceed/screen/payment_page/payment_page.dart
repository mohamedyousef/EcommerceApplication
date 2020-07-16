import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/providers/checkout_provider.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentChooseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CheckOutProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: (provider.isBusy)?null:Container(
          height: 180,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Grand Total",
                      style: AppTheme.subTitleStyle,
                    ),
                    Text(
                      "${provider.shoppingCartProvider.getTotalPrice()}"
                      " ${provider.settingsServices.userSettings.currency}",
                      style: AppTheme.h4Style,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "Order total include any applicable VAT",
                  style: AppTheme.subTitleStyle,
                ),
              ),
              SizedBox(
                height:16,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: RawMaterialButton(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(3)),
                  fillColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Place My Order",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {

                    if(provider.currentPaymentMethods==0)
                      provider.proceedPayment();
                      else if (provider.currentPaymentMethods == 1)
                    provider.navigationService.navigateTo(CreditCardChooseRoute);
                    else if (provider.currentPaymentMethods == 2)
                      provider.navigationService.navigateTo(PaypalPaymentRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text("Payment Methods"),
        leading: IconButton(
          onPressed: () {
            provider.navigationService.goBack();
          },
          icon: Icon(CupertinoIcons.left_chevron),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtils.screenHeight(context, size: 0.05),
                  ),
                  InkWell(
                    onTap: () {
                      provider.currentPaymentMethods = 0;
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: (provider.currentPaymentMethods == 0)
                          ? Colors.grey.shade50
                          : Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Radio(
                              value: 0,
                              activeColor: Colors.black,
                              groupValue: provider.currentPaymentMethods,
                              onChanged: (value) {
                                provider.currentPaymentMethods = value;
                              }),
                          SizedBox(
                            width: 12,
                          ),
                          Text("Cash on Delivery")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,), 
                  InkWell(
                    onTap: () {
                      provider.currentPaymentMethods = 1;
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: (provider.currentPaymentMethods == 1)
                          ? Colors.grey.shade50
                          : Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Radio(
                              value: 1,
                              activeColor: Colors.black,
                              groupValue: provider.currentPaymentMethods,
                              onChanged: (value) {
                                provider.currentPaymentMethods = value;
                              }),
                          SizedBox(
                            width: 8,
                          ),
                          Image.asset(
                            "assets/images/debit.png",
                            width: 32,
                            height: 32,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Credit or Debit Cards")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      provider.currentPaymentMethods = 2;
                    },
                    child: Container(
                      color: (provider.currentPaymentMethods == 2)
                          ? Colors.grey.shade50
                          : Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),

                          Radio(
                              value: 2,
                              activeColor: Colors.black,
                              groupValue: provider.currentPaymentMethods,
                              onChanged: (value) {
                                provider.currentPaymentMethods = value;
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/paypal2.png",
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Sub Total",
                                  style: AppTheme.subTitleStyle,
                                ),
                                Text(
                                  "${provider.shoppingCartProvider.getTotalPrice()}"
                                      " ${provider.settingsServices.userSettings.currency}",
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "+ Shipping",
                                  style: AppTheme.subTitleStyle,
                                ),
                                Text(
                                  "10 "
                                      "${provider.settingsServices.userSettings.currency}",
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                  // Text("SELECT PAYMENT METHOD",style: AppTheme.titleStyle.copyWith(color:Colors.grey),),
                  // SizedBox(height: 16,),

//                  Card(
//                    child: ListTile(
//                      onTap: (){
//                        provider.navigationService.navigateTo(CreditCardChooseRoute);
//                      },
//                      trailing:Icon(MdiIcons.chevronRight),
//                      title: Text("Credit or Debit Cards"),
//                     leading: Image.asset("assets/images/debit.png",width: 32,height: 32,),
//                    ),
//                  ),
//                  SizedBox(height: 8,),
//                  Card(
//                    child: ListTile(
//                      onTap: (){
//                        provider.navigationService.navigateTo(PaypalPaymentRoute);
//                      },
//                      title: Text("Paypal"),
//                      trailing:Icon(MdiIcons.chevronRight),
//                      leading: Image.asset("assets/images/paypal.png",height: 32,width: 32,),
//                    ),
//                  ),
//                  SizedBox(height: 8,),
//                  Card(
//                    child: ListTile(
//                      onTap: (){
//                        provider.setBusy = true;
//                        provider.proceedPayment();
//                      },
//                      title: Text("Cash On Delivery"),
//                      trailing:Icon(MdiIcons.chevronRight),
//                      leading: Image.asset("assets/images/cash.png",height: 32,width: 32,),
//                    ),
//                  ),
                ],
              ),
            ),
            if (provider.isBusy)
              Positioned.fill(
                  child: AnimatedOpacity(
                      opacity: 0.7,
                      duration: Duration(milliseconds: 500),
                      child: Container(color: LightColor.grey_green))),
            if (provider.isBusy)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black),
                ),
              )
          ],
        ),
      ),
    );
  }
}
