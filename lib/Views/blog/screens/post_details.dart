import 'package:ecommerceApp/themes/styles/colors.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart';
import 'package:intl/intl.dart';

class PostDetailsScreen extends StatelessWidget {

  Post post;
  PostDetailsScreen(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading:  IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.chevron_left,color: Colors.black,size: 30,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
              Text("${post.title.rendered}",style: AppTheme.h1Style.copyWith(
                fontWeight: FontWeight.w500,
                color:ColorsStyles.blue
              ),),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("by ${post.author.name}",style: AppTheme.subTitleStyle.copyWith(
                        fontSize: 15
                      ),),
                      Text(
                        DateFormat('yyyy - MMM - dd')
                            .format(DateTime.parse(post.dateGmt)),
                        style: AppTheme.subTitleStyle.copyWith(
                          fontSize: 15
                        ),
                      )
                    ],
                  ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HtmlWidget(
                  post.content.rendered,
                  onTapUrl: (url) => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('onTapUrl'),
                      content: Text(url),
                    ),
                  ),
                ),
              ),
//              WebView(
//                initialUrl: "",
//                javascriptMode: JavascriptMode.unrestricted,
//
//                onWebViewCreated: (controller){
//                  _webViewController = controller;
//                  loadFromHtml();
//                },
//              )

            ],
          ),
        ),
      ),
    );
  }

}


