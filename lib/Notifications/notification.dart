import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceApp/DataBase/database_operations.dart';
import 'package:ecommerceApp/Views/Home/view/home_view.dart';
import 'package:ecommerceApp/themes/styles/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/android_sounds.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_ringtone_player/ios_sounds.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationHandler extends StatefulWidget {
  @override
  _NotificationHandlerState createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {

  final Firestore _db = Firestore.instance;

  _saveDeviceToken() async {
    // Get the current user

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    // Save it to Firestore
    if (fcmToken != null && user!=null) {
      var tokens = _db
          .collection('Users')
          .document(user.uid)
          .collection('tokens')
          .document(fcmToken);

      await tokens.setData({
        'token': fcmToken,
      });
    }
  }

  String APP_STORE_URL ='';
  String  PLAY_STORE_URL ='';

  final FirebaseMessaging _fcm = FirebaseMessaging();
  // StreamSubscription iosSubscription;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String id;


  versionCheck(context) async {

    //Get Current installed version of app
    final PackageInfo info = await PackageInfo.fromPlatform();
    double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

    //Get Latest version info from firebase config
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      // Using default duration to force fetching from remote server.
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched();
      APP_STORE_URL = remoteConfig.getString("appstore");
      PLAY_STORE_URL = remoteConfig.getString("android");
      String banner  = remoteConfig.getString("banner");

      double newVersion = double.parse(remoteConfig
          .getString('current_version')
          .trim()
          .replaceAll(".", ""));
      // print(newVersion.toString()+"\&"+currentVersion.toString());
      if (newVersion > currentVersion) {
        _showVersionDialog(context);
      }

      if(banner!=null&&banner.isNotEmpty){
        // show Banner
      }
    } on FetchThrottledException catch (exception) {
      // Fetch throttled.
      print(exception);
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "تحديث جديد في انتظارك";
        String message =
            "انت تستخدم نسخة قديمة من  التطبيق قم بتنزيل التحديث و تمتع بمميزات جديدة ";
        String btnLabel = "تحديث";
        String btnLabelCancel = "لاحقا";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
          title: Text(title,style: TextStyles.second_title_sans,),
          content: Text(message,style: TextStyles.second_title_stc,),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel,style: TextStyles.second_title_sans,),
              onPressed: () => _launchURL(APP_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel,style: TextStyles.second_title_sans),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
            : new AlertDialog(
          title: Text(title,style: TextStyles.second_title_sans,),
          content: Text(message,style: TextStyles.second_title_stc,),
          actions: <Widget>[
            FlatButton(
              child: Text(btnLabel,style: TextStyles.second_title_stc,),
              onPressed: () => _launchURL(PLAY_STORE_URL),
            ),
            FlatButton(
              child: Text(btnLabelCancel,style: TextStyles.second_title_stc),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


 @override
  void initState() {
   super.initState();
    try {
      versionCheck(context);
     // ShowAd().showAD(context);
    } catch (e) {
      print(e);
    }

    var IOS = IOSInitializationSettings();
    var android = AndroidInitializationSettings("mipmap/ic_launcher");
    var platform  = InitializationSettings(android,IOS);
    flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(platform);

    if (Platform.isIOS) {
      _fcm.onIosSettingsRegistered.listen((data) {
        // save the token  OR subscribe to a topic here
        _saveDeviceToken();
      });
      _fcm.requestNotificationPermissions(IosNotificationSettings(sound: true,badge: true,alert: true));
    }
    else
      _saveDeviceToken();


      _fcm.configure(
        onMessage: (Map<String, dynamic> message)  {
          //  print("onMessage: $message");

          if(message['data']['id']!=id)
         if(message['data']['id']!=null) {
           this.id = message['data']['id'];
            // ignore: missing_return
//            DataOP().addNotification(NotificationModel(
//                message['notification']['title'],
//                message['notification']['body'],
//                message['data']['image'],
//                message['data']['id'],
//                message['data']['type'],
//                message['data']['url'],
//                message['data']['title'],
////                message['data']['grade'],
////                message['data']['number'],
////                message['data']['term'],
////                message['data']['subject'],
//                message['data']['teacherID'],
//                false
//            ));
          }


          FlutterRingtonePlayer.play(
            android: AndroidSounds.notification,
            ios: IosSounds.glass,
            looping: false,
            volume: 0.1,
          );
          // showNotification(message);

        },
        onLaunch: (Map<String, dynamic> message) async {

//          FileModel fileModel = FileModel(
//            message['data']['title'],
//            message['data']['url'],
//            message['data']['term'],
//            message['data']['grade'],
//            message['data']['number'],
//            teacherID:  message['data']['teacherID'],
//            fileID: message['data']['id']
//          );
//          String type=message['data']['type'];
//
//          if(type=="1")
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowVideo(fileModel)));
//          else if (type=="5")
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>FullPhoto(url:fileModel.url,text: fileModel.title,)));
//          else if(type=="2")
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowPDFFile(fileModel.url,fileModel.title)));


//          if(message['data']['id']!=id)
//            if(message['data']['id']!=null) {
//              this.id = message['data']['id'];
//
//              DataOP().addNotificationModelToFAV(
//                  NotificationModel(
//                  message['notification']['title'],
//                  message['notification']['body'],
//                  message['data']['image'],
//                  message['data']['id'],
//                  message['data']['type'],
//                  message['data']['url'],
//                  message['data']['title'],
//                  message['data']['grade'],
//                  message['data']['number'],
//                  message['data']['term'],
//                  message['data']['subject'],
//                  message['data']['teacherID'],
//                  true
//              ));
//            }
        },
        onResume: (Map<String, dynamic> message) async {
//          FileModel fileModel = FileModel(
//            message['data']['title'],
//            message['data']['url'],
//            message['data']['term'],
//            message['data']['grade'],
//            message['data']['number'],
//            teacherID:  message['data']['teacherID'],
//            fileID: message['data']['id']
//          );
//          String type=message['data']['type'];
//
//          if(type=="1")
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowVideo(fileModel)));
//          else if (type=="5")
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>FullPhoto(url:fileModel.url,text: fileModel.title,)));
//          else if(type=="2")
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowPDFFile(fileModel.url,fileModel.title)));

        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}