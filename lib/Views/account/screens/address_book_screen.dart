import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'file:///D:/MyWork/Work/programming/APPS/Ecommerce%20App/code/ecommerceApp/lib/Views/account/models/address_book_view_model.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Models/shipping_biilling.dart';
import '../../../locator.dart';

class AddressBookScreen extends StatelessWidget {


  NavigationService navigationService = locator<NavigationService>();


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressBookViewModel>.reactive(
      viewModelBuilder:()=>AddressBookViewModel(),
      builder: (context, model,child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.chevron_left,size: 32,color: Colors.black,),
              onPressed: (){
                navigationService.goBack();

              },
            ),
            title: Text("ADDRESS BOOK",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
          ),
          body: StreamBuilder(
                  stream: DataOP().getAllAddressFromDataBase(),
                  builder: (context,AsyncSnapshot<List<Ing>> snapshot) {
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(LightColor.midlightcoffee),
                        ),);
                        break;
                      case ConnectionState.active:
                      case ConnectionState.done:
                        return ListView.builder(
                          padding: EdgeInsets.only(left:8,right: 8,top: 25),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(top:4.0),
                              child: Card(
                                child: ListTile(
                                  leading: Icon(MdiIcons.mapMarkerOutline,color:Colors.grey.shade700),
                                  title: Row(
                                    children: <Widget>[
                                      Text("${(snapshot.data[index].firstName+" "+snapshot.data[index].lastName).toUpperCase()}"
                                        ,style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),),
                                      SizedBox(width:16),
                                      if(snapshot.data[index].isDefault!=null&&snapshot.data[index].isDefault)
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal:5,vertical: 3),
                                          child: Text("Default",style: TextStyle(color:Colors.white
                                              ,fontSize: 14  ,fontWeight: FontWeight.w600),)
                                          ,color: Colors.black,)
                                    ],
                                  ),
                                  subtitle: Text("${snapshot.data[index].address1}"),
                                  trailing: Icon(MdiIcons.squareEditOutline),
                                  onTap: (){
                                     model.navigationService.navigateTo(AddAddressBookRoute,arguments: snapshot.data[index]);
                                  },

                                ),
                              ),
                            );
                          },);
                        break;
                    }
                    return Container();

                  }
              ),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color:Colors.white ,
            child: InkWell(
              onTap: (){
                model.navigationService.navigateTo(AddAddressBookRoute);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: double.infinity,
                  color: Colors.black,
                  padding: EdgeInsets.all(16),
                  child: Text("Add New Address",textAlign: TextAlign.center
                    ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
