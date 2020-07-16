import 'package:ecommerceApp/Models/variation.dart';
import 'package:ecommerceApp/Models/wishlist_models/board.dart';
import 'package:ecommerceApp/Views/wishlist/view_model/board_view_model.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/constants/route_path.dart';

class BoardScreen extends StatelessWidget {
  Board _board;

  BoardScreen(this._board);

  Widgets _widgets = Widgets();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BoardViewModel>.reactive(
        viewModelBuilder: () => BoardViewModel(),
        onModelReady: (model)=>model.board=_board,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: (model.select)
                ? BottomAppBar(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: RawMaterialButton(
                                fillColor: Colors.black,
                                onPressed: () {
                                  Navigator.pushNamed(context,ViewAllCats);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.5),
                                  child: Text("Add Items",
                                      style: TextStyle(color: Colors.white)),
                                )),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: RawMaterialButton(
                                fillColor: Colors.red,
                                onPressed: () {
                                  model.Delete();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.5),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
            appBar: AppBar(
              elevation: 0,
              title: Text("Boards"),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.left_chevron,
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      model.select = !model.select;
                    },
                    child: Text(
                      (model.select) ? "Done" : "Select",
                    )),
              ],
              centerTitle: true,
            ),
            body: Column(
              children: <Widget>[
                Container(
                  color: Colors.grey.shade100,
                  height: ScreenUtils.screenHeight(context, size: 0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "${_board.title}",
                          style: AppTheme.h1Style,
                        ),
                        Text(
                          "${_board.productsIds.length} items",
                          style: AppTheme.subTitleStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return (_board.productsIds[index].variations != null &&
                              _board.productsIds[index].variations.isNotEmpty)
                          ? FutureBuilder(
                              future: model.api.getVariation(
                                  _board.productsIds[index].id,
                                  _board.productsIds[index].variations[0]),
                              builder:
                                  (context, AsyncSnapshot<Variation> data) {
                                if (data.hasData)
                                  return _widgets.wishListProductRow(
                                      _board.productsIds[index],
                                      isBoard: true,
                                      onpressed: () {
                                        Provider.of<ShoppingCartProvider>(
                                                context,
                                                listen: false)
                                            .addProduct(
                                                _board.productsIds[index],
                                                data.data);
                                      },
                                      isSelect: model.select,
                                      onChange: (value) {
                                        if (value)
                                          model.remove(_board.productsIds[index]);
                                        else
                                          model.add(
                                              _board.productsIds[index]);
                                      });

                                return Container();
                              },
                            )
                          : _widgets.wishListProductRow(
                              _board.productsIds[index],
                              onpressed: () {
                                Provider.of<ShoppingCartProvider>(context,
                                        listen: false)
                                    .addProduct(
                                        _board.productsIds[index], null);
                              },
                              isSelect: model.select,
                              onChange: (value) {
                                if (value)
                                  model.remove(_board.productsIds[index]);
                                else
                                  model.add(_board.productsIds[index]);
                              },isBoard: true);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemCount: model.board.productsIds.length,
                  ),
                )
              ],
            ),
          );
        });
  }
}
