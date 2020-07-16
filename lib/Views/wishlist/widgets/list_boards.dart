import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/wishlist_models/board.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:flutter/material.dart';

class ListBoards extends StatelessWidget {
  Widgets widget = Widgets();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white60,
      child: StreamBuilder(
          stream: DataOP().getAllBoards(),
          builder: (context, AsyncSnapshot<List<Board>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                print(snapshot.data.toString());
                if (snapshot.hasData)
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return Dismissible(
                        onDismissed: (direction) {
                          DataOP()
                              .deleteBoard(snapshot.data[index].id);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "${snapshot.data[index].title} deleted from Boards"),
                            duration: Duration(seconds: 2),
                          ));
                        },
                        direction: DismissDirection.endToStart,

                        key: Key(snapshot.data[index].title),
                        background: Container(color: Colors.redAccent),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, BoradRoute,
                                arguments: snapshot.data[index]);
                          },
                          child: widget.wishListBoardRow(snapshot.data[index],
                              width:
                                  ScreenUtils.screenWidth(context, size: 0.25),
                              height: ScreenUtils.screenHeight(context,
                                  size: 0.16)),
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.black26,
                      );
                    },
                  );
                break;
            }
            return Container();
          }),
    );
  }
}
