import 'file:///D:/MyWork/Work/programming/APPS/Ecommerce%20App/code/ecommerceApp/lib/Models/notification/NotificationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class drawRowNotification extends StatelessWidget {
  NotificationModel notificationModel;
  drawRowNotification(this.notificationModel);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//
// drawRowNotification(BuildContext context,
//    NotificationModel notificationModel) {
////
////   Widget widget;
////   FileModel fileModel = FileModel(notificationModel.file_title,
////       notificationModel.file_url,
////       int.parse(notificationModel.file_term),
////       int.parse(notificationModel.file_grade),
////       int.parse(notificationModel.file_number),
////       teacherID: notificationModel.teacherID,fileID: notificationModel.fileID);
////
////   if (notificationModel.type=="1")
////     widget = ShowVideo(fileModel);
////   else if (notificationModel.type=="2")
////     widget = ShowPDFFile(fileModel.url,fileModel.title);
////   else
////     widget = FullPhoto(url:fileModel.url,text:fileModel.title);
////
////    return InkWell(
////      onTap: () {
////        Navigator.push(
////            context, CupertinoPageRoute(builder: (context) => widget));
////      },
////      child: Column(
////        children: <Widget>[
////          ListTile(
////            title: Text(
////              notificationModel.title, style: TextStyle(fontFamily: "stc"),),
////            subtitle: Text(
////              notificationModel.body, style: TextStyle(fontFamily: "din"),),
////            leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(
////                notificationModel.image),),
////          ),
////          Divider()
////        ],
////      ),
////    );
//}
