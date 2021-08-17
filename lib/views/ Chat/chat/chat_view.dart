import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Chat_Controller.dart';
import 'package:projecto_licenciatura/controllers/chat_Notifier_operation.dart';
import 'package:projecto_licenciatura/models/Chat_Model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';



// ignore: must_be_immutable
class Chat extends StatefulWidget  {
  String chatRoomId;
  ChatNotifier postNotifier;
  String nome;
  String idFrom;
  Map snapshotUser;

  Chat({this.chatRoomId,this.idFrom,this.snapshotUser,this.nome});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  Stream<List<ChatUsers>> chats;
 // QueryDocumentSnapshot chats;
  TextEditingController messageEditingController = new TextEditingController();
  //String message;
   Stream messagess;

   Widget chatMessages() {
     //ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context,listen: false);
     return StreamBuilder(
       stream: FirebaseFirestore.instance
           .collection("chatsMessages")
           .doc(widget.chatRoomId)
           .collection("messages")
           .orderBy('time',descending: true)
           .snapshots(),
       builder: (context,snapshot){
         return snapshot.hasData && FirebaseAuth.instance.currentUser.uid == snapshot.data.docs['idFrom']?
         ListView.builder(
             itemCount: snapshot.data.docs.length,
             physics: BouncingScrollPhysics(),
             shrinkWrap: true,
             reverse: true,
             itemBuilder:
                (context, index){
                  DocumentSnapshot userData = snapshot.data.docs[index];
              return
                  // buildItem(index,snapshot.data.docs[index]),
                    MessageTile(
                       message: userData.data()['messageText'],
                       sendByMe: FirebaseAuth.instance.currentUser.uid==userData.data()['idfrom'],
                     );
             //  Text(chatNotifier.chatList[index].messageText);
             }) : Constants.message(text: "Say Hi");
       },
     );
   }//napshot.data.documents[index].data['chatRoomId']




  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      // Map<String, dynamic> chatMessageMap = {
      //   "sendBy": Constants.myName,
      //   "message": messageEditingController.text,
      // };
      Chat_Controller.addMessages(chatRoomId: widget.chatRoomId,message: messageEditingController.text,idfrom: FirebaseAuth.instance.currentUser.uid,idTo:widget.idFrom );

      setState(() {
        messageEditingController.text = "";
      });
    }
  }
    @override
    void initState() {
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      //ChatNotifier chatNotifier = Provider.of<ChatNotifier>(context,listen: false);
      return Scaffold(
          appBar: Constants.appBarMain( context, nome: widget.nome, ),
          body:
          Stack(
              children: [

                //Text("hello"),
             Container(
                padding: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.topLeft,
              //height: MediaQuery.of(context).size.h,
              color: Colors.transparent,
                child:chatMessages(),
              ),
               /* Align(
                  alignment: Alignment.bottomLeft,
                  child:
                  Container(
                    padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
                    height: 60,
                    width: double.infinity,
                    color:Colors.green,
                    child:  Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(Icons.add, color: Colors.white, size: 20, ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),
                        FloatingActionButton(
                          onPressed: (){},
                          child: Icon(Icons.send,color: Colors.white,size: 18,),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                )*/

                Container(
                    alignment: Alignment.bottomLeft,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent,
                    child:
                        Container(
                          color: Colors.grey[100],
                          alignment: Alignment.bottomCenter,
                          height: MediaQuery.of(context).size.height/9,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                   // textCapitalization: TextCapitalization.sentences,
                                    autocorrect:true,
                                   // enableSuggestions:true,
                                  // controller: messageEditingController,
                                    onChanged: (value){
                                      setState(() {
                                        messageEditingController.text = value;
                                      });},
                                    style: Constants.simpleTextStyle(),
                                    decoration: InputDecoration(
                                        hintText: "Message ...",
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        border: InputBorder.none

                                    ),
                                  )),
                              SizedBox(height: 16,),
                              GestureDetector(
                                onTap: messageEditingController.text.trim().isEmpty?null:(){addMessage();},
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Icon(Icons.send, size: 20,  color:  Colors.black,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
      );
    }
  }



class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 2,
          bottom: 5,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 15, bottom: 15, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xFFFFB47EDE),
                const Color(0xFFFFB0BEC5)
              ] 
                  : [
                const Color(0xFFFF607D8B),
                const Color(0xFFFF607D8B)
              ],
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
               // fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}