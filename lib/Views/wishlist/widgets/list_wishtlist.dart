import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/variation.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Views/wishlist/widgets/bottom_sheet_wishlist_board.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishList extends StatelessWidget {
  Widgets widget = Widgets();
  Api _api = locator<Api>();


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      child: StreamBuilder(
        stream: DataOP().getAllProducts(),
        builder: (context,AsyncSnapshot<List<Product>> snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if(snapshot.hasData)
            return ListView.separated(

              itemBuilder: (context,index){
              return Dismissible(
                direction: DismissDirection.endToStart,
                onDismissed: (direction){

                    DataOP().deleteProductFromFav(snapshot.data[index].localID);

                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(
                        "${snapshot.data[index].name} deleted from wishlit"),
                      duration: Duration(seconds: 2),));

                  },

                key: Key(snapshot.data[index].name),
                background: Container(color:Colors.redAccent ),
                child:(snapshot.data[index].variations!=null&&snapshot.data[index].variations.isNotEmpty)?
                FutureBuilder(future: _api.getVariation(snapshot.data[index].id,snapshot.data[index].variations[0]),
                  builder: (context,AsyncSnapshot<Variation>data){
                    if(data.hasData)
                      return widget.wishListProductRow(
                        snapshot.data[index],
                        onpressed: (){
                          Provider.of<ShoppingCartProvider>(context,listen: false)
                              .addProduct(snapshot.data[index],data.data);
                        },
                        addToBoard: (){
                          showModelBottomSheet(context,snapshot.data[index]);
                        },
                      );

                    return Container();

                  },
                ):
                widget.wishListProductRow(snapshot.data[index],onpressed: (){
                  Provider.of<ShoppingCartProvider>(context,listen: false)
                      .addProduct(snapshot.data[index],null);


                },addToBoard: (){
                  showModelBottomSheet(context,snapshot.data[index]);
                }),
              );
            },itemCount: snapshot.data.length

              , separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.black26,); },);
            break;
          }
          return Container();
        }
      ),
    );
  }

  void showModelBottomSheet(BuildContext context,Product product){
    showModalBottomSheet(context: context,
      builder: (context){
        return AddToBoard(product);
      },
      isScrollControlled: true,
    );
  }

}
