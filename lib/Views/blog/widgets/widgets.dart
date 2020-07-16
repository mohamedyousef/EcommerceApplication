import 'package:ecommerceApp/Helper/converter.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:intl/intl.dart';

NavigationService  navigatoionServices = locator<NavigationService>();

class PostWidget extends StatelessWidget {

  Post _post;
  PostWidget(this._post);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: (){
        navigatoionServices.navigateTo(PostDetailsRoute,arguments: _post);
      },
      child: Row(
        children: <Widget>[
          photoUrlWithoutBorder(_post.featuredMedia.sourceUrl,
              boxFit: BoxFit.fitWidth,
              width: 80, height: 64),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _post.title.rendered,
                  style: AppTheme.titleStyle,
                ),
                SizedBox(
                  height: 8,
                ),   Text(
                  DateFormat('yyyy - MMM - dd')
                      .format(DateTime.parse(_post.dateGmt)),
                  style: AppTheme.subTitleStyle,
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
class PostVerticalWidget extends StatelessWidget {
  Post _post;

  PostVerticalWidget(this._post);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(

      fillColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      elevation: 1,
      onPressed: () {
        navigatoionServices.navigateTo(PostDetailsRoute,arguments: _post);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          photoUrlWithoutBorder(_post.featuredMedia.sourceUrl,
              boxFit: BoxFit.fitWidth, width: double.infinity),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${(_post.authorID == 0) ? "ROOT" : _post.author.name}",
                      style: AppTheme.titleStyle.copyWith(fontSize: 13),
                    ),
                    Text(
                        DateFormat('yyyy - MMM - dd')
                            .format(DateTime.parse(_post.date)),
                        style: AppTheme.titleStyle
                            .copyWith(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  _post.title.rendered,
                  style: AppTheme.h3Style,
                ),
                Text(
                  removeAllHtmlTags(_post.content.rendered),
                  style: AppTheme.titleStyle.copyWith(color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
