import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/Services/category_services.dart';
import 'package:ecommerceApp/Views/ShoppingCart/widgets/widgets.dart';
import 'package:ecommerceApp/Views/products/model/products_view_model.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/providers/filte_search_provider.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Views/products/widget/filter_widget.dart';
import '../../../locator.dart';

class ListProducts extends StatefulWidget {
  Category category;

  ListProducts(this.category);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts>
    with TickerProviderStateMixin {

  ProductsModel prodcut = ProductsModel();
  PageController _pageController;
  TabController _tabController;
  AnimationController animationController;
  CategoryServices categoryServices = locator<CategoryServices>();
  FilterSearchProvider provider;

  bool state = false;

  List<Category> listToCategories(int id) {
    List<Category> cats = categoryServices.categoires
        .where((element) => element.parent == id)
        .toList();

    return cats;
  }

  List<Category> categoires;
  int counts = 0;
  Widgets widgets ;

  @override
  void initState() {
    super.initState();
    categoires = listToCategories(widget.category.id);
    widgets = Widgets();

    Future.delayed(Duration.zero,(){
      _fetchMoreProducts();
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _pageController = PageController(initialPage: 0);
    _tabController = TabController(vsync: this, initialIndex: 0, length: categoires.length);
//    if (categoires.isNotEmpty)
//      for (var item in categoires) counts += item.count;
//    else
//      counts = widget.category.count;
  }

  void handleAnimationIcon() {
    setState(() {
      state = !state;
      state ? animationController.forward() : animationController.reverse();
    });
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
              backgroundColor: Colors.grey.shade200,
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
                bottom: (!state)
                    ? TabBar(
                        controller: _tabController,
                        tabs: <Widget>[
                          for (var item in categoires)
                            Tab(
                              text: item.name +
                                  ((item.count != null)
                                      ? " (${item.count})"
                                      : ""),
                            )
                        ],
                        indicatorColor: Colors.transparent,
                        unselectedLabelColor: Colors.black45,
                        labelColor: Colors.black,
                        labelStyle: AppTheme.titleStyle
                            .copyWith(fontWeight: FontWeight.bold),
                        isScrollable: true,
                        indicator: BoxDecoration(color: Colors.transparent),
                        onTap: (value) => _pageController.animateToPage(value,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut),
                      )
                    : PreferredSize(
                        preferredSize: Size.fromHeight(10), child: Container()),
              ),

              body: Stack(
                children: <Widget>[

               //    if(model.waitForNextRequest==false)
                   AnimatedOpacity(
                     opacity: (state) ? 0 : 1,
                     duration: Duration(milliseconds: 500),
                     child: PageView.builder(
                       controller: _pageController,
                       itemBuilder: (context, index) {
                         return NotificationListener<ScrollNotification>(
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
                         );
                       },
                       itemCount: (categoires.isNotEmpty)
                           ? categoires.length
                           : 1,

                       onPageChanged: (value) {
                         _tabController.animateTo(value,
                             duration: Duration(milliseconds: 400));
                         model.products.clear();
                         model.page = 1;
                         model.hasMorePosts = true;
                         model.categoryID= categoires[value].id;
                         _fetchMoreProducts();
                       },
                     ),
                   ),

                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: (state) ? ScreenUtils.screenHeight(context,size: 0.85) : 0,
                    child: FilterWidget((){
                      model.applyFilter(
                          filter:
                          "category= "+((prodcut.categoryID==null)?(categoires.isEmpty)?widget.category.id.toString()
                              :categoires[0].id.toString():prodcut.categoryID.toString())
                              +"&"+
                              "${(provider.selectedSort==2)?"on_sale = true":(provider.selectedSort==3)?"featured = true":""}"+
                              "${(provider.startPrice==0&&provider.endPrice==100000)?"": "& min_price=${provider.startPrice} & max_price=${provider.endPrice}"} & "
                                  "${
                                  (provider.id>-1) ? "attribute=pa_${provider.attributeItems.singleWhere((element) => element.id == provider.id).name.toLowerCase()}&attribute_term=${provider.getAttributesIds()}"
                                      :""
                              }"


                      );
                      handleAnimationIcon();
                    }),
                  ),
//                  if(model.products.isNotEmpty)
//                    Positioned(
//                      left: 0,right: 0,
//                      bottom: 0,
//                      child: AnimatedContainer(duration: Duration(milliseconds: 500),
//                           height:(model.waitForNextRequest)?55:0,
//                           color: Colors.transparent,
//                           child: Center(child:CircularProgressIndicator(valueColor:
//                           AlwaysStoppedAnimation(LightColor.midlightcoffee),))),
//                    )
                ],
              )
          );
        },
        viewModelBuilder: () => prodcut);
  }


  _fetchMoreProducts() async {
    if(prodcut.hasMorePosts==false)
      return;

    if (prodcut.waitForNextRequest) {
      return;
    }

    prodcut.waitForNextRequest = true;
    await prodcut.requestLoadMore(
        filter:
        "category= "+((prodcut.categoryID==null)?(categoires.isEmpty)?widget.category.id.toString()
        :categoires[0].id.toString():prodcut.categoryID.toString())
        +"&"+
        "${(provider.selectedSort==2)?"on_sale = true":(provider.selectedSort==3)?"featured = true":""}"+
    "${(provider.startPrice==0&&provider.endPrice==100000)?"": "& min_price=${provider.startPrice} & max_price=${provider.endPrice}"} & "
    "${
        (provider.id>-1) ? "attribute=pa_${provider.attributeItems.singleWhere((element) => element.id == provider.id).name.toLowerCase()}&attribute_term=${provider.getAttributesIds()}"
    :""
    }"


);
    prodcut.waitForNextRequest = false;
  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
    animationController.dispose();
  }
}
