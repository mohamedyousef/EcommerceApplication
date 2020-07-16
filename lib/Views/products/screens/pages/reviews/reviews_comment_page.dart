import 'package:async/async.dart';
import 'package:ecommerceApp/Models/Review.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Services/wocommerce_datasource_api.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:ecommerceApp/Views/products/model/reviews_page_model.dart';
import 'package:ecommerceApp/Views/products/widget/widget.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';

class ReviewsAndCommentPage extends StatelessWidget {
  Product product;
  ReviewsAndCommentPage(this.product){
    print(product.id);
  }
  AuthenticationService _authenticationService = locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
//  SettingsServices _settingsServices = locator<SettingsServices>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReviewPageModel>.reactive(
        viewModelBuilder: ()=>ReviewPageModel(),
      onModelReady: (model)=>model.getReviews(product.id),
      builder: (context, model,child) {
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "${double.parse(product.averageRating).toStringAsFixed(1)}",
                          style: AppTheme.h1Style,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "OUT OF 5",
                          style:
                              AppTheme.subTitleStyle.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        RatingBarIndicator(
                          rating: double.parse(product.averageRating),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${product.ratingCount} ratings",
                          style: AppTheme.subTitleStyle,
                        )
                      ],
                    )
                  ],
                ),
              ),


              if(model.isBusy)
              Center(
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation(LightColor.lightcoffee),
                ),
              )
              else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("${model.reviews.length} Reviews"),
                        FlatButton(
                            onPressed: () {
                              print(product.id);
                              if (_authenticationService.userData == null)
                                _navigationService.navigateTo(LoginRoute);
                              else
                               _navigationService.navigateTo(
                                    WriteReviewRoute,
                                    arguments: product.id);
                            },
                            child: Row(
                              children: <Widget>[
                                Text("WRITE A REVIEW"),
                                SizedBox(
                                  width: 6,
                                ),
                                Icon(Icons.edit)
                              ],
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),

                    for (var item in model.reviews)
                      Column(
                        children: <Widget>[
                          RowComment(
                            item,
                            _authenticationService.userData.email,
                            onPressed: (){
                              model.deleteReview(item);
                            },
                            productId: product.id,
                          ),
                          Divider()
                        ],
                      ),
                    SizedBox(
                      height: ScreenUtils.screenHeight(context,size: 0.1),
                    ),
//                    ListView.separated(
//                        physics: NeverScrollableScrollPhysics(),
//                        itemBuilder: (context,index){
//                       return RowComment(snapshot.data[index],_authenticationService.userData.email);
//                    }, separatorBuilder: (context,div){
//                      return Divider();
//                    }, itemCount: snapshot.data.length),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
