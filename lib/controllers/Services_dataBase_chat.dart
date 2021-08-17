import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecto_licenciatura/models/Chat_Model.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance.collection("usuarios").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("usuarios")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("usuarios")
        .where('nome', isEqualTo: searchField)
        .get();
  }

  // ignore: missing_return
  Future<bool> addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

/*
  Future<void> addMessage(String chatRoomId, chatMessageData)async {

    FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }
*/
  getUserChats(String itIsMyName) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  getChats(String chatRoomId) async{
    return FirebaseFirestore.instance
        .collection("chats")
        .doc('chatRoomId')
        .collection("messages")
        .orderBy('time')
        .snapshots();
  }
  static gethats(String idUser) async => FirebaseFirestore.instance.collection('chats/$idUser/messages').orderBy('time').snapshots();

  static Future addMessage({String chatRoomId, String idUser, String message,String currentUserchat}) async {
    ClassModeloUsuario userModel =ClassModeloUsuario();
    var  refMessages =
    FirebaseFirestore.instance.collection('chats/$idUser/messages');
    ChatUsers chatUsers = ChatUsers();
    chatUsers.messageText=message;
    chatUsers.idfrom = chatRoomId;
    //chatUsers.time = DateTime.now().millisecondsSinceEpoch as Timestamp;

    await refMessages.add(chatUsers.toMap(chatUsers));

    final refUsers = FirebaseFirestore.instance.collection('usuarios');
     await refUsers.doc(idUser)
            .update({userModel.lastMessage: DateTime.now()});
  }

}