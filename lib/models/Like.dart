import 'package:cloud_firestore/cloud_firestore.dart';

class Likes{
  dynamic likebool;
  String likesip;
  String userId;
  Timestamp time;

  Likes({this.likebool, this.userId,this.time,this.likesip});

  toMap([Likes likes]) {
    return {
      'likebool': likebool,
      'likesip':likesip,
      'userId': userId,
      'time': FieldValue.serverTimestamp()
    };
  }

  factory Likes.fromMap(Map map) {
    return Likes(
      likebool: map["likebool"],
      likesip: map["likesip"],
      userId: map["userId"],
      time: map["time"],
    );
  }

}