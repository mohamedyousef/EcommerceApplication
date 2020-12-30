import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Views/account/models/order_view_model.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {
  Order _order;

  OrderScreen(this._order);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderViewModel>.reactive(
        viewModelBuilder: () => OrderViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                "Order detail",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      color: Colors.white,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("ORDER ID  ",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54)),
                                Text("${_order.number}",
                                    style: AppTheme.titleStyle.copyWith()),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("GRAND TOTAL  ",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54)),
                                Text("${_order.total}  ${_order.currency}",
                                    style: AppTheme.titleStyle.copyWith()),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Order total includes any applicable VAT  ",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black54)),
                            SizedBox(
                              height: 11,
                            ),
                            if (model.showMore)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("ORDER DATE  ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54)),
                                      Text(
                                          "${DateFormat("EEEE, MMM dd, yyyy").format(_order.dateCreated)}",
                                          style: AppTheme.titleStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("TOTAL",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          )),
                                      Text(
                                          "${_order.total}  ${_order.currency}",
                                          style: AppTheme.titleStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("TOTAL SHIPPING",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          )),
                                      Text(
                                          "${_order.shippingTotal}  ${_order.currency}",
                                          style: AppTheme.titleStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("PAYMENT MODE",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          )),
                                      Text(
                                          "${(_order.paymentMethod.toLowerCase() == "cod") ? "Cash On Delivery" : _order.paymentMethodTitle} ",
                                          style: AppTheme.titleStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _order.shipping.getFullName(),
                                    style: AppTheme.titleStyle
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      _order.shipping.address1 +
                                          ", " +
                                          _order.shipping.address2 +
                                          ", " +
                                          _order.shipping.city,
                                      style: AppTheme.titleStyle
                                          .copyWith(fontSize: 14)),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    _order.billing.phone,
                                    style: AppTheme.titleStyle
                                        .copyWith(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            Divider(
                              color: Colors.grey,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  model.showMore = !model.showMore;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (model.showMore) ? "Hide" : "Show Details",
                                    style: TextStyle(color: LightColor.skyBlue),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Shipment Details ",
                        style: AppTheme.titleStyle.copyWith(
                            color: LightColor.green_light_dp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Card(
                        color: Colors.white,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "SHIPMENT STATUS",
                                style: AppTheme.h5Style
                                    .copyWith(color: Colors.grey.shade600),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                (_order.status == OrderStatus.on_hold ||
                                        _order.status == OrderStatus.pending)
                                    ? "Pending"
                                    : (_order.status == OrderStatus.processing)
                                        ? "InProcessing"
                                        : (_order.status ==
                                                OrderStatus.completed)
                                            ? "Completed"
                                            : "",
                                style: AppTheme.h5Style
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 12,
                                    child: (_order.status ==
                                                OrderStatus.pending ||
                                            _order.status ==
                                                OrderStatus.on_hold ||
                                            _order.status ==
                                                OrderStatus.on_hold ||
                                            _order.status ==
                                                OrderStatus.processing ||
                                            _order.status ==
                                                OrderStatus.completed)
                                        ? Icon(Icons.check, color: Colors.white)
                                        : CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 10,
                                          ),
                                    backgroundColor: LightColor.green_deep,
                                  ),
                                  Expanded(
                                      child: Container(
                                    color: LightColor.green_deep,
                                    height: 4,
                                  )),
                                  CircleAvatar(
                                    radius: 12,
                                    child: (_order.status ==
                                                OrderStatus.processing ||
                                            _order.status ==
                                                OrderStatus.completed)
                                        ? Icon(Icons.check, color: Colors.white)
                                        : CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 10,
                                          ),
                                    backgroundColor: LightColor.green_deep,
                                  ),
                                  Expanded(
                                      child: Container(
                                    color: LightColor.green_deep,
                                    height: 4,
                                  )),
                                  CircleAvatar(
                                    radius: 12,
                                    child: (_order.status ==
                                            OrderStatus.completed)
                                        ? Icon(Icons.check, color: Colors.white)
                                        : CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 10,
                                          ),
                                    backgroundColor: LightColor.green_deep,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Pending",
                                    style: AppTheme.subTitleStyle
                                        .copyWith(color: Colors.black87),
                                  ),
                                  Text(
                                    "InProcessing",
                                    style: AppTheme.subTitleStyle
                                        .copyWith(color: Colors.black87),
                                  ),
                                  Text(
                                    "Completed",
                                    style: AppTheme.subTitleStyle
                                        .copyWith(color: Colors.black87),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Divider(
                                thickness: 2,
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
                                        return InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, ProductRoute,
                                                arguments:
                                                    snapshot.data.product);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              //   crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  color: Colors.grey.shade50,
                                                  child: photoUrlWithoutBorder(
                                                      snapshot.data.getImage(),
                                                      width: 100,
                                                      height: 85),
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                          snapshot.data.product
                                                              .name,
                                                          style: GoogleFonts
                                                                  .roboto()
                                                              .copyWith(
                                                                  fontSize:
                                                                      16)),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      if (snapshot.data
                                                              .variation.id >
                                                          0)
                                                        Text(
                                                            "${snapshot.data.product.attributes.map((e) => e.name)}"),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            "Qty: ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13),
                                                          ),
                                                          Text(
                                                            " ${snapshot.data.quantity}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      Text(
                                                        "${snapshot.data.getTotalPrice()} ${_order.currency}",
                                                        style: AppTheme
                                                            .titleStyle
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                        break;
                                    }

                                    return Container();
                                  },
                                  future: locator<Api>()
                                      .getProductCartFromOrder(
                                          item.productId, item.quantity,
                                          varId: item.variationId),
                                ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
