import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:projecto_licenciatura/controllers/chat_Notifier_operation.dart';
import 'package:projecto_licenciatura/models/Chat_Model.dart';

// ignore: camel_case_types
class Chat_Controller {

// ignore: missing_return
static Stream<List<ChatUsers>> getMessages(String idUser){
 // List<QuerySnapshot> _chatList = [];
  FirebaseFirestore.instance
      .collection('chats/$idUser/messages')
      .orderBy('ChatUsers.time', descending: true)
      .snapshots();
}
static getUserInfo(String email,String idcurrent) async {
  return FirebaseFirestore.instance
      .collection("usuarios")
      .where("email", isEqualTo: email)
      .snapshots();
}

static Future<bool> addChatRoom(chatRoom, chatsRoomId)
{ return
  FirebaseFirestore.instance.collection("chatRoom").doc(chatsRoomId).set(chatRoom).catchError((e){print(e);});
}
static Future<Stream>getchats(String chatsRoomId) async{
  return FirebaseFirestore.instance
      .collection("chatsMessages")
      .doc(chatsRoomId)
      .collection("messages")
      .orderBy('time')
      .snapshots();
}
static Future <void> addMessage(String chatsRoomId, chatMessageData)
async {
  FirebaseFirestore.instance
      .doc(chatsRoomId)
      .collection("chats")
      .add(chatMessageData).catchError((e){print(e.toString());});

}
static getUserChats(String itisMyName) async{
  return FirebaseFirestore.instance
      .collection("chatRoom")
      .where('user',arrayContains: itisMyName).snapshots();
}

static Future addMessages({String chatRoomId, String idfrom,String idTo, String message}) async {
ChatUsers chatUsers = ChatUsers();
chatUsers.messageText=message;
chatUsers.idTo = idTo;
chatUsers.idfrom = idfrom;


await  FirebaseFirestore.instance
      .collection('chatsMessages')
      .doc(chatRoomId)
      .collection('messages')
      .add(chatUsers.toMap());
   }
 }
