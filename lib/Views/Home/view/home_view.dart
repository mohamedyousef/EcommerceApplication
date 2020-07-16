import 'package:animations/animations.dart';
import 'package:async/async.dart';
import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/blog/blog_service.dart';
import 'package:ecommerceApp/Views/Home/model/view_model.dart';
import 'package:ecommerceApp/Views/Home/view/explore_page.dart';
import 'package:ecommerceApp/Views/ShoppingCart/widgets/widgets.dart';
import 'package:ecommerceApp/Views/blog/widgets/widgets.dart';
import 'file:///D:/MyWork/Work/programming/APPS/Ecommerce%20App/code/ecommerceApp/lib/Views/Categories/models/cateogires_model.dart';
import 'package:ecommerceApp/Widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'profile_screen.dart';
import 'package:ecommerceApp/Views/wishlist/screens/wishlist_main_view.dart';
import 'package:ecommerceApp/Views/products/widget/list_horizontal_products.dart';

class HomeView extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 // AsyncMemoizer asyncMemoizer = AsyncMemoizer();

  List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    pages = [HomePage(), ExplorePage(), WishListHomeView(), ProfileScreen()];
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model)=>model.settings(),
        builder: (context, model, child) {
          return StreamBuilder<User>(
              stream: model.ListentToUser(),
              builder: (context, AsyncSnapshot<User> snapshot) {
                return Scaffold(
                    key: _scaffoldKey,
                    backgroundColor: LightColor.background,
                    bottomNavigationBar: CustomBottomNavigationBar(
                      onIconPresedCallback: (value) {
                        model.index = value;
                      },
                    ),
                    appBar:(model.index==3)?AppBar(
                      brightness: Brightness.light,
                      elevation:  0,
                      backgroundColor: Colors.white,
                      title: Text("Profile",style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                      leading: IconButton(
                        icon: Icon(
                          Icons.sort,
                          color: Colors.black,
                        ),
                        onPressed: () => _scaffoldKey.currentState.openDrawer(),
                      ),
                    ):AppBar(
                      brightness: Brightness.light,
                      elevation:  0,
                      backgroundColor:(model.index==2)?Colors.white:Colors.white,
                      centerTitle: true,
                      actions: <Widget>[
                        ShoppingCartIcon(),
                        RotatedBox(
                            quarterTurns: 1,
                            child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, SearchRoute);
                                })),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                      title: Text(title(model.index),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      leading: IconButton(
                        icon: Icon(
                          Icons.sort,
                          color: Colors.black,
                        ),
                        onPressed: () => _scaffoldKey.currentState.openDrawer(),
                      ),
                    ),
                    drawer: drawer(snapshot.data, snapshot.data != null),
                    body: PageTransitionSwitcher(
                      duration: Duration(milliseconds: 600),
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
                      child: pages[model.index],
                    ));
              });
        },
        // onModelReady:(model)=>model.getProducts(),
        viewModelBuilder: () => HomeViewModel());
  }



  String title(int index) {
    if (index == 0)
      return "Home";
    else if (index == 2)
      return "WISHLIST";
    else
      return "Explore";
  }

  Widget drawer(User user, bool isLoggedIN) { 
    NavigationService _navigationService = locator<NavigationService>();
    
    return Drawer(
      elevation: 1,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 6,
                ),
                if (user != null&&user.avatarUrl!=null&&user.avatarUrl.isNotEmpty)
                  photoUrl(user.avatarUrl)
                else
                  photoAssets(
                    "assets/images/nf2.png",
                    width: 100,
                    height: 100,
                  ),
                SizedBox(
                  width: 6,
                ),
                if (user != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.getFullName().toUpperCase(),
                          style: AppTheme.titleStyle.copyWith(color:Colors.black,fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          user.email,
                          style: AppTheme.subTitleStyle,
                        )
                      ],
                    ),
                  )
                else
                  RawMaterialButton(
                    onPressed: () {
                      locator<NavigationService>().navigateTo(LoginRoute);
                    },
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: LightColor.black,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Login",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 25,
            ),
            FlatButton(
              onPressed: (){},
              child: Container(
                width: double.infinity,
                  margin: EdgeInsets.only( top: 10, bottom: 10),
                  child: Text(
                    "Home",
                    style:
                        AppTheme.h3Style.copyWith(fontWeight: FontWeight.bold),
                  )),
            ),
            FlatButton(
              onPressed: (){},
              child: Container(
                width: double.infinity,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Explore",
                    style:
                        AppTheme.h3Style.copyWith(fontWeight: FontWeight.bold),
                  )),
            ),
            FlatButton(
            onPressed: ()=>_navigationService.navigateTo(BlogRoute),
              child: Container(
                width: double.infinity,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("Blog",
                    style:
                    AppTheme.h3Style.copyWith(fontWeight: FontWeight.bold),
                  )),
            ),


            Expanded(child: Container(),),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: (){},
                      elevation: 0,
                      fillColor: Colors.black,
                      child:Text("Settings",style: TextStyle(color:Colors.white),),
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18)
      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                        onPressed: (){
                           locator<AuthenticationService>().logout();
                        },
                        borderSide: BorderSide(
                          color: Colors.black
                        ),
                        child:Text("Sign Out")
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 21,),

          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  BlogService _blogService = locator<BlogService>();
  Api  api =  locator<Api>();

  int count = 0 ;

 HomePage(){
   countRecent();
 }

  void countRecent()async{
      count = await DataOP().countRecent();
      print(count);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.grey.shade50,
      child: CustomScrollView(
        slivers: <Widget>[
          ViewModelBuilder<CategoriesViewModel>.reactive(
            builder: (context, model, child) {
              return SliverList(
                delegate: new SliverChildListDelegate([
                  SizedBox(
                      height: 300,
                      child: AnimatedSwitcher(
                          switchInCurve: Curves.easeInOut,
                          duration: Duration(seconds: 1),
                          child: (!model.isBusy)
                              ? Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Widgets().categoryBannerCarousel(
                                  model.data[index]);
                            },
                            viewportFraction: 1,
                            scale: 1,
                            itemCount: 3,
                            pagination: new SwiperCustomPagination(builder:
                                (BuildContext context,
                                SwiperPluginConfig config) {
                              return new ConstrainedBox(
                                child: new Container(
                                  alignment: Alignment.bottomCenter,
                                  child: new DotSwiperPaginationBuilder(
                                      color: Colors.grey.shade700,
                                      activeColor: Colors.grey.shade100,
                                      size: 8.0,
                                      activeSize: 10.0)
                                      .build(context, config),
                                ),
                                constraints: new BoxConstraints.expand(
                                    height: double.infinity),
                              );
                            }),
//                           control: new SwiperControl(
//                               color: Colors.black,
//                           ),
                            loop: false,
                          )
                              : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    LightColor.lightcoffee),
                              )))),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8.8, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: LightColor.black),
                        ),
                        FlatButton(
                            onPressed: () {
                              model.navigationService.navigateTo(ViewAllCats);
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                decoration: TextDecoration.underline,

                                   decorationStyle: TextDecorationStyle.dashed,
                                  color: ColorsStyles.greenHole2, fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                  if (!model.isBusy)
                    Container(
                      height: 100,
                      margin: EdgeInsets.symmetric(vertical: 2),
                      width: AppTheme.fullWidth(context),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: model.data
                        //.getRange(3, model.data.length)
                            .map((e) => Widgets().categoryAfterBanner(e))
                            .toList(),
                      ),
                    ) ,
                  SizedBox(height: 8,),


                  if(count>0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Recent View",style: AppTheme.h3Style.copyWith(fontWeight: FontWeight.bold,
                        color: Colors.black),),
                  ),
                  if(count>0)
                    StreamBuilder(builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                    if(snapshot.hasData)
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.white54,
                          height: 290,
                          child: ListHorizontalProducts(snapshot.data,true));
                    return Container();
                  },
                  stream: DataOP().getRecentView(),),
                  SizedBox(height: 8,),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Best Products ",style: AppTheme.h3Style.copyWith(fontWeight: FontWeight.bold,
                        color: Colors.black),),
                  ),
                  FutureBuilder(builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                    if(snapshot.hasData)
                      return Container(
                          color: Colors.white54,
                          height: 300,child: ListHorizontalProducts(snapshot.data,true));
                    return Container();
                  },
                    future: api.getProducts(limit: 10,filter:""),),
                  SizedBox(height: 8,),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10.8, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Our Blog Posts",
                          style:AppTheme.h3Style.copyWith(fontWeight: FontWeight.bold),
                        ),
                        FlatButton(
                            onPressed: () {
                              model.navigationService.navigateTo(BlogRoute);
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dashed,
                                  color: ColorsStyles.greenHole2, fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                  FutureBuilder(builder: (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                LightColor.lightcoffee
                            ),
                          ),
                        );
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if(snapshot.hasData)
                        return Container(
                          color: Colors.white54,
                          child: Column(
                            children: <Widget>[
                              for(var item in snapshot.data)
                                PostWidget(item)
                            ],
                          ),
                        );
                        break;
                    }
                    return Container();
                  },
                    future:  _blogService.getPosts(),
                  ),


                  SizedBox(height: ScreenUtils.screenHeight(context,size:0.05),),
                ]),
              );
            },
            viewModelBuilder: () => CategoriesViewModel(),
          ),
        ],
      ),
    );
  }
}

