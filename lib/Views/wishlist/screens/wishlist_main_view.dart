import 'package:ecommerceApp/Views/wishlist/widgets/bottom_sheet_wishlist_board.dart';
import 'package:ecommerceApp/Views/wishlist/widgets/list_boards.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceApp/Views/wishlist/widgets/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Views/wishlist/view_model/whistlist_main_view_model.dart';
import 'package:animations/animations.dart';
import 'package:ecommerceApp/Views/wishlist/widgets/list_wishtlist.dart';
import 'file:///D:/MyWork/Work/programming/APPS/Ecommerce%20App/code/ecommerceApp/lib/Widgets/empty_wishlist.dart';

class WishListHomeView extends StatelessWidget {

  List<Widget> pages = [WishList(),ListBoards()];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WishListViewModelMain>.reactive(
      onModelReady: (model)=>model.checkIFEmptyOrNo(),
      builder: (context, model, child) {
        return (model.isEmpty)?Container(
          color: Colors.white60,
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
                      child: TabbarButtonWishList("All items", () {
                        model.pageIndex = 0;
                      }, model.pageIndex == 0),
                    ),
                    Expanded(
                      child: TabbarButtonWishList("Boards", () {
                        model.pageIndex = 1;
                      }, model.pageIndex == 1),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: PageTransitionSwitcher(
                        duration: Duration(seconds: 1),
                        transitionBuilder: (
                          Widget child,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                        ) {
                          return FadeThroughTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            child: child,
                          );
                        },
                        child: pages[model.pageIndex],
                      ),
                    ),
                    if(model.pageIndex>0)
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            model.navigationService.navigateTo(AddBoradRoute);
                          },
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ):EmptyWidget(title: "Your Wishlist is Empty ",
          photo: "assets/images/box.png",
          subTitle:"Tab  heart button to start saving your favorite items " ,);
      },
      viewModelBuilder: () => WishListViewModelMain(),
    );
  }


}
