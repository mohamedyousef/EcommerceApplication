import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Models/variation.dart';
import 'package:ecommerceApp/Models/wishlist_models/board.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'file:///D:/MyWork/Work/programming/APPS/Ecommerce%20App/code/ecommerceApp/lib/Views/PaymentProceed/screen/shipping/add_shipping_page.dart';
import 'package:ecommerceApp/Views/ShoppingCart/widgets/widgets.dart';
import 'package:ecommerceApp/Views/products/screens/product_screen.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/Widgets/title_text.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/providers/shopping_cart.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Widgets {

  Api api = locator<Api>();
  NavigationService navigationService = locator<NavigationService>();
  SettingsServices settingsServices = locator<SettingsServices>();
  double rates = 1;

  Widgets() {
    // getRates();
  }

  Future<void> getRates() async {
    //  if(!settingsServices.userSettings.currency.toLowerCase().contains(settingsServices.settings.currency.toLowerCase()))
    //    rates = await convertCurrencyFree(toCurrency: settingsServices.userSettings.currency,fromCurrency: settingsServices.settings.currency);
    //  print(rates);
  }

  Widget categoryBannerCarousel(Category category) {
    return RawMaterialButton(
      onPressed: () {
        navigationService.navigateTo(ProductsRoute, arguments: category);
      },
      elevation: 1,
      child: Container(
        height: 300,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
                child: (category.image == null)
                    ? Image.asset(
                        "assets/images/nf2.png",
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: category.image.src,
                        fit: BoxFit.cover,
                        height: 300,
                      )),
            Positioned.fill(
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
                left: 1,
                right: 1,
                top: 1,
                bottom: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${category.name}",
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${category.desc}",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                )),
            Positioned(
              left: 10,
              bottom: 20,
              child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Shop",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryAfterBanner(Category category) {
    return InkWell(
      onTap: () =>
          navigationService.navigateTo(ProductsRoute, arguments: category),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Container(
            padding: AppTheme.hPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                category.image != null
                    ? CachedNetworkImage(
                        imageUrl: category.image.src,
                        height: 45,
                        width: 55,
                        fit: BoxFit.cover,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 8,
                ),
                category.name == null
                    ? Container()
                    : Container(
                        child: TitleText(
                          text: category.name,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      )
              ],
            ),
          )),
    );
  }

  Widget categoryBannerCarouselWithoutCLick(Category category) {
    return Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: (category.image == null)
                  ? Image.asset(
                      "assets/images/nf2.png",
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: category.image.src,
                      fit: BoxFit.cover,
                      height: 300,
                    )),
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
              left: 1,
              right: 1,
              top: 1,
              bottom: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${category.name}",
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${category.desc}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget categoryExplore(Category category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          navigationService.navigateTo(ProductsRoute, arguments: category);
        },
        child: Container(
          //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          height: 180,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: (category.image == null)
                      ? Image.asset(
                          "assets/images/nf2.png",
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl: category.image.src,
                          fit: BoxFit.cover,
                          height: 180,
                        )),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                  left: 1,
                  right: 1,
                  top: 1,
                  bottom: 1,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${category.name}",
                          style: TextStyle(fontSize: 32, color: Colors.white),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${category.desc}",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget productRow(Product product,
      {double photoheight = 190,double width=160, VoidCallback onAddCart()}) {
    return InkWell(
      onTap: (){
        navigationService.navigateTo(ProductRoute,arguments: product);
      },
      child: Container(
   //   height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: photoheight,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: photoUrlWithoutBorder((product.images.isNotEmpty)?product.images[0].src:"",
                          boxFit: BoxFit.cover)),
                  if (product.onSale && product.variations.isEmpty)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10))),
                          child: Center(
                              child: Text(
                            "${product.getPercentage()}% OFF",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                    )
                  else
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10))),
                          child: Center(
                              child: Text(
                            "On Sale",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "${product.name}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.titleStyle.copyWith(fontWeight: FontWeight.bold,),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                if (product.variations != null && product.variations.isEmpty)
                  Text(
                    "${product.getPrice()} ${(settingsServices.settings!=null)?settingsServices.settings.currency:""}",
                    style: AppTheme.titleStyle.copyWith(
                        fontSize: 15,
                        color: LightColor.green_deep,
                        fontWeight: FontWeight.bold),
                  ),
                SizedBox(
                  width: 8,
                ),
                if (product.onSale && product.variations.isEmpty)
                  Text(
                    "${product.regularPrice} ${(settingsServices.settings != null) ? settingsServices.settings.currency : ""}",
                    style: AppTheme.subTitleStyle.copyWith(
                        color: LightColor.grey,
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough),
                  ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            //if(product.stockStatus)
            Text(
              "${product.stockStatus}",
              style: TextStyle(fontSize: 13, color: LightColor.green_deep),
            ),
            SizedBox(
              height: 4,
            ),
            if (product.ratingCount > 0)
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                RatingBarIndicator(
                  rating: double.parse(product.averageRating),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  itemCount: 5,
                  itemSize: 15,
                  direction: Axis.horizontal,
                ),
                SizedBox(width: 8,),
                if (product.ratingCount != null)
                  Text("(" + product.ratingCount.toString() + ")",style: AppTheme.subTitleStyle,),
              ]),
          ],
        ),
      ),
    );
  }


  Widget drawItemHorizontalVerison2(Product product,
      {VoidCallback onAddCart(), VoidCallback onBuyPressed()}) {
    String photo = product.images[0].src;

    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (BuildContext _, VoidCallback openContainer) {
        return ProductDetails(product);
      },
      tappable: false,
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      closedElevation: 1.0,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return RawMaterialButton(
          elevation: 1,
          fillColor: Colors.white,
          splashColor: LightColor.verylightcoffee,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () => openContainer(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //    if (double.parse(product.averageRating)>0)
              photoUrlWithoutBorder(photo, height: 130),
              if (product.onSale && product.variations.isEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 20,
                      width: 85,
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        "${product.getPercentage()}% OFF ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))),
                )
              else
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 20,
                      width: 85,
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        "On Sale",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ))),
                ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        product.name,
                        style: AppTheme.h3Style,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    favoriteHart(product),
                  ],
                ),
              ),
              if (product.ratingCount > 0)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(children: <Widget>[
                    RatingBarIndicator(
                      rating: double.parse(product.averageRating),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.5,
                      direction: Axis.horizontal,
                    ),
                    if (product.ratingCount != null)
                      Text("(" + product.ratingCount.toString() + ")"),
                  ]),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      for (var i = 0; i < 5; i++)
                        Icon(Icons.star_border, size: 16, color: LightColor.yellowColor)
                    ],
                  ),
                ),

