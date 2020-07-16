import 'package:ecommerceApp/animation/animation.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/constants/route_path.dart';

class CongratsScreen extends StatelessWidget {

  NavigationService _navigationService =  locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:Icon(Icons.chevron_left,size: 32,color: Colors.black,),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: ScreenUtils.screenHeight(context,size: 0.06),),
            Material(
              elevation: 8,
              shape: CircleBorder(),
              child: Container(
                height: 150,
                width: 150,
                child: Stack(
                  children: <Widget>[
                    Center(child: Image.asset("assets/images/order.png",width: 74,height: 74,fit: BoxFit.contain,)),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FadeAnimation(
                        1.2,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.black,

                    shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 5
                  ),
//                boxShadow: [
//                  BoxShadow(
//                    color: Colors.grey.shade200,
//                    blurRadius: 2,
//                    spreadRadius: 6
//                  )
//                ]
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("Order Success",style: AppTheme.h3Style.copyWith(
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 10,),
            Text("Your order has been placed successfully ",
              style: AppTheme.subTitleStyle.copyWith(
                fontSize: 15
              ),),
            SizedBox(height: 4,),
            Expanded(child: Text("for more details. go to my orders .",style: AppTheme.subTitleStyle.copyWith(
              fontSize: 15
            ),)),

            OutlineButton(
              onPressed: (){
                _navigationService.navigateTo(MyOrdersRoute);
              },
              highlightedBorderColor: Colors.black,
              borderSide: BorderSide(
                color: Colors.black,

                width: 1.5
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: Text("MY ORDERS"),
              ),
            ),
            //SizedBox(height: 4,),
            RaisedButton(
              onPressed: (){
                _navigationService.navigatorKey.currentState.pushReplacementNamed(HomeRoute);
              },
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0),
                child: Text("CONTINUE  SHOPPING",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: ScreenUtils.screenHeight(context,size: 0.12),),

          ],
        ),
      ),
    );
  }
}
