
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Chat_Controller.dart';
import 'package:projecto_licenciatura/views/%20Chat/chat/chat_view.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';


class ChatRoom extends StatefulWidget {
@override
_ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream chatRooms;

         Widget chatRoomsList() {
             return StreamBuilder(
                   stream: chatRooms,
                    builder: (context, snapshot) {
                    return snapshot.hasData
                      ? ListView.builder(
                       itemCount: snapshot.data.docs.length,
                       // shrinkWrap: true,
                       itemBuilder: (context, index) {
                        return ChatRoomsTile(
                            userName: FirebaseAuth.instance.currentUser.uid != snapshot.data.documents[index].data['chatRoomId']?snapshot.data.documents[index].data['chatRoomId']
                            .toString()
                                .replaceAll("_", "")
                                .replaceAll(Constants.myName, ""): Container(),
                            chatRoomId: FirebaseAuth.instance.currentUser.uid == snapshot.data.documents[index].data["chatRoomId"]?snapshot.data.documents[index].data["chatRoomId"]:"",
                           );
                        }) : Container();
                       },
                    );
                 }

              @override
               void initState() {
                  getUserInfogetChats();
                  super.initState();
                }

  getUserInfogetChats() async {
     //Constants.myName = await HelperFunctions.getUserNameSharedPreference();

    String currentUid= FirebaseAuth.instance.currentUser.uid;

    Chat_Controller.getUserInfo(Constants.myName,currentUid).then((snapshots) {
     setState(() {
         chatRooms = snapshots;
         print(
             "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
         });
       });
      }

@override
   Widget build(BuildContext context) {
        return Scaffold(
            appBar:  Constants.globalAppBar( context,
              title: Text(
                  "Lista de Contactos", style: TextStyle( color: Colors.black) ),
            ),
                 body: Container(child: chatRoomsList(),),
                     );
             }
}

class ChatRoomsTile extends StatelessWidget {
    final String userName;
    final String chatRoomId;

ChatRoomsTile({this.userName,@required this.chatRoomId});

@override
      Widget build(BuildContext context) {
          return GestureDetector(onTap: (){
                 Navigator.push(context, MaterialPageRoute(
                     builder: (context) => Chat(
                       chatRoomId : chatRoomId,
                           )
                       ));
                 },
                  child: Container(
                         color: Colors.black26,
                         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                   child: Row(
                                          children: [
                                                 Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                               color: Constants.colorAccent,
                                                                borderRadius: BorderRadius.circular(30)),
                                                        child: Text(userName.substring(0, 1),
                                                               textAlign: TextAlign.center,
                                                               style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w300)),
                                                        ),
                                                        SizedBox(width: 12,),
                                                        Text(userName, textAlign: TextAlign.start,
                                                        style: TextStyle(color: Colors.black, fontSize: 20,
                                                        fontWeight: FontWeight.w300))
                                                        ],
                                                  ),
                                            ),
                                    );
                              }
               }