//              if(product.variations.isNotEmpty)
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                  child: Expanded(
//                    child: Text(
//                      (product.shortDescription.isEmpty)?product.description:product.shortDescription,
//                      style: AppTheme.subTitleStyle.copyWith(fontSize: 16),
//                      overflow: TextOverflow.ellipsis,
//                      maxLines: 2,
//                    ),
//                  ),
//                ),

              SizedBox(
                height: 4,
              ),
              if (product.onSale && product.variations.isEmpty)
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "${((double.parse(product.regularPrice) * rates)).toStringAsFixed(2)} ${settingsServices.userSettings.currency}",
                      style: AppTheme.subTitleStyle.copyWith(
                          fontSize: 15, decoration: TextDecoration.lineThrough),
                    )),

              if (product.variations != null && product.variations.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "${(double.parse(product.getPrice()) * rates).toStringAsFixed(2)} ${settingsServices.userSettings.currency}",
                    style: AppTheme.titleStyle
                        .copyWith(fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),
              SizedBox(
                height: 18,
              ),
              (product.variations.isEmpty)
                  ? Expanded(
                      child: Container(
                        height: 40.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                      color: ColorsStyles.blue,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      )),
                                  //onPressed:onBuyPressed,
                                  child: Text(
                                    "Buy Now",
                                    style: AppTheme.titleStyle.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ShoppingCartIconProducts(product),
                            )
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Center(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: LightColor.lightcoffee,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text("Choose Item",
                                  style: TextStyle(color: Colors.black)))),
                    )
            ],
          ),
        );
      },
    );
  }

  Widget wishListProductRow(Product row,
      {VoidCallback onpressed,bool isBoard=false, VoidCallback addToBoard,ValueChanged<bool>onChange,bool isSelect=false}) {

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          navigationService.navigateTo(ProductRoute, arguments: row);
        },
        child: Container(
          height: 160,
          child: Row(
            children: <Widget>[
            if(isSelect)
              CheckBoxWishList(
                  (value){
                    onChange(value);
                  },
                ),

              Container(
                height: 160,
                width: 130,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: photoUrlWithoutBorder(row.images[0].src,
                            boxFit: BoxFit.cover, height: 160)),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(row.name,
                              maxLines: 3,
                              style: AppTheme.h3Style.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                          if (row.stockStatus != null)
                            Text("${row.stockStatus}")
                        ],
                      ),
                    ),
                    if (row.variations != null && row.variations.isEmpty)
                      Text(
                        "${(settingsServices.userSettings.currency == "USD") ? "\$" : ""} ${row.getPrice()}"
                        " ${settingsServices.userSettings.currency}",
                        style: AppTheme.titleStyle.copyWith(
                            fontSize: 18,
                            color: LightColor.black,
                            fontWeight: FontWeight.bold),
                      ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if(!isBoard)
                    OutlineButton(
                        onPressed: () {
                          addToBoard();
                        },
                        borderSide: BorderSide(color: Colors.black,width: 1.3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child:Text("Add To Board",style:TextStyle(color:Colors.black,)),
                      highlightedBorderColor: Colors.black,
                    ),
                    RawMaterialButton(
                      fillColor: Colors.black,
                      onPressed: () {
                        onpressed();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:13,vertical: 1),
                        child: Text(
                          "Add To Bag",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget wishListBoardRow(Board board,
      {bool showFour = false, double width, double height}) {
    return // (board.productsIds!=null)?

        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: (board.images != null&&board.images.isNotEmpty)
            ? Row(
                children: <Widget>[
                  photoUrlWithoutBorder(board.images[0],
                      width: width, height: height,boxFit:BoxFit.fitHeight),
                  if (board.images.length>1)
                    photoUrlWithoutBorder(board.images[1],
                        width: width, height: height,boxFit:BoxFit.fitHeight),
                  if (board.images.length > 3)
                    SizedBox(
                      width: width*1.6,
                      height: height,
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: <Widget>[
                          photoUrlWithoutBorder(board.images[2]),
                          photoUrlWithoutBorder(board.images[3]),
                          if (board.images.length>3)
                            photoUrlWithoutBorder(board.images[4]),
                          if (board.images.length>4)
                            photoUrlWithoutBorder(board.images[5]),
                        ],
                      ),
                    )
                ],
              )
            : Container(
                height: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/nf.png"),
                        fit: BoxFit.cover)),
              ),
      ),
      SizedBox(
        height: 16,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              board.title,
              style: AppTheme.h2Style,
            ),
            Text(
              "${board.productsIds.length} items",
              style: AppTheme.subTitleStyle,
            )
          ],
        ),
      )
    ]);

