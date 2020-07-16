import 'package:animations/animations.dart';
import 'package:ecommerceApp/Models/order.dart';
import 'package:ecommerceApp/Views/account/widgets/myOrderList.dart';
import 'package:ecommerceApp/Views/wishlist/widgets/widgets.dart';
import 'package:ecommerceApp/Widgets/empty_wishlist.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Views/account/models/myorder_view_model.dart';

class MyOrdersScreen extends StatelessWidget {

  PageController pageContaroller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyOrderViewModel>.reactive(
        viewModelBuilder: () => MyOrderViewModel(),
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.grey.shade50,
              appBar: AppBar(
                backgroundColor: Colors.grey.shade50,
                elevation: 0,
                title: Text("MY ORDERS"),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    model.navigationService.goBack();
                  },
                ),
              ),
              body: !model.isBusy
                  ?(model.data!=null&&model.data.isEmpty)? EmptyWidget(
                subTitle:
                "Keep track of your orders and return here ",
                title: "You Have No Orders Yet",
                photo: "assets/images/order_empty.png",
                bottomChild: OutlineButton(
                  child: Text("Shop Now"),
                  highlightedBorderColor: Colors.black,
                  borderSide:
                  BorderSide(color: Colors.black, width: 1.5),
                  onPressed: () {
                    model.navigationService
                        .navigateTo(ViewAllCats);
                  },
                ),
              ) :SizedBox.expand(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1.6),
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: TabbarButtonWishList("Current", () {
                                    model.pageIndex = 0;
                                    pageContaroller.animateToPage(model.pageIndex, duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  }, model.pageIndex == 0),
                                ),
                                Expanded(
                                  child: TabbarButtonWishList("Past", () {
                                    model.pageIndex = 1;
                                    pageContaroller.animateToPage(model.pageIndex, duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  }, model.pageIndex == 1),
                                ),
                              ],
                            ),
                          ),
                          if(model.data!=null)
                          Expanded(
                            child: PageView.builder(
                              controller: pageContaroller,
                              itemCount: 2,
                              onPageChanged: (value)=>model.pageIndex=value,
                              itemBuilder:  (context,index){
                                return  MyOrdersList((index==0)?
                                model.data.where((element) => element.status.toString()==OrderStatus.pending
                                    ||
                                    element.status.toString()==
                                        OrderStatus.processing.toString()
                                ).toList()
                                    :
                                model.data.where((element) => element.status.toString()==OrderStatus.completed.toString()||
                                    element.status.toString()==OrderStatus.cancelled||
                                    element.status.toString()==OrderStatus.failed||
                                    element.status.toString()==OrderStatus.refunded
                                ).toList()
                                );
                              },

                            ),
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ),
                    ));
        });
  }
}
