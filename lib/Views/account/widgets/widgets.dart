import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderRow extends StatelessWidget {
  Order _order;
  OrderRow(this._order);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 25,
        ),
        Text("${DateFormat('MMM dd , yyyy').format(_order.dateCreated)} ",
            style: AppTheme.h1Style.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 8,
        ),
        RawMaterialButton(
          onPressed: (){
            Navigator.pushNamed(context, OrderRoute,arguments: _order);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          elevation: 4,
          fillColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Order ID : ${_order.number}",
                        style: AppTheme.subTitleStyle),
                    Text("${_order.lineItems.length} items",
                        style: AppTheme.subTitleStyle)
                  ],
                ),
                for (var item in _order.lineItems)
                  FutureBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<ProductCart> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container();
                          break;
                        case ConnectionState.active:
                        case ConnectionState.done:
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical:8.0),
                            child: Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  color: Colors.grey.shade50,
                                  child: photoUrlWithoutBorder(snapshot.data.getImage(),
                                      width: 100, height: 85),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 10,),
                                      Text(
                                        snapshot.data.product.name,
                                        style: AppTheme.h4Style.copyWith(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      if(snapshot.data.variation.id>0)
                                      Text(
                                          "${snapshot.data.product.attributes.map((e) => e.name)}"),


                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                          text:"${snapshot.data.getTotalPrice()} ${_order.currency}",
                                          style: AppTheme.titleStyle.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13
                                          )
                                      ),
                                      TextSpan(text: " "),
                                      TextSpan(
                                        text:"x${snapshot.data.quantity}",
                                        style: AppTheme.subTitleStyle,
                                      )
                                    ],
                                  ),

                                )
                              ],
                            ),
                          );
                          break;
                      }

                      return Container();
                    },
                    future: locator<Api>().getProductCartFromOrder(
                        item.productId, item.quantity,
                        varId: item.variationId),
                  ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Sub-total :", style: AppTheme.subTitleStyle),
                      Text(
                          "${_order.subTotal().toStringAsFixed(2)} ${_order.currencySymbol} ",
                          style: AppTheme.subTitleStyle.copyWith(
                              fontWeight: FontWeight.bold
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Delivery :", style: AppTheme.subTitleStyle),
                      Text("${_order.shippingTotal} ${_order.currencySymbol} ",
                          style: AppTheme.subTitleStyle.copyWith(
                              fontWeight: FontWeight.bold
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Discount :", style: AppTheme.subTitleStyle),
                      Text("${_order.discountTotal} ${_order.currencySymbol} ",
                          style: AppTheme.subTitleStyle.copyWith(
                              color: double.parse(_order.discountTotal) > 0
                                  ? Colors.red
                                  : Colors.black87,fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total :",
                        style: AppTheme.titleStyle
                            .copyWith(fontWeight: FontWeight.w500)),
                    Text("${_order.total} ${_order.currencySymbol} ",
                        style: AppTheme.titleStyle.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w500))
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
