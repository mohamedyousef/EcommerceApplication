import 'package:ecommerceApp/Localization/applocalization.dart';
import 'package:ecommerceApp/Models/user.dart';
import 'package:ecommerceApp/Services/AuthenticationServices.dart';
import 'package:ecommerceApp/Services/NavigationServices.dart';
import 'package:ecommerceApp/Widgets/components.dart';
import 'package:ecommerceApp/constants/route_path.dart';
import 'package:ecommerceApp/locator.dart';
import 'package:ecommerceApp/themes/light_color.dart';
import 'package:ecommerceApp/themes/styles/ScreenUtils.dart';
import 'package:ecommerceApp/themes/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:ecommerceApp/Views/Home/model/profile_screen_view.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileScreenViewModel>.reactive(
      viewModelBuilder:()=>ProfileScreenViewModel(),
      onModelReady: (model)=>model.listenToUserSettings(),
      builder: (context, model,child) {
        return Container(
          color: Colors.white54,
          height: double.infinity,
          child: StreamBuilder<User>(
            stream: locator<AuthenticationService>().user.stream,
            builder: (context, snapshot) {
              User user = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height:8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        if (user != null&&user.avatarUrl!=null&&user.avatarUrl.isNotEmpty)
                          CirclePhotoUrl(user.avatarUrl)
                        else
                          Expanded(
                            child: photoAssets(
                              "assets/images/back2.jpg",
                              height: ScreenUtils.screenHeight(context,size:0.18),
                              shape: false
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (user != null)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                 user.getFullName().toUpperCase(),
                                  style: AppTheme.h3Style.copyWith(color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  user.email,
                                  style: AppTheme.subTitleStyle.copyWith(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 12,
                                ),

                              ],
                            ),
                          )
//                        else
//                          OutlineButton(
//                            onPressed: () {
//                              locator<NavigationService>().navigateTo(LoginRoute);
//                            },
//                             shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(10)),
//                             child: Padding(
//                              padding: const EdgeInsets.all(10.0),
//                              child: Text("Login",
//                                  style: TextStyle(color: Colors.black)),
//                            ),
//                          ),
                      ],
                    ) ,

                    SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                          child:Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: <Widget>[
                                if(user==null )
                                Column(
                                  children: <Widget>[
                                    ListTile(
                                      onTap: (){
                                        locator<NavigationService>().navigateTo(LoginRoute);
                                      },
                                      leading: Icon(Icons.account_circle,color: Colors.grey.shade700,),
                                      title :Text(AppLocalizations.of(context).translate("login")),
                                      trailing: CircleAvatar(
                                          backgroundColor: Colors.grey.shade200,
                                          radius: 12
                                          ,child: Icon(Icons.chevron_right,color: Colors.black,size: 21,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:28.0),
                                      child: Divider(),
                                    ),
                                  ],
                                ),
                                if(user!=null)
                                Column(
                                  children: <Widget>[
                                    ListTile(
                                      onTap: (){
                                        model.navigationService.navigateTo(MyOrdersRoute);
                                      },
                                      leading: Icon(Icons.list,color: Colors.grey.shade700,),
                                      title :Text("My Orders") ,
                                      trailing: CircleAvatar(
                                          backgroundColor: Colors.grey.shade200,
                                          radius: 12
                                          ,child: Icon(Icons.chevron_right,color: Colors.black,size: 21,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:28.0),
                                      child: Divider(),
                                    ),
                                    ListTile(
                                      onTap: (){
                                        model.navigationService.navigateTo(AddressBookRoute);
                                      },
                                      leading: Icon(Icons.outlined_flag,color: Colors.grey.shade700,),
                                      title : Text("Shipping Address") ,
                                      trailing: CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      radius: 12
                                      ,child: Icon(Icons.chevron_right,color: LightColor.black,size: 21,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:28.0),
                                      child: Divider(),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.payment,color: Colors.grey.shade700,),
                                      title :Text("Payment Method") ,
                                      trailing: CircleAvatar(
                                          backgroundColor: Colors.grey.shade200,
                                          radius: 12
                                          ,child: Icon(Icons.chevron_right,color: Colors.black,size: 21,)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:28.0),
                                      child: Divider(),
                                    ),
                                  ],
                                ),
//                                ListTile(
//                                  leading: Icon(Icons.brightness_3,color: Colors.grey.shade700,),
//                                  title :Text("Dark Theme") ,
//                                  trailing: Switch(
//                                    onChanged: (value){
//                                      model.darkMode = value;
//                                      model.settingsServices.changeTheme(value);
//                                    },
//                                    value: model.darkMode,
//
//                                  ),
//                                ),


                                ListTile(
                                  onTap: (){
                                    model.navigationService.navigateTo(ChooseSettingsRoute,arguments: 1);
                                  },
                                  leading: Icon(Icons.attach_money,color: Colors.grey.shade700,),
                                  title :Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(AppLocalizations.of(context).translate("currency")),
                                      Text("${model.currency}"),
                                    ],
                                  ) ,
                                  trailing: CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      radius: 12
                                      ,child: Icon(Icons.chevron_right,color: Colors.black,size: 21,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:28.0),
                                  child: Divider(),
                                ),
                                ListTile(
                                  onTap: (){
                                    model.navigationService.navigateTo(ChooseSettingsRoute,arguments: 2);
                                  },
                                  leading: Icon(Icons.translate,color: Colors.grey.shade700,),
                                  title :Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(AppLocalizations.of(context).translate("language")),
                                      Text("${model.language}"),
                                    ],
                                  ) ,
                                  trailing: CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      radius: 12
                                      ,child: Icon(Icons.chevron_right,color: Colors.black,size: 21,)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:28.0),
                                  child: Divider(),
                                ),
                                ListTile(
                                  onTap: (){
                                    model.navigationService.navigateTo(HelpAndContactRoute);
                                  },
                                  leading: Icon(Icons.help_outline,color: Colors.grey.shade700,),
                                  title :Text(AppLocalizations.of(context).translate("helpandcontact")) ,
                                  trailing: CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      radius: 12
                                      ,child: Icon(Icons.chevron_right,color: Colors.black,size: 21,)),
                                ),

                                if(user!=null)
                                Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:28.0),
                                      child: Divider(),
                                    ),
                                    ListTile(
                                      onTap: (){
                                        locator<AuthenticationService>().logout();
                                      },
                                      leading: Icon(MdiIcons.logout,color: Colors.grey.shade700,),
                                      title :Text(AppLocalizations.of(context).translate("signout")) ,
                                      trailing: CircleAvatar(
                                          backgroundColor: Colors.grey.shade200,
                                          radius: 12
                                          ,child: Icon(Icons.chevron_right,color: Colors.black,size: 21,)),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          )
                      ),
                    )


                  ],
                ),
              );

            }
          ),
        );
      }
    );
  }
}
