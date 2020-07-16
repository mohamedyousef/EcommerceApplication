//import 'package:animations/animations.dart';
//import 'package:ecommerceApp/Views/PaymentProceed/model/payment_view_model.dart';
//import 'package:ecommerceApp/Views/PaymentProceed/screen/payment_page/payment_page.dart';
//import 'file:///D:/MyWork/Work/programming/APPS/Ecommerce%20App/code/ecommerceApp/lib/Views/PaymentProceed/screen/shipping/add_shipping_page.dart';
//import 'package:flutter/material.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:stacked/stacked.dart';
//
//class PaymentProceedScreen extends StatefulWidget {
//  @override
//  _PaymentProceedScreenState createState() => _PaymentProceedScreenState();
//}
//
//class _PaymentProceedScreenState extends State<PaymentProceedScreen> {
//
//  SharedAxisTransitionType _transitionType =
//      SharedAxisTransitionType.horizontal;
//
//  bool _isLoggedIn = false;
//
//  List<Widget> _pages;
// // CountiresProvider countreyProvider;
//  PaymentViewModel paymentViewModel = PaymentViewModel();
//
//
//  @override
//  void initState() {
//    super.initState();
//    _pages =[
//      PaymentPage(),
//      ShippingPage((shippingIng){
//      paymentViewModel.pageIndex = 1;
//      _isLoggedIn = !_isLoggedIn;
//      setState(() {});
//
//    }),Container(color:Colors.black),Container(color:Colors.black)];
//  }
//
//  @override
//  Widget build(BuildContext context) {
////  final countreyProvider = Provider.of<CountiresProvider>(context);
//    final bottom = MediaQuery.of(context).viewInsets.bottom;
//    return ViewModelBuilder<PaymentViewModel>.reactive(
//      onModelReady: (model)=>model.listenToUserRegisteration(),
//      viewModelBuilder: ()=>paymentViewModel,
//      builder: (context, model,child) {
//        return Scaffold(
//          backgroundColor: Colors.white,
//          resizeToAvoidBottomInset: false,
//          resizeToAvoidBottomPadding: false,
//          appBar: AppBar(
//            centerTitle: true,
//            elevation: 0,
//            backgroundColor: Colors.black,
//            title: const Text('Checkout',style:TextStyle(
//              fontSize: 21,
//              color: Colors.white
//            )),leading: IconButton(onPressed: (){
//            if(model.pageIndex>0)
//              model.pageIndex -= 1;
//            else
//              model.navigationService.goBack();
//
//          },icon: Icon(Icons.chevron_left,size: 32,color:Colors.black,),),),
//          body: WillPopScope(
//            onWillPop: (){
//              if(model.pageIndex>0)
//                model.pageIndex -= 1;
//              else
//                model.navigationService.goBack();
//            },
//            child: SafeArea(
//              child: SingleChildScrollView(
//                reverse: true,
//                child: Padding(
//                  padding:   EdgeInsets.only(bottom:bottom),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Padding(
//                        padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 4),
//                        child: PageTransitionSwitcher(
//                          duration: const Duration(milliseconds: 300),
//                          reverse: !_isLoggedIn,
//                          transitionBuilder: (
//                              Widget child,
//                              Animation<double> animation,
//                              Animation<double> secondaryAnimation,
//                              ) {
//                            return SharedAxisTransition(
//                              child: child,
//                              animation: animation,
//                              secondaryAnimation: secondaryAnimation,
//                              transitionType: _transitionType,
//                            );
//                          },
//                        child: _pages[model.pageIndex],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
//        );
//      }
//    );
//  }
//
//
//
//
//
//}
