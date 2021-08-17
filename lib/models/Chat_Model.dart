import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUsers{
  String messageText;
  String idfrom;
  String idTo;
  Timestamp time;
  ChatUsers({this.idfrom,this.idTo,this.messageText,this.time});

  toMap([ChatUsers chatUsers]) {
    return {
      'messageText': messageText,
      'idTo': idTo,
      'idfrom':idfrom,
      'time': FieldValue.serverTimestamp()
    };
  }

  factory ChatUsers.fromMap(Map map) {
    return ChatUsers(
      idfrom: map["idfrom"],
      idTo: map["idTo"],
      messageText: map["messageText"],
      time: map["time"],
    );
  }

}