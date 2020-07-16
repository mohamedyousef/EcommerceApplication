import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:ecommerceApp/Helper/my_flutter_app_icons.dart';
import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/Services/category_services.dart';
import 'package:ecommerceApp/Views/products/model/products_view_model.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Widgets/product/sliver_tab_delegate.dart';
import '../../../locator.dart';

class ProductsScreen extends StatefulWidget {
  Category category;

  ProductsScreen(this.category);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SingleTickerProviderStateMixin {

  ProductsModel prodcut = ProductsModel();
  PageController _pageController;
  TabController _tabController;
  CategoryServices categoryServices = locator<CategoryServices>();
  List<Category> listToCategories(int id){
    List<Category> cats=  categoryServices.categoires.where((element) => element.parent==id).toList();
    print(cats);
    return cats;
  }
  List<Category> categoires ;

  @override
  void initState() {
    super.initState();
    categoires = listToCategories(widget.category.id);
    categoires.insert(0, Category(name: "Everything"));

    _pageController = PageController(initialPage: 0);
    _tabController = TabController(
        vsync: this,
        initialIndex: 0,
        length: categoires.length);
  }

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<ProductsModel>.reactive(
        onModelReady: (model) => model.requestLoadMore(filter: "category="+widget.category.id.toString()),
//            model.listenToProducts("category=" + widget.category.id.toString()),
        builder: (context, model, child) {

          return Scaffold(
              backgroundColor: Colors.white,
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    brightness: Brightness.light,
                    floating: false,
                    pinned: true,
                    elevation: 0,
                    title: Text(
                      "Back",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: IconButton(
                        icon: Icon(CupertinoIcons.left_chevron,
                            size: 32, color: Colors.black),
                        onPressed: () {
                          model.navigationService.goBack();
                        }),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      buildRowResturantInfo(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.category.name,
                                    style: AppTheme.h1Style),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("${widget.category.count} items found",
                                    style: AppTheme.subTitleStyle
                                        .copyWith(fontSize: 15)),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                MyFlutterApp
                                    .filter_filters_funnel_list_navigation_sort_sorting_icon_123212,
                                size: 32,
                                color: LightColor.lightblack,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(TabBar(
                      controller: _tabController,
                      tabs: <Widget>[
                        for (var item in categoires)
                          Tab(
                            text: item.name,
                          )
                      ],
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.black45,
                      onTap: (value)=>_pageController.animateToPage(value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
                      indicator: new BubbleTabIndicator(
                        indicatorHeight: 40.5,
                        indicatorColor:LightColor.lightblack,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                    )),
                    pinned: true,
                  ),
                  SliverFillRemaining(
                    child: (model.products != null)
                        ? PageView.builder(
                      controller: _pageController,
                            itemBuilder: (context, index) {
                              return GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                 children: <Widget>[
                                   for(var item in model.products)
                                     Container(color: Colors.lightBlue,child: Text(
                                       item.name
                                     ),),
                                 ],
                              );
                            },
                            itemCount: categoires.length,
                      onPageChanged: (value){
                        _tabController.animateTo(value,duration: Duration(milliseconds: 400));
                        if(value==0)
                          model.requestLoadMore(filter:"category="+widget.category.id.toString());
                          else
                              model.requestLoadMore(filter:"category="+categoires[value].id.toString());
                      },
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  )
                ],
              ));
        },
        viewModelBuilder: () => prodcut);
  }

  Widget buildRowResturantInfo() {
    return SizedBox(
        height: 250,
        child: AnimatedSwitcher(
            switchInCurve: Curves.easeInOut,
            duration: Duration(seconds: 1),
            child: (categoires.length > 2)
                ? Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0)
                        return Widgets().categoryBannerCarouselWithoutCLick(
                            widget.category);
                      else
                        return Widgets().categoryBannerCarouselWithoutCLick(categoires[index]);
                    },
                    viewportFraction: 1,
                    scale: 1,
                    itemCount: 4,
                    pagination: new SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return new ConstrainedBox(
                        child: new Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 25),
                          alignment: Alignment.bottomRight,
                          child: new DotSwiperPaginationBuilder(
                                  color: Colors.grey.shade700,
                                  activeColor: Colors.grey.shade100,
                                  size: 8.0,
                                  activeSize: 10.0)
                              .build(context, config),
                        ),
                        constraints:
                            new BoxConstraints.expand(height: double.infinity),
                      );
                    }),
//                           control: new SwiperControl(
//                               color: Colors.black,
//                           ),
                    loop: false,
                  )
                : (widget.category.image != null)
                    ? Widgets()
                        .categoryBannerCarouselWithoutCLick(widget.category)
                    : Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/nf2.png"),
                                fit: BoxFit.cover)),
                      )));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }
}

//
//ListCats(model.listToCategories(widget.category.id),(value){
//model.index_catIndex = value;
//print(value);
//}

//class ListCats extends StatefulWidget {
//  List<Category> listToCategories;
//
//  ListCats(this.listToCategories, this.valueChanged);
//
//  ValueChanged valueChanged;
//
//  @override
//  _ListCatsState createState() => _ListCatsState();
//}
//
//class _ListCatsState extends State<ListCats> {
//  int active = 0;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    widget.listToCategories.insert(0, null);
//    print("Result:" + widget.listToCategories.toString());
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ListView.builder(
//      scrollDirection: Axis.horizontal,
//      itemBuilder: (context, index) {
//        return InkWell(
//            onTap: () {
//              if (active != index) active = index;
//              widget.valueChanged(active);
//              setState(() {});
//            },
//            child: buttonRow(widget.listToCategories[index], active == index));
//      },
//      itemCount: widget.listToCategories.length,
//    );
//  }
//
////  if(active==0)
//
//  Widget buttonRow(Category category, bool index) {
//    return AnimatedContainer(
//      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//      padding: EdgeInsets.symmetric(horizontal: 20),
//      decoration: BoxDecoration(
//          color: (index) ? LightColor.lightblack : Colors.transparent,
//          borderRadius: BorderRadius.circular(20)),
//      duration: Duration(milliseconds: 200),
//      child: Center(
//          child: Text(
//        (category != null) ? category.name : "Everything",
//        style: TextStyle(
//          color: (index) ? Colors.white : Colors.black45,
//        ),
//      )),
//    );
//  }
//}