//        : Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: <Widget>[

//       // Image.asset("",height: 100,fit: BoxFit.cover,),
//
//        SizedBox(height: 10,),
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Text("${board.title}",style: AppTheme.h3Style,),
//        )
//      ],
//    );
  }

  Widget wishListBoardRowList(
      Board board, Product product, VoidCallback onpressed) {
    return InkWell(
      onTap: () {
        DataOP().updateBoard(board.id, product);
        onpressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              height: 60,
              child: (board.productsIds != null && board.productsIds.length > 2)
                  ? GridView.count(
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                      crossAxisCount: 2,
                      children: <Widget>[
                        for (String item in board.images)
                          CachedNetworkImage(
                            imageUrl: item,
                            height: 24,
                            width: 24,
                          )
                      ],
                    )
                  : Image.asset(
                      "assets/images/nf2.png",
                      width: 64,
                      height: 64,
                    ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(board.title,
                    style: AppTheme.titleStyle
                        .copyWith(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

//  Widget productRow(Product product) {
//    return RawMaterialButton(
//        onPressed: () {},
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//        elevation: 2,
//        fillColor: Colors.white,
//        child: Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Stack(
//            children: <Widget>[
////
////              Positioned(
////                top: 10,
////                left: 10,
////                child: Row(
////                  children: <Widget>[
////                    Row(
////                      children: <Widget>[
////                        Icon(Icons.star),
////                        SizedBox(width: 4,),
////                        Text("${product.averageRating}")
////                      ],
////                    ),
////
////                  ],
////                ),
////              ),
////              Positioned(
////                top: 15, right: 1,left: 1,
////                child: CachedNetworkImage(
////                  placeholder: (context, url) => Container(
////                    child: CircularProgressIndicator(
////                      valueColor: AlwaysStoppedAnimation<Color>(
////                          Colors.yellowAccent.shade700),
////                    ),
////                     height: 100,
////                    padding: EdgeInsets.all(70.0),
////                    decoration: BoxDecoration(
////                      color: Colors.grey,
////                      borderRadius: BorderRadius.all(
////                        Radius.circular(8.0),
////                      ),
////                    ),
////                  ),
////                  errorWidget: (context, url, error) => Material(
////                    child: Image.asset(
////                      'assets/images/nf2.png',
////                       height: 100,
////                      fit: BoxFit.cover,
////                    ),
////                    borderRadius: BorderRadius.all(
////                      Radius.circular(8.0),
////                    ),
////                    clipBehavior: Clip.hardEdge,
////                  ),
////                  imageUrl: product.images[0].src,
////                  height:85,
////                  fit: BoxFit.contain,
////                ),
////              ),
////              Positioned(top: 130,child: Text(product.name,style: AppTheme.titleStyle,)),
////              Row(
////                crossAxisAlignment: CrossAxisAlignment.end,
////                mainAxisAlignment: MainAxisAlignment.center,
////                children: <Widget>[
////                  if(product.onSale)
////                    Text(product.regularPrice,style: AppTheme.subTitleStyle.copyWith(
////                        decoration: TextDecoration.lineThrough,
////                        fontSize: 15
////                    ),),
////
////                  SizedBox(width: 8,),
////                  Text(product.getPrice(),style: AppTheme.titleStyle.copyWith(fontSize: 19),),
////                ],
////              ),
//            ],
//          ),
//        ));
//  }

//  Widget drawItemHorizontal(Product product) {
//    String herotag = product.images[0].src + "hor";
//    String photo = product.images[0].src;
//
//    return RawMaterialButton(
//      elevation: 4,
//      fillColor: Colors.white,
//      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//      onPressed: () {},
//      child: Stack(
//        children: <Widget>[
//          //    if (double.parse(product.averageRating)>0)
//          Positioned(
//            left: 14,
//            right: 5,
//            top: 1,
//            child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Row(
//                    children: <Widget>[
//                      Icon(
//                        Icons.star,
//                        color: Colors.yellowAccent.shade700,
//                      ),
//                      SizedBox(
//                        width: 2,
//                      ),
//                      Text("5.0",
//                          style: TextStyle(fontStyle: FontStyle.italic)),
//                    ],
//                  ),
//                  favoriteHart(product)
//                ]),
//          ),
//
//          Positioned(
//              top: 60,
//              left: 10,
//              right: 10,
//              child: Hero(tag: herotag, child: photoUrl(photo, height: 110))),
//          Positioned(
//            left: 0,
//            right: 0,
//            top: 190,
//            child: Padding(
//              padding: const EdgeInsets.only(left: 4.0, right: 18),
//              child: Center(child: Text(product.name, style: AppTheme.h3Style)),
//            ),
//          ),
//
//          Positioned(
//            bottom: 0,
//            right: 0,
//            left: 0,
//            child: Container(
//              height: 40,
//              child: Stack(
//                children: <Widget>[
//                  Positioned(
//                      top: 0,
//                      right: 0,
//                      bottom: 0,
//                      child: InkWell(
//                        onTap: () {},
//                        child: Container(
//                          width: 45,
//                          padding: EdgeInsets.symmetric(horizontal: 8),
//                          decoration: BoxDecoration(
//                              boxShadow: [
//                                BoxShadow(
//                                    blurRadius: 1,
//                                    spreadRadius: 1,
//                                    color: Colors.grey)
//                              ],
//                              color: Colors.grey.shade100,
//                              borderRadius: BorderRadius.only(
//                                topRight: Radius.circular(8),
//                                bottomRight: Radius.circular(10),
//                                topLeft: Radius.circular(10),
//                              )),
//                          child: Icon(Icons.add_shopping_cart,
//                              color: ColorsStyles.blue),
//                        ),
//                      )),
//                  Center(
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.end,
//                      children: <Widget>[
//                        SizedBox(width: 26),
//                        if (product.onSale)
//                          Text(
//                            "\$${double.parse(product.regularPrice)}",
//                            style: AppTheme.subTitleStyle.copyWith(
//                                fontSize: 15,
//                                decoration: TextDecoration.lineThrough),
//                          ),
//                        SizedBox(width: 8),
//                        Text(
//                          "\$ ${double.parse(product.getPrice())}",
//                          style: AppTheme.titleStyle.copyWith(fontSize: 19),
//                        ),
//                      ],
//                    ),
//                  )
//                ],
//              ),
//            ),
//          )
////
////        },),
//        ],
//      ),
//    );
//  }

}

class CheckBoxWishList extends StatefulWidget {
  ValueChanged<bool>onChange;
  CheckBoxWishList(this.onChange);

  @override
  _CheckBoxWishListState createState() => _CheckBoxWishListState();
}

class _CheckBoxWishListState extends State<CheckBoxWishList> {
  bool state = false;
  _CheckBoxWishListState();

  @override
  Widget build(BuildContext context) {
    return  Checkbox(
      value: state,
      activeColor: Colors.black,
      onChanged: (value){
        widget.onChange(value);
        setState(() {
          state =  value;
        });
      },
    );
  }
}

class favoriteHart extends StatefulWidget {
  Product resturant;

  favoriteHart(this.resturant);

  @override
  _favoriteHart createState() => _favoriteHart();
}
class _favoriteHart extends State<favoriteHart> {
  IconData icon = Icons.favorite_border;
  bool enable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataOP().checkProductFAV(widget.resturant.id).then((value) {
      enable = value;
      print(enable);
      if (!enable) icon = Icons.favorite;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: (enable != null && enable) ? ColorsStyles.blue : LightColor.red,
      ),
      onPressed: () {
        DataOP().addProductToFAV(widget.resturant);
        if (enable)
          icon = Icons.favorite;
        else
          icon = Icons.favorite_border;

        enable = !enable;

        setState(() {});
      },
    );
  }
}
