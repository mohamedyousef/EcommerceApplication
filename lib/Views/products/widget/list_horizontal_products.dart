import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../../locator.dart';


class ListHorizontalProducts extends StatelessWidget {

  List<Product> products;
  bool isFromlocal;
  Widgets widgets =Widgets();
  ListHorizontalProducts(this.products,this.isFromlocal);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(8),
      itemBuilder: (context,index){
//        if(isFromlocal) {
//        return  FutureBuilder(
//            future: locator<Api>().getProduct(products[index].id), builder:
//              (BuildContext context, AsyncSnapshot<Product> snapshot) {
//              return Widgets().productRow(snapshot.data);
//              },
//          );
//        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: widgets.productRow(products[index],photoheight: 140),
          );
       // }
      },itemCount: products.length,);
  }
}
