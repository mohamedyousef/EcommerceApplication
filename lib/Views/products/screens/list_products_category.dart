import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/Views/ShoppingCart/widgets/widgets.dart';
import 'package:ecommerceApp/Views/products/model/products_view_model.dart';
import 'package:ecommerceApp/Views/products/widget/filter_widget.dart';
import 'package:ecommerceApp/Views/search/screens/search_screen.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/providers/filte_search_provider.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
class ListProductsByCategory extends StatefulWidget {

  Category category;
  ListProductsByCategory(this.category);

  @override
  _ListProductsByCategoryState createState() => _ListProductsByCategoryState();
}

class _ListProductsByCategoryState extends State<ListProductsByCategory> with SingleTickerProviderStateMixin{
  FilterSearchProvider provider;
  Widgets widgets = Widgets();
  AnimationController animationController;
  ProductsModel prodcut = ProductsModel();
  bool state = false;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void handleAnimationIcon() {
    setState(() {
      state = !state;
      state ? animationController.forward() : animationController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();



    Future.delayed(Duration.zero,(){
      _fetchMoreProducts();
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<FilterSearchProvider>(context);
    var size = MediaQuery.of(context).size;
    final double itemHeight = 353.7;
    final double itemWidth = size.width / 2;

    return ViewModelBuilder<ProductsModel>.reactive(
      //model.requestLoadMore(
//            filter: "category=" + widget.category.id.toString()),
//            model.listenToProducts("category=" + widget.category.id.toString()),
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Colors.grey.shade50,
              floatingActionButton: AnimatedOpacity(
                duration: Duration(milliseconds: 800),

                opacity: (state)?0:1,
                child: FloatingActionButton(
                  backgroundColor: LightColor.lightcoffee,
                  onPressed: () {
                    model.navigationService.navigateTo(SearchRoute);
                  },
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              appBar: AppBar(
                actions: <Widget>[
                  ShoppingCartIcon(),
                  IconButton(
                    onPressed: () {
                      handleAnimationIcon();
                    },
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: animationController,
                      color: Colors.black,
                    ),
                  ),
                ],
                brightness: Brightness.light,
                elevation: 0,
                backgroundColor: Colors.white,
                title: AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),

                  secondChild:  Text("Filter", style: TextStyle(color: Colors.black))
                  ,firstChild:Text(
                  "Products",
                  style: TextStyle(color: Colors.black),
                ), crossFadeState:(state)?CrossFadeState.showSecond:CrossFadeState.showFirst,
                ),
                leading: IconButton(
                    onPressed: () => model.navigationService.goBack(),
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                      size: 32,
                    )),
              ),
              body: Stack(
                children: <Widget>[

                  //    if(model.waitForNextRequest==false)
                  AnimatedOpacity(
                    opacity: (state) ? 0 : 1,
                    duration: Duration(milliseconds: 500),
                    child:
                         SmartRefresher(
                           controller: _refreshController,
                           header: ClassicHeader(),
                           footer: ClassicFooter(),
                           onRefresh: () async {
                             await  _fetchMoreProducts();
                             _refreshController.refreshCompleted();
                           },
                           onLoading: () async {
                             await  _fetchMoreProducts() ;
                             _refreshController.loadComplete();
                           },
                           child: GridView.builder(
                               gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                                 childAspectRatio:
                                 (itemWidth / itemHeight),
                                 crossAxisSpacing: 4,
                                 mainAxisSpacing: 4,
                                 crossAxisCount: 2,
                               ),
                               padding: EdgeInsets.all(8),
                               itemCount: model.products.length,
                               itemBuilder: (context, index) {
                                 return widgets.drawItemHorizontalVerison2(
                                     model.products[index],onAddCart: (){
//                                                  Provider.of<ShoppingCartProvider>(context,listen: false)
//                                                      .addProduct(model.products[index], null);
                                 });
                               }),
                         )),

                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: (state) ? ScreenUtils.screenHeight(context,size: 0.80) : 0,
                    child: FilterWidget((){
                      model.applyFilter(
                          filter:"category= "+widget.category.id
                              .toString()
                              +"&"+
                              //      "${(provider.onSale)?"on_sale = ${provider.onSale}":""}& ${(provider.featured)?"featured = ${provider.featured}":""}"+
                              "${(provider.startPrice==0&&provider.endPrice==100000)?"":
                              "& min_price=${provider.startPrice} & max_price=${provider.endPrice}"}"
                        //  ,total_sales: provider.popular,
                        //  ratings: provider.averageRating

                      );
                      handleAnimationIcon();
                    }),
                  ),

                ],
              )
          );
        },
        viewModelBuilder: () => prodcut);

//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.category),
//        leading: IconButton(
//          icon: Icon(CupertinoIcons.left_chevron),
//          onPressed: (){
//            Navigator.pop(context);
//          },
//        ),
//      ),
//      body: Container(
//
//      ),
//    );
  }


  _fetchMoreProducts() async {
    if(prodcut.hasMorePosts==false)
      return;

    if (prodcut.waitForNextRequest) {
      return;
    }

    prodcut.waitForNextRequest = true;
    await prodcut.requestLoadMore(filter:"category= "+ widget.category.id.toString()  +"&"+
       "${(provider.selectedSort==2)?"on_sale = true":(provider.selectedSort==3)?"featured = true":""}"+
        "${(provider.startPrice==0&&provider.endPrice==100000)?"":
       "& min_price=${provider.startPrice} & max_price=${provider.endPrice}"}"
    );
    prodcut.waitForNextRequest = false;
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
