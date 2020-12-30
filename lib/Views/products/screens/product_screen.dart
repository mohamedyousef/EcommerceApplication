import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Views/ShoppingCart/widgets/widgets.dart';
import 'package:ecommerceApp/Views/photoGallery/model/photo_model.dart';
import 'package:ecommerceApp/Views/products/model/product_view.dart';
import 'package:ecommerceApp/Views/products/widget/widget.dart';
import 'package:ecommerceApp/Widgets/product/sliver_tab_delegate.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'file:///D:/MyWork/Work/programming/APPS/Ecommerce%20App/code/ecommerceApp/lib/Views/products/screens/pages/reviews/reviews_comment_page.dart';

class ProductDetails extends StatefulWidget {
  Product product;

  ProductDetails(this.product);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {

  ProductViewModel _productViewModel = ProductViewModel();
  PageController pageController;
  TabController _tabController;
  List<Widget> pages;


  @override
  void initState() {
    super.initState();
    print(widget.product.id);
    pages = [detailPage(),
      TableDimensions("${(_productViewModel.variation==null)?widget.product.weight:
    _productViewModel.variation.weight}"
        ,(_productViewModel.variation!=null)?_productViewModel.variation.dimensions:widget.product.dimensions),
      ReviewsAndCommentPage(widget.product)];

    pageController = PageController(initialPage: 0);
    _tabController = TabController(vsync: this, length: 3);

    Future.delayed(Duration(milliseconds: 550,),(){
      DataOP().insertItemToRecentView(widget.product);
    });


    // add list of varaiton  to images
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
        onModelReady: (model) => model.init(widget.product),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.grey.shade50,
              appBar: AppBar(
                elevation: 1,
                title: Text("Back"),
                actions: <Widget>[
                  favoriteHart(widget.product),
                  ShoppingCartIcon()
                ],
              ),
              floatingActionButton: _flotingButton(),
              body: (!model.isBusy)
                  ? SafeArea(
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate([
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(widget.product.name,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTheme.h2Style
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              ((model.settingsServices.userSettings!=null)?
                                              model.settingsServices.userSettings.currency=="USD":"")? "\$":"" +
                                                  ((widget.product.variations
                                                          .isEmpty)
                                                      ? widget.product
                                                          .getPrice()
                                                      : (model.variation !=
                                                              null)
                                                          ? model.variation
                                                              .getPrice()
                                                          : "")+" ${model.settingsServices.userSettings.currency}",
                                              style: TextStyle(
                                                  color: LightColor.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                              "${widget.product.ratingCount} ratings"),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          RatingBarIndicator(
                                            rating: double.parse(widget.product.averageRating),
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: LightColor.yellowColor
                                                  .withAlpha(200),
                                            ),
                                            itemCount: 5,
                                            itemSize: 20.5,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              _productImage(),
                            ]),
                          ),
                          SliverPersistentHeader(
                            delegate: SliverAppBarDelegate(TabBar(
                              controller: _tabController,
                              tabs: <Widget>[
                                Tab(
                                  text: "Details",
                                ),
                                Tab(
                                  text: "Shipping",
                                ),
                                Tab(
                                  text: "Reviews",
                                ),
                              ],
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelStyle: GoogleFonts.lato().copyWith(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              //TextStyle(fontSize: 16,fontFamily: ),
                              unselectedLabelColor: Colors.black45,
                              indicatorColor: LightColor.black,
                              indicatorWeight: 2.5,
                              onTap: (value) => model.pageIndex = value,

//                              onTap: (value)=>pageController.animateToPage(value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
                            )),
                            pinned: true,
                          ),
                          SliverFillRemaining(
                            hasScrollBody: false,
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
                          )
                        ],
                      ),
                    )
                  : SizedBox.expand(
                      child: Center(
                          child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(LightColor.midlightcoffee),
                    ))),
            ),
        viewModelBuilder: () => _productViewModel);
  }

  Widget _productImage() {
    return Container(
      height: 268,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 240,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (BuildContext context, int index) {
                return (_productViewModel.images != null &&
                        _productViewModel.images.isEmpty)
                    ? Image.asset(
                        "assets/images/nf2.png",
                        fit: BoxFit.cover,
                      )
                    : InkWell(
                  onTap: ()=>_productViewModel.navigationService.navigateTo(PhotoGallery
                      ,arguments:PhotoModel(_productViewModel.images,index,widget.product.name)),
                      child: CachedNetworkImage(
                          imageUrl: _productViewModel.images[index].src,
                          fit: BoxFit.contain,
                          height: 240,
                        ),
                    );
              },
              onPageChanged: (value) {
                _productViewModel.index = value;
              },
              itemCount: _productViewModel.images.length,
            ),
          ),
          _indicator()
        ],
      ),
    );
  }

  Widget _indicator() {
    int indxes = (_productViewModel.images.length > 7)
        ? 8
        : _productViewModel.images.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int index = 0; index < indxes; index++)
          Container(
            width: 8.0,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _productViewModel.index == index
                  ? Color.fromRGBO(0, 0, 0, 1)
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          )
      ],
    );
  }

  void selectVariation(DefaultAttribute defaultAttribute) {
    _productViewModel.addToSelected(defaultAttribute);
    _productViewModel.getVariation();
    if (_productViewModel.variation != null) {
      int index = _productViewModel.images.indexWhere(
          (element) => element.id == _productViewModel.variation.image.id);

      _productViewModel.index = index;
      pageController.jumpToPage(index);
    }
  }

  FloatingActionButton _flotingButton() {
    return FloatingActionButton(
      heroTag: "floatingActions",
      onPressed: () {
        Provider.of<ShoppingCartProvider>(context, listen: false)
            .addProduct(widget.product, _productViewModel.variation);
      },
      backgroundColor: LightColor.lightcoffee,
      child: Icon(Icons.add_shopping_cart, color: Colors.black),
    );
  }

  Widget detailPage() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          for (var item in widget.product.attributes)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
                  child: Text(
                    "${item.name}",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                AttributeView(item, (data) {
                  selectVariation(data);
                }),
              ],
            ),
          // short desc
          ExpansionTile(
            backgroundColor: Colors.white,
            title: Text("Short Description"),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                   widget.product.shortDescription,
                ),
              ),

            ],
          ),
          // desc
          SizedBox(height: 10),

          ExpansionTile(
            backgroundColor: Colors.white,
            title: Text("Description"),
            children: <Widget>[
              HtmlWidget(
                  widget.product.description,
              ),
            ],
          ),
//
//          ExpansionTile(
//            backgroundColor: Colors.white,
//            title: Text("Diemensions"),
//            children: <Widget>[
//              TableDimensions((_productViewModel.variation!=null)?_productViewModel.variation.dimensions:widget.product.dimensions)
//            ],
//          ),
        ],
      ),
    );
  }


}



