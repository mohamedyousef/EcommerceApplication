import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/Views/Categories/models/cateogires_model.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';

class ListViewAllCategories extends StatefulWidget {
  @override
  _ListViewAllCategoriesState createState() => _ListViewAllCategoriesState();
}

class _ListViewAllCategoriesState extends State<ListViewAllCategories> {


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoriesViewModel>.reactive(
      viewModelBuilder: ()=>CategoriesViewModel(),
      builder: (context, model,child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                model.navigationService.goBack();
              },
              icon: Icon(CupertinoIcons.left_chevron),
            ),
            elevation: 0,
            centerTitle: true,
            title: Text("All Categories"),
          ),
          body:(!model.isBusy)?ListView.builder(itemBuilder: (context,index){
            return Column(
              children: <Widget>[
                Container(
                  color: Colors.grey.shade100,
                  height: ScreenUtils.screenHeight(context, size: 0.065),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: (){
                        model.navigationService.navigateTo(ProductsRoute, arguments: model.data[index]);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${model.data[index].name}",
                            style: AppTheme.h3Style,
                          ),
                          Text(
                            "${model.data[index].count} items",
                            style: AppTheme.subTitleStyle,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                 for(Category item in model.getAllCategoriesByCatName(model.data[index].id))
                   Column(
                     children: <Widget>[
                       ListTile(
                         onTap: (){
                           model.navigationService.navigateTo(ViewAllProductsBySubCatRoute,arguments:item);
                         } ,
                         title: Text(item.name),
                         subtitle: Text("(${item.count}) items"),
                         trailing: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 12
            ,child: Icon(MdiIcons.chevronRight,color: LightColor.black,size: 21,)),
                       ),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal:28.0),
                         child: Divider(),
                       ),
                     ],
                   ),
              ],
            );
          },itemCount: model.data.length):Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(LightColor.lightcoffee),
            ),
          )
        );
      }
    );
  }
}
