import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Views/PaymentProceed/screen/shipping/choose_address.dart';
import 'package:ecommerceApp/Views/ShoppingCart/widgets/widgets.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}


class _ShoppingCartScreenState extends State<ShoppingCartScreen> {

  NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingCartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         leading: IconButton(
           onPressed: (){
             navigationService.goBack();
           },
           icon: Icon(Icons.close),
         ),
         title: Text("Shopping Cart"),
         elevation: 0,
       ),
       body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             children: <Widget>[
               Container(color:Colors.grey.shade50,
               padding: EdgeInsets.all(16),child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text("Total Items :  ${provider.getTotalNumbers()}",style: TextStyle(
                     color: ColorsStyles.blue,fontSize: 16,
                    ),),

                 OutlineButton(
                   onPressed: (){
                     provider.clear();
                   },
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                   child: Row(
                     children: <Widget>[
                       Icon(MdiIcons.deleteOutline,color:LightColor.coffee),
                     ],
                   ),
                 ),
                 ],
               ),),
               ListView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemCount:provider.products.length,
                 itemBuilder: (context,index){
                   return shoppingCartItem(provider.products[index], (){});
                 },
               ),

               Container(
                 color: Colors.grey.shade100,
                 padding: EdgeInsets.all(16),
                 margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                 child: Column(
                   children: <Widget>[
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                       Text("products",style: TextStyle(color: ColorsStyles.blue,fontSize: 16),),
                       Text("x${provider.getTotalNumbers()}",style: TextStyle(
                       fontWeight: FontWeight.bold
                       ,color: ColorsStyles.blue.withAlpha(190),fontSize: 16),),
                     ],),
                     SizedBox(height: 18,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                       Text("Total :",style: TextStyle(color: ColorsStyles.blue,fontSize: 19),),
                         Text("\$${provider.getTotalPrice()}",style: TextStyle(
                       fontWeight: FontWeight.bold
                       ,color: ColorsStyles.blue.withAlpha(190),fontSize: 19),),
                     ],),
                   ],
                 ),
               ),
               Container(
                 width: double.infinity,
                 padding: EdgeInsets.all(8),
                 height: 60,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                 child: RawMaterialButton(
                   elevation: 4,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                   fillColor: Colors.black,
                   onPressed: (){navigationService.navigateTo(AddressChooseRoute);},
                   child:
                   Text("Payment Proceed  \$${provider.getTotalPrice()}",style:
                   TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                 ),
               ),
               SizedBox(height: 18,),
             ],
           ),
         ),
       ),
    );
  }



}

