import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/wishlist_models/board.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToBoard extends StatelessWidget {
  Widgets widget = Widgets();
  Product _product;
  AddToBoard(this._product);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              Text("ADD TO BOARD",style: GoogleFonts.robotoCondensed()
                  .copyWith(fontSize: 17,color: Colors.black87,fontWeight: FontWeight.bold,)),

              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddBoradRoute);
                },
                icon: Icon(Icons.add, size: 32,color: Colors.black,),
              ),
            ],
          ),
          SizedBox(height: 10,),
          StreamBuilder<List<Board>>(
            stream: DataOP().getAllBoards(),
            builder: (context, snapshot) {
              if(snapshot.hasData)
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(8),
                    itemBuilder:(context,index){
                      return widget.wishListBoardRowList(snapshot.data[index],_product,(){
                        Navigator.pop(context);
                      });
                    }
                    , itemCount: snapshot.data.length,
                  separatorBuilder: (BuildContext context, int index) { return Divider(); }, ),
              );

            return Container();
            }
          )

        ],
      );
    },
    );
  }
}
