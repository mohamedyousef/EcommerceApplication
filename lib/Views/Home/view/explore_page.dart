import 'package:async/async.dart';
import 'package:ecommerceApp/Models/category.dart';
import 'package:ecommerceApp/Services/category_services.dart';
import 'package:ecommerceApp/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../../locator.dart';

class ExplorePage extends StatelessWidget {

  CategoryServices categoryServices = locator<CategoryServices>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: categoryServices.getCategoires(),
      builder: (context, snapshot) {
        if(snapshot.hasData)
        return ListView.builder(itemBuilder: (context,index){
          return Widgets().categoryExplore(snapshot.data[index]);
        },itemCount: snapshot.data.length,);

        return Container(child: Center(child: Text("Not Found")),);
      }
    );
  }
}
