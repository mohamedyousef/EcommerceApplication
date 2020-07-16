import 'dart:async';
import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import 'package:ecommerceApp/Views/PaymentProceed/widgets/widgets.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/providers/checkout_provider.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';

class ChooseAddress extends StatefulWidget {
  @override
  _ChooseAddressState createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  int groupValue = 0;
  CheckOutProvider checkOutProvider;
  TextEditingController coupon = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await checkOutProvider.shippingService.getShippingZone();

      if (checkOutProvider.authenticationService.userData != null) {
        checkOutProvider.shippingAddress =
            checkOutProvider.authenticationService.userData.shipping;
        checkOutProvider.getShippingMethods();
      } else {
        Navigator.pushReplacementNamed(context, LoginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkOutProvider = Provider.of<CheckOutProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Container(
          height: 150,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Grand Total",
                      style: AppTheme.subTitleStyle,
                    ),
                    Text(
                      "${checkOutProvider.getTotalPrice()}"
                      " ${checkOutProvider.settingsServices.userSettings.currency}",
                      style: AppTheme.h4Style,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Order total include any applicable VAT",
                  style: AppTheme.subTitleStyle,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  fillColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "CONTINUE TO PAYMENT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {

                    if (checkOutProvider.shippingAddress == null)
                      showAddAddress();
                    else if(checkOutProvider.shippingMethods[checkOutProvider.currentPaymentMethods]==null)
                      return;
                    else
                      checkOutProvider.navigationService
                          .navigateTo(PaymentChooseRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text("Shipping"),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              "assets/images/coupone.png",
              width: 32,
              height: 32,
            ),
            onPressed: () {
              showCoupon();
            },
          ),
          SizedBox(width: 10)
        ],
        leading: IconButton(
          onPressed: () {
            checkOutProvider.navigationService.goBack();
          },
          icon: Icon(CupertinoIcons.left_chevron),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 280,
              padding:
                  const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 3,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                groupValue = 0;
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  activeColor: Colors.black,
                                  onChanged: (value) {
                                    groupValue = value;
                                    setState(() {});
                                  },
                                  groupValue: groupValue,
                                  value: 0,
                                ),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 14),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Ship to my delivery address",
                                          style: TextStyle(
                                              color: ColorsStyles.blue,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (checkOutProvider.shippingAddress !=
                                          null)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                checkOutProvider.shippingAddress
                                                    .getFullName(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              checkOutProvider.shippingAddress
                                                      .address1 +
                                                  checkOutProvider
                                                      .shippingAddress.address2,
                                              style: AppTheme.subTitleStyle,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                checkOutProvider
                                                    .shippingAddress.phone
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      InkWell(
                                        onTap: () {
                                          showBottomSheetAddress();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 4),
                                          child: Text(
                                            (checkOutProvider.shippingAddress !=
                                                    null)
                                                ? "Change Address"
                                                : "Choose Address",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: LightColor.skyBlue),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ))),
                    Divider(),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              groupValue = 1;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Radio(
                                activeColor: Colors.black,
                                onChanged: (value) {
                                  groupValue = value;
                                  setState(() {});
                                },
                                groupValue: groupValue,
                                value: 1,
                              ),
                              Expanded(
                                child: Text(
                                  "Ship to nearby pickup location",
                                  style: TextStyle(
                                      color: ColorsStyles.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(
                                Icons.location_on,
                                color: ColorsStyles.blue,
                              ),
                              SizedBox(
                                width: 12,
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtils.screenHeight(context, size: 0.05),
            ),
            if(checkOutProvider.shippingMethods != null)
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Select Shipping Methods  :",
                    style: AppTheme.titleStyle,
                  ),
                )),
            (checkOutProvider.shippingMethods != null)
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 8),
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: <Widget>[
                        for (int index = 0;
                            index < checkOutProvider.shippingMethods.length;
                            index++)
                          InkWell(
                              onTap: () {
                                checkOutProvider.currentSelected = index;
                              },
                              child: CardShippingMethod(
                                  checkOutProvider.shippingMethods[index],
                                  index == checkOutProvider.currentSelected))
                      ],
                    ))
                : Container(),
            SizedBox(
              height: ScreenUtils.screenHeight(context, size: 0.05),
            ),
            Card(
                elevation: 3,
                child: InkWell(
                  onTap: () {
                    showCoupon();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 4),
                        Image.asset(
                          "assets/images/coupone.png",
                          height: 42,
                          width: 42,
                        ),
                        SizedBox(width: 16),
                        Text("Have Coupon?",
                            style: AppTheme.titleStyle
                                .copyWith(color: Colors.black45)),
                        SizedBox(width: 10),
                        Text("Enter Here", style: AppTheme.titleStyle)
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            if (checkOutProvider.coupon.isNotEmpty)
              Wrap(
                children: <Widget>[
                  for (var item in checkOutProvider.coupon)
                    RawMaterialButton(
                      fillColor: Colors.grey.shade50,
                      shape: RoundedRectangleBorder (
                        borderRadius: BorderRadius.circular(15)
                      ),
                      onPressed: () {
                        checkOutProvider.removeCoupon(item);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.close,color:Colors.black,size:21),
                            SizedBox(width: 8),
                            Text("${item.code}",style: AppTheme.titleStyle,)
                          ],
                        ),
                      ),
                    )
                ],
              ),
            SizedBox(
              height: ScreenUtils.screenHeight(context, size: 0.05),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Payment Summary", style: AppTheme.titleStyle),
                )),
            SizedBox(
              height: 8,
            ),

              Container(
              alignment: Alignment.bottomCenter,
              color: Colors.white,
              child: Column(children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Sub Total",
                        style: AppTheme.subTitleStyle,
                      ),
                      Text(
                        "${checkOutProvider.shoppingCartProvider.getTotalPrice()}"
                        " ${checkOutProvider.settingsServices.userSettings.currency}",
                      )
                    ],
                  ),
                ),
                if(checkOutProvider.shippingMethods != null)
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "+Shipping",
                        style: AppTheme.subTitleStyle,
                      ),
                      if (checkOutProvider.shippingMethods != null)
                        Text(
                          "${checkOutProvider.shippingMethods[checkOutProvider.currentSelected].settings.cost != null ? checkOutProvider.shippingMethods[checkOutProvider.currentSelected].settings.cost.value : 0.0} "
                          "${checkOutProvider.settingsServices.userSettings.currency}",
                        )
                    ],
                  ),
                ),
                SizedBox(height: 4,),
                if (checkOutProvider.coupon.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "-Discount",
                          style: AppTheme.subTitleStyle,
                        ),
                        Text(
                          "${checkOutProvider.getDiscountTotal()} ${checkOutProvider.settingsServices.userSettings.currency}",
                        )
                      ],
                    ),
                  ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

