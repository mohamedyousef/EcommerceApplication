import 'package:ecommerceApp/Views/products/widget/filter_widget.dart';
import 'package:ecommerceApp/Views/search/models/search_view_model.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/providers/filte_search_provider.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController searchText = TextEditingController();
  FocusNode focuseNode = FocusNode();
  SearchViewModel searchModel = SearchViewModel();
  Widgets widgets = Widgets();
  RefreshController _refreshController = RefreshController();
  bool state = false;

  AnimationController animationController;
  FilterSearchProvider provider;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    searchText.dispose();
    _refreshController.dispose();
    focuseNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<FilterSearchProvider>(context);
    var size = MediaQuery.of(context).size;

    final double itemHeight = 358.7;
    final double itemWidth = size.width / 2;

    return ViewModelBuilder<SearchViewModel>.reactive(
        viewModelBuilder: () => searchModel,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                 state ? null :Icons.close,
                 ),
                onPressed: () => model.navigationService.goBack(),
              ),
              centerTitle: true,
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(55),
                child:AnimatedOpacity(
                  opacity: state?0:1,
                  duration: Duration(milliseconds: 500),
                  child: AbsorbPointer(
                    absorbing: state,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(25),
                          color: Colors.grey.shade100,
                        ),
                        child: TextField(
                          onSubmitted: (value) {
                            searchText.text = value;
                            focuseNode.unfocus();
                            model.searchFinished = true;
                          },
                          focusNode: focuseNode,
                          style: TextStyle(fontSize: 16),
                          controller: searchText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  focuseNode.unfocus();
                                  searchText.text = "";
                                },
                                icon: Icon(Icons.close),
                                color: Colors.black),
                            prefixIcon:
                                Icon(Icons.search, color: Colors.black),
                            hintText: "search",
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 25,vertical: 15),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty)
                              model.searchProductByName(value);
                            else
                              model.products.clear();
                            model.searchFinished = false;
                          },
                        )),
                  ),
                ),
              ),
              title: AnimatedCrossFade(
                duration: Duration(milliseconds: 300),
                secondChild:
                    Text("Filter", style: TextStyle(color: Colors.black)),
                firstChild: Text(
                  "Search",
                  style: TextStyle(color: Colors.black),
                ),
                crossFadeState: (state)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IconButton(
                    onPressed: () {
                      handleAnimationIcon();
                    },
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: animationController,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
              backgroundColor: Colors.transparent
            ),
            body: Container(
              color:Colors.white24,
              padding: const EdgeInsets.all(4.0),
              margin: EdgeInsets.only(
                top: 10
              ),
              child: Stack(
                children: <Widget>[
                  (!model.searchFinished)
                      ? AnimatedContainer(
                           duration: Duration(milliseconds: 400),
                           child: ListView.builder(
                             itemBuilder: (context, index) {
                               return ListTile(
                                 title: Text(model.products[index].name),
                                 onTap: () {
                                   searchText.text = model.products[index].name;
                                   focuseNode.unfocus();
                                   model.searchFinished = true;
                                 },
                               );
                             },
                             itemCount: model.products.length,
                           ),
                         )
                      : AnimatedOpacity(
                          opacity: (state) ? 0 : 1,
                          duration: Duration(milliseconds: 500),
                          child: SmartRefresher(
                            controller: _refreshController,
                            header: ClassicHeader(),
                            footer: ClassicFooter(),
                            onRefresh: () async {
                              await _fetchMoreProducts();
                              _refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await _fetchMoreProducts();
                              _refreshController.loadComplete();
                            },
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: (itemWidth / itemHeight),
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  crossAxisCount: 2,
                                ),
                                padding: EdgeInsets.all(8),
                                itemCount: model.products.length,
                                itemBuilder: (context, index) {
                                  return widgets.drawItemHorizontalVerison2(
                                      model.products[index], onAddCart: () {
//                                                  Provider.of<ShoppingCartProvider>(context,listen: false)
//                                                      .addProduct(model.products[index], null);
                                  });
                                }),
                          )),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: (state)
                        ? ScreenUtils.screenHeight(context, size: 0.80)
                        : 0,
                    child: FilterWidget(() {
                      model.applyFilter(
                          filter: "${(provider.selectedSort == 2) ? "on_sale = true" : (provider.selectedSort == 3) ? "featured = true" : ""}" +
                              "${(provider.startPrice == 0 && provider.endPrice == 100000) ? "" : "& min_price=${provider.startPrice} & max_price=${provider.endPrice}"} & "
                                  "${(provider.id > -1) ? "attribute=pa_${provider.attributeItems.singleWhere((element) => element.id == provider.id).name.toLowerCase()}&attribute_term=${provider.getAttributesIds()}" : ""}" //  ,total_sales: provider.popular,
                          //  ratings: provider.averageRating

                          );
                      handleAnimationIcon();
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _fetchMoreProducts() async {
    if (searchModel.hasMorePosts == false) return;

    if (searchModel.waitForNextRequest) {
      return;
    }

    searchModel.waitForNextRequest = true;
    await searchModel.fetchMore(searchText.text,
        filter: "${(provider.selectedSort == 2) ? "on_sale = true" : (provider.selectedSort == 3) ? "featured = true" : ""}" +
            "${(provider.startPrice == 0 && provider.endPrice == 100000) ? "" : "& min_price=${provider.startPrice} & max_price=${provider.endPrice}"} & "
                "${(provider.id > -1) ? "attribute=pa_${provider.attributeItems.singleWhere((element) => element.id == provider.id).name.toLowerCase()}&attribute_term=${provider.getAttributesIds()}" : ""}");
    searchModel.waitForNextRequest = false;
  }

  void handleAnimationIcon() {
    setState(() {
      state = !state;
      state ? animationController.forward() : animationController.reverse();
    });

  }
}
