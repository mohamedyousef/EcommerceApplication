import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Views/account/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyOrdersList extends StatelessWidget {
  List<Order>data;
  MyOrdersList(this.data);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return OrderRow(data[index]);
      },
      itemCount:  data.length,
    );
  }
}