//
//  Column(
//  mainAxisSize: MainAxisSize.min,
//  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//  children: <Widget>[
//

//  ],
//  ),

  void showAddAddress() async {
    final result = await Navigator.pushNamed(context, AddAddressesRoute);
    checkOutProvider.shippingAddress = result;
  }

  void showBottomSheetAddress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Choose Address",
                      style: AppTheme.titleStyle,
                    ),
                    IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.black,
                        onPressed: () {
                          checkOutProvider.navigationService
                              .navigateTo(AddAddressBookRoute);
                        })
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: DataOP().getAllAddressFromDataBase(),
                    builder: (context, AsyncSnapshot<List<Ing>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  LightColor.midlightcoffee),
                            ),
                          );
                          break;
                        case ConnectionState.active:
                        case ConnectionState.done:
                          return ListView.builder(
                            padding:
                                EdgeInsets.only(left: 8, right: 8, top: 25),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(MdiIcons.mapMarkerOutline,
                                        color: Colors.grey.shade700),
                                    title: Row(
                                      children: <Widget>[
                                        Text(
                                          "${(snapshot.data[index].firstName + " " + snapshot.data[index].lastName).toUpperCase()}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 16),
                                        if (snapshot.data[index].isDefault !=
                                                null &&
                                            snapshot.data[index].isDefault)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 3),
                                            child: Text(
                                              "Default",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            color: Colors.black,
                                          )
                                      ],
                                    ),
                                    subtitle: Text(
                                        "${snapshot.data[index].address1}"),
                                    trailing: Icon(MdiIcons.squareEditOutline),
                                    onTap: () {
                                      //  checkOutProvider.navigationService.navigateTo(AddAddressBookRoute,arguments: snapshot.data[index]);
                                      checkOutProvider.shippingAddress =
                                          snapshot.data[index];
                                      checkOutProvider.getShippingMethods();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                          break;
                      }
                      return Container();
                    }),
              ),
            ],
          );
//
        });
  }

  final formKey = GlobalKey<FormState>();

  void showCoupon() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              child: Container(
                height: 125,
                width: ScreenUtils.screenWidth(context, size: 0.85),
                child: Column(
                  children: <Widget>[
                    textForm(coupon, "Enter Coupon",
                        borderColor: Colors.grey.shade300, margin: 0),
                    SizedBox(height: 5,),
                    StreamBuilder(
                      stream: checkOutProvider.streamController.stream,
                      builder: (context, AsyncSnapshot<bool> data) {
                        switch (data.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Container();
                            break;
                          case ConnectionState.active:
                          case ConnectionState.done:
                            if (data.data)
                              return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                      LightColor.black),
                              ),
                                  ));
                            else {
//                              if(checkOutProvider.resultLoadingcoupons==null)
//                               Navigator.pop(context);
//                              //  try {
//                              else
                              if (checkOutProvider.resultLoadingcoupons != null)
                                return Text(
                                    checkOutProvider.resultLoadingcoupons);
                              else if (checkOutProvider.couponFinished)
                                Navigator.pop(context);

//                                }catch(e){
//                                  Navigator.pop(context);
//                                }

                            }
                            break;
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
              key: formKey,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel",
                      style: TextStyle(color: ColorsStyles.blue))),
              FlatButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      checkOutProvider.searchCoupon(coupon.text);
                    }
                  },
                  child: Text("Apply",
                      style: TextStyle(color: LightColor.skyBlue)))
            ],
          );
        }).then((value) => {
          // checkOutProvider.coupon = null,
          coupon.text = "",
          checkOutProvider.streamController.add(false),
          checkOutProvider.resultLoadingcoupons = null,
          checkOutProvider.couponFinished = false
        });
  }

  @override
  void dispose() {
    super.dispose();
    coupon.dispose();
  }
}
