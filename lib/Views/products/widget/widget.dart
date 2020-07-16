import 'package:ecommerceApp/Helper/converter.dart';
import 'package:ecommerceApp/Models/Review.dart';
import 'package:ecommerceApp/Models/product.dart';
import 'package:ecommerceApp/Services/abstracts/api.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../locator.dart';

class attribute extends StatelessWidget {
  String title;
  bool active;

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: (active)?LightColor.black:Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200,width: 1.3)
      ),
      child: Center(child: Text(title,style: TextStyle(color: (active)?Colors.white:LightColor.black),)),
    );
  }

  attribute(this.title, this.active);
}


// statefull widget list for many choices

class AttributeView extends StatefulWidget {
  Attribute attribute;

  ValueChanged<DefaultAttribute> onActiveAttribute;

  AttributeView(this.attribute, this.onActiveAttribute);

  @override
  _AttributeViewState createState() => _AttributeViewState();
}

class _AttributeViewState extends State<AttributeView> {
  int indexActive = 0;
  DefaultAttribute defaultAttribute;

  @override
  void initState() {
    super.initState();
    defaultAttribute =
        DefaultAttribute(id: widget.attribute.id, name: widget.attribute.name);
    print(widget.attribute.options.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                indexActive = index;
                defaultAttribute.option = widget.attribute.options[index];
                widget.onActiveAttribute(defaultAttribute);
                setState(() {});
              },
              child: attribute(widget.attribute.options[index],
                  (this.indexActive == index)));
        },
        itemCount: widget.attribute.options.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}



// Text(widget.attribute.name,style: TextStyle(fontSize: 16,color: Colors.black54),),

class RowComment extends StatelessWidget {
  Review _review;
  String email;
  VoidCallback onPressed;
  int productId;
  RowComment(this._review,this.email,{this.onPressed,this.productId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CirclePhotoUrl(_review.reviewerAvatarUrls[0],rad: 25),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_review.reviewer,style: AppTheme.titleStyle.copyWith(
                    fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 4,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    RatingBarIndicator(
                      rating: _review.rating.toDouble(),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 16,
                      direction: Axis.horizontal,
                    ),
                       Text("${_review.rating} OUT OF 5 , ${DateFormat("yyyy-MM-dd ").format(_review.dateCreated)}",style: AppTheme.subTitleStyle,),
                  ]),
                  SizedBox(height: 11,),
                  Text("${removeAllHtmlTags(_review.review)}",style: TextStyle(fontSize: 15,color: Colors.black),)

                ],
              ),
            ),
          ],
        ),
        if(email==_review.reviewerEmail)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(onPressed: ()async{
              onPressed();
            },child: Text("Delete",style: TextStyle(color: Colors.red),),),
            SizedBox(width: 10,),
            FlatButton(onPressed: (){
              Navigator.pushNamed(context, WriteReviewRoute,arguments: productId);
            },child: Text("Edit",style:  TextStyle(color:LightColor.skyBlue),),),
          ],
        ),
      ],
    );
  }
}

class TableDimensions extends StatelessWidget {
  Dimensions _dimensions;
  String weight;

  TableDimensions(this.weight,this._dimensions);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
         border: TableBorder.all(style: BorderStyle.solid),
         columnWidths: {0: FractionColumnWidth(.4), 1: FractionColumnWidth(.2), 2: FractionColumnWidth(.4)},
         children: [
           if(_dimensions!=null)
           TableRow(
             children:[
               Container(
                 color: Colors.black,
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Center(child: Text("Length",style: TextStyle(color:Colors.white),)),
                 ),
               ),

               Container(
                 color: Colors.black,
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Center(child: Text("Width",style: TextStyle(color:Colors.white),)),
                 ),
               ),

               Container(
                 color: Colors.black,
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Center(child: Text("Height",style: TextStyle(color:Colors.white),)),
                 ),
               ),

             ]
           ),
           if(_dimensions!=null)

           TableRow(
               children:[
                 Container(
                   color: Colors.white,
                   child: Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Center(child: Text("${_dimensions.length}  cm",style: TextStyle(color:Colors.black),)),
                   ),
                 ),

                 Container(
                   color: Colors.white,
                   child: Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Center(child: Text("${_dimensions.width}  cm",style: TextStyle(color:Colors.black),)),
                   ),
                 ),

                 Container(
                   color: Colors.white,
                   child: Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Center(child: Text("${_dimensions.height}  cm",style: TextStyle(color:Colors.black),)),
                   ),
                 ),

               ]
           ),
           if(weight!=null&&weight.isNotEmpty)

           TableRow(
             children: [
               Container(
                 color: LightColor.coffer_light_grey,
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Center(child: Text("Weight",style: TextStyle(color:Colors.black),)),
                 ),),
               Container(
                   color: Colors.white,
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Center(child: Text("${weight} KG",style: TextStyle(color:Colors.black),)),
                   ),
               ),

               Container(color:Colors.white,padding: EdgeInsets.all(10),child: Text(""),),
             ]
           )

         ],

          ),
      ),
    );
  }
}

