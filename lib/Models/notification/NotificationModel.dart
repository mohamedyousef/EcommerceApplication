import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel{

  int id ;

  NotificationModel(this.title, this.body, this.image, this.fileID,
      this.type, this.file_url,this.file_title,
      //this.file_grade,
//      this.file_number,
//      this.file_term,
//      this.file_subject,
      this.teacherID,
      this.seen);

  String title,body,image,fileID,type,file_url,file_title,file_grade="0",file_number="0",teacherID,file_term="0",file_subject="";
  bool seen;

  toMap(){
    return {
      "title":title,
      "body":body,
      "image":image,
      "type":type,
      "file_url":file_url,
      "fileID":fileID,
      "file_title":file_title,
//      "file_term":file_term,
//      "file_grade":file_grade,
//      "file_subject":file_subject,
//      "file_number":file_number,
      "seen":seen,
      "teacherID":teacherID,
      "time":Timestamp.now().toDate().millisecondsSinceEpoch
    };
  }
  static NotificationModel fromMap(Map<String,dynamic>data){
    return NotificationModel(
      data['title'],
      data['body'],
      data['image'],
      data['fileID'],
      data['type'],
      data['file_url'],
      data['file_title'],
//      data['file_grade'],
//      data['file_number'],
//      data['file_term'],
//      data['file_subject'],
      data['teacherID'],
      data['seen'],
    );
  }
}