import 'package:animations/animations.dart';
import 'package:ecommerceApp/Views/PaymentProceed/model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ScreenPayment extends StatelessWidget {

  PaymentViewModel paymentViewModel = PaymentViewModel();
  List<Widget> _pages;
  bool _isLoggedIn = false;
  SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentViewModel>.reactive(
        onModelReady: (model)=>model.listenToUserRegisteration(),
        viewModelBuilder: ()=>paymentViewModel,
        builder: (context, model,child) {

          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,

            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: const Text('Checkout',style:TextStyle(
                  fontSize: 21
              )),leading: IconButton(onPressed: (){
              if(model.pageIndex>0)
                model.pageIndex -= 1;
              else
                model.navigationService.goBack();

            },icon: Icon(Icons.chevron_left,size: 32,color:Colors.black,),),),
            body: WillPopScope(
              onWillPop: (){
                if(model.pageIndex>0)
                  model.pageIndex -= 1;
                else
                  model.navigationService.goBack();
              },
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 8,
                        color:Colors.white,
                        child: Stack(
                          children: <Widget>[

                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 4),
                      child: PageTransitionSwitcher(
                        duration: const Duration(milliseconds: 300),
                        reverse: !_isLoggedIn,
                        transitionBuilder: (
                            Widget child,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            ) {
                          return SharedAxisTransition(
                            child: child,
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: _transitionType,
                          );
                        },
                        child: _pages[model.pageIndex],
                      ),
                    ),
                  ],
                ),
              ),
            ),

          );
        }
    );

  }
}
