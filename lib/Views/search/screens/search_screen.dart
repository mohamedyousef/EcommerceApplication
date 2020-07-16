import 'package:ecommerceApp/Views/search/models/search_view_model.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchText = TextEditingController();

  FocusNode focuseNode =  FocusNode();

  SearchViewModel searchModel = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = 300.7;
    final double itemWidth = size.width / 2;

    return ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: () => searchModel,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 32,
                ),
                onPressed: () => model.navigationService.goBack(),
              ),
              centerTitle: true,
              elevation: 0,
              title: Text(
                "Search",
                style: TextStyle(color: ColorsStyles.blue),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: SizedBox.expand(
              child:  Column(
                children: <Widget>[
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Icon(Icons.search, color: Colors.black),
                          Flexible(
                            child: TextField(
                              onSubmitted: (value){
                                searchText.text = value;
                                focuseNode.unfocus();
                                model.searchFinished = true;
                              },
                              focusNode: focuseNode,
                              style: TextStyle(fontSize: 16),
                              controller: searchText,
                              decoration: InputDecoration(
                               hintText: "search",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              onChanged: (value){
                                if(value.isNotEmpty)
                                model.searchProductByName(value);
                                else
                                  model.products.clear();
                                model.searchFinished=false;
                              },
                            ),
                          ),
                          IconButton(onPressed: (){
                            focuseNode.unfocus();
                            searchText.text = "";
                          },icon:Icon(Icons.close), color: Colors.black),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      )),
                  SizedBox(height: 10,),
                 (!model.searchFinished)
                  ?AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    child: ListView.builder(
                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context,index){
                       return ListTile(
                           title: Text(model.products[index].name),
                         onTap: (){
                             searchText.text = model.products[index].name;
                             focuseNode.unfocus();
                             model.searchFinished = true;
                         },
                       );
                     },itemCount: model.products.length,),
                  ) :
                 Expanded(
                   child: AnimatedContainer(
                       color:Colors.white,
                       duration: Duration(milliseconds: 500),
                         child: NotificationListener<ScrollNotification>(
                           onNotification: (scrollNotification){
                             if(scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent){
                               _fetchMoreProducts();
                              }
                             return false;
                           },

                           child: GridView.builder(
                               gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                                 childAspectRatio:
                                 (itemWidth / itemHeight),
                                 crossAxisSpacing: 10,
                                 mainAxisSpacing: 4,
                                 crossAxisCount: 2,
                               ),
                               padding: EdgeInsets.all(8),
                               itemCount: model.products.length,
                               itemBuilder: (context, index) {
                                 return Widgets()
                                     .productRow(
                                     model.products[index],onAddCart: (){
//                                                  Provider.of<ShoppingCartProvider>(context,listen: false)
//                                                      .addProduct(model.products[index], null);
                                 });
                               }),
                         )),
                 ),

                  AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height:(model.waitForNextRequest)?55:0,
                      color: Colors.transparent,
                      child: Center(child:CircularProgressIndicator(valueColor:
                      AlwaysStoppedAnimation(LightColor.hightcoffee),)))

                ],
              ),
            ),
          );
        });
  }

  _fetchMoreProducts() async {
    if(searchModel.hasMorePosts==false)
      return;

    if (searchModel.waitForNextRequest) {
      return;
    }

    searchModel.waitForNextRequest = true;
    await searchModel.fetchMore(searchText.text);
    searchModel.waitForNextRequest = false;

  }

}
