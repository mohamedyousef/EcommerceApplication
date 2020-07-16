import 'package:animations/animations.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Views/ShoppingCart/screens/shopping_cart_screen.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class shoppingCartItem extends StatefulWidget {
  ProductCart _product;
  VoidCallback onPressed;

  shoppingCartItem(this._product, this.onPressed);

  @override
  _shoppingCartItemState createState() => _shoppingCartItemState();
}

class _shoppingCartItemState extends State<shoppingCartItem> {
  int quantity = 1;
  ShoppingCartProvider shoppingCartProvider;

  @override
  void initState() {
    super.initState();
    quantity = widget._product.quantity;
    shoppingCartProvider =
        Provider.of<ShoppingCartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () {
              onPressed();
            },
            icon: Icon(Icons.remove_circle_outline, color: ColorsStyles.blue),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                photoUrl((widget._product.variation.id>0)?widget._product.variation.image.src:widget._product.product.images[0].src,
                    height: 90, width: 100, fit: BoxFit.fitHeight),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget._product.product.name,
                        style: GoogleFonts.lato(
                            fontSize: 18, color: ColorsStyles.blue),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        (widget._product.getTotalPrice()).toString(),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorsStyles.blue),
                      ),
                    ],
                  ),
                ),
                _counterWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }

  onPressed() {
    widget.onPressed();
    shoppingCartProvider.removeProduct(widget._product.product.id,
        varID: (widget._product.variation != null)
            ? widget._product.variation.id
            : 0);
  }

  Widget _counterWidget() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RawMaterialButton(
            fillColor: LightColor.verylightcoffee,
            shape: CircleBorder(),
            elevation: 2,
            onPressed: () {
              quantity++;
              shoppingCartProvider.addProduct(
                  widget._product.product, widget._product.variation);
            },
            child: Icon(Icons.add,color:ColorsStyles.blue),
          ),
          SizedBox(height: 3,),
          Text(quantity.toString(),style: TextStyle(fontSize: 15,color:ColorsStyles.blue,fontWeight: FontWeight.bold),),
          SizedBox(height: 3,),
          RawMaterialButton(
            fillColor: LightColor.verylightcoffee,
            shape: CircleBorder(),
            elevation: 2,
            onPressed: () {
              if (quantity != 1) {
                quantity--;
                shoppingCartProvider.decrement(widget._product.product.id,
                    varID: (widget._product.variation != null)
                        ? widget._product.variation.id
                        : 0);
              }
            },
            child: Icon(Icons.remove,color:ColorsStyles.blue),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartIcon extends StatelessWidget {
  ShoppingCartProvider shoppingCartProvider;

  @override
  Widget build(BuildContext context) {
    shoppingCartProvider = Provider.of<ShoppingCartProvider>(context);
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (BuildContext _, VoidCallback openContainer) {
        return ShoppingCartScreen();
      },
      tappable: false,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      closedElevation: 0.0,
      closedColor: Colors.transparent,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: get_cart(onpressed: openContainer),
        );
      },
    );
  }

  Widget get_cart({onpressed}) {
    String data;

    Widget widget = Icon(
      MdiIcons.basketOutline,
      size: 26,
      color: Colors.black,
    );

    int count = shoppingCartProvider.getTotalNumbers();

    if (count > 0) {
      if (count > 9)
        data = "9+";
      else
        data = count.toString();
      widget = IconButton(
          icon: Stack(
            children: <Widget>[
              new Icon(
                MdiIcons.basketOutline,
                size: 28,
              ),
              new Positioned(
                right: 0,
                child: new Container(
                  padding: EdgeInsets.all(1),
                  decoration: new BoxDecoration(
                    color: Colors.yellowAccent.shade700,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: new Text(
                    data.toString(),
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
          onPressed: onpressed);
    }

    return widget;
  }
}



class ShoppingCartIconProducts extends StatelessWidget {
//  bool enable = false;
  Product product;
  ShoppingCartIconProducts(this.product);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShoppingCartProvider>(context, listen: false);

    return
      //(enable)
//        ? Container(
//            decoration: BoxDecoration(
//                color: Colors.transparent,
//                borderRadius: BorderRadius.only(
//                    bottomRight: Radius.circular(8),
//                    topLeft: Radius.circular(8))),
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Icon(
//                Icons.check_circle_outline,
//                color: Colors.black,
//              ),
//            ))
//        :
    InkWell(
            onTap: () {
              provider.addProduct(product, null);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: LightColor.lightcoffee,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(8),
                        topLeft: Radius.circular(8))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.black,
                  ),
                )),
          );
  }
}
