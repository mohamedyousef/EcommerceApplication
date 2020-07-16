import 'package:ecommerceApp/Helper/converter.dart';
import 'package:ecommerceApp/Views/products/model/write_review_view_model.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';

class WriteReviewScreen extends StatelessWidget {
  int productId;

  WriteReviewScreen(this.productId);

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WriteReviewViewModel>.reactive(
        viewModelBuilder: () => WriteReviewViewModel(),
        onModelReady: (model) async{
         await model.getReview(productId);
         print(model.review.review);
         if(model.review.review!=null)
         _textEditingController.text = removeAllHtmlTags(model.review.review);
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text("Write Your Review"),
            ),
            bottomNavigationBar:(model.isBusy)? null:BottomAppBar(
              elevation: 0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RawMaterialButton(
                  onPressed: () {
                    model.addReview(productId, _textEditingController.text);
                  },
                  elevation: 0,
                  fillColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Add To Reviews",
                      style: AppTheme.titleStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height:
                                ScreenUtils.screenHeight(context, size: 0.1)),
                        RatingBar(
                          initialRating: model.rating+0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            model.rating = rating;
                          },
                        ),
                        SizedBox(height: 18),
                        Text(
                          "${model.rating}",
                          style: AppTheme.h2Style
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height:
                                ScreenUtils.screenHeight(context, size: 0.1)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: textForm(
                              _textEditingController, "Write Your Review here",
                              borderColor: Colors.grey.shade300,
                              cursorColor: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
                if (model.isBusy)
                  Positioned.fill(
                      child: AnimatedOpacity(
                          opacity: 0.7,
                          duration: Duration(milliseconds: 500),
                          child: Container(color: LightColor.grey_green))),
                if (model.isBusy)
                  Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                    ),
                  )
              ],
            ),
          );
        });
  }
}
