//import 'package:ecenter/Database/database_operations.dart';
//import 'package:ecenter/Notifications/models/NotificationModel.dart';
//import 'package:ecenter/Notifications/widgets/widgets.dart';
//import 'package:ecenter/styles/colors.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//import 'package:provider/provider.dart';
//import 'package:ecenter/provider/notifications.dart';
//
//class NotificationScreen extends StatefulWidget {
//  @override
//  _NotificationScreenState createState() => _NotificationScreenState();
//}
//
//class _NotificationScreenState extends State<NotificationScreen> {
//  List<NotificationModel>notifications = List<NotificationModel>();
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    final provider = Provider.of<NotificationProvider>(context,listen: false);
//
//    for(NotificationModel item in provider.notifications) {
//      NotificationModel notificationModel =  item;
//      notificationModel.seen= true;
//      notifications.add(notificationModel);
//    }
//    provider.notifications=notifications;
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
////    return Directionality(
////      textDirection: TextDirection.rtl,
////      child: Scaffold(
//
////        body:(provider.notifications.isNotEmpty)?SizedBox.expand(
////          child: ListView.builder(
////            itemBuilder: (context, index) {
////              return drawRowNotification(context, provider.notifications[index]);
////            },
////            itemCount: provider.notifications.length,
////          ),
////        ):Column(
////          mainAxisAlignment: MainAxisAlignment.center,
////          crossAxisAlignment: CrossAxisAlignment.center,
////          children: <Widget>[
////            Center(child: Text("لا يوجد لديك اشعارات",style: TextStyle(fontFamily: "din",fontSize: 18),)),
////          ],
////        ),
////      ),
////    );
//    return  Directionality(
//      textDirection: TextDirection.rtl,
//      child: Scaffold(
////        bottomNavigationBar: BottomAppBar(
////          elevation: 0,
////          color: Colors.transparent,
////          child: Padding(
////            padding: const EdgeInsets.all(12.0),
////            child: OutlineButton(child: Row(
////              mainAxisAlignment: MainAxisAlignment.center,
////              children: <Widget>[
////                Text("حذف جميع الاشعارات"),
////                SizedBox(width: 20,),
////                Icon(Icons.delete,color: Colors.red,),
////              ],
////            ),onPressed: (){
////              DataOP().clear();
////              setState(() {});
////            },),
////          ),
////        ),
//        appBar: AppBar(
//          backgroundColor: ColorsStyles.purple,
//          title: Text(
//            "قائمة الاشعارات",
//            style: TextStyle(fontFamily: "stc"),
//          ),
//          centerTitle: true,
//          actions: <Widget>[
//            IconButton(icon:Icon(Icons.delete,color: Colors.white,),onPressed: (){
//              DataOP().clear();
//              setState(() {});
//            },)
//          ],
//        ),
//        body: FutureBuilder(
//          future: DataOP().getAllSortRecent(),
//          builder: (context, AsyncSnapshot<List<NotificationModel>> snapshot) {
//            if (snapshot.hasData) {
//              if(snapshot.data.isNotEmpty)
//               return ListView.builder(
//                itemBuilder: (context, index) {
//                  return drawRowNotification(context, snapshot.data[index]);
//                },
//                itemCount: snapshot.data.length,
//              );
//              else
//                return Center(
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(MdiIcons.bell),
//                      SizedBox(
//                        width: 8,
//                      ),
//                      Text(
//                        "لا يوجد اشعارات حتي الان",
//                        style: TextStyle(
//                            fontFamily: "din",
//                            fontSize: 18,
//                            color: Colors.black54),
//                      )
//                    ],
//                  ),
//                );
//            }
//          },
//        ),
//      ),
//    );
//  }
//}
