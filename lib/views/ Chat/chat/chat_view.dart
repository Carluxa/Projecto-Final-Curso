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
  String idTo;
  Map snapshotUser;

  Chat({this.chatRoomId,this.idTo,this.snapshotUser,this.nome});

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
     return Stack(
       children: [
             StreamBuilder(
                stream: FirebaseFirestore.instance
                          .collection("chatsMessages")
                          .doc(widget.chatRoomId)
                          .collection("messages")
                          .orderBy('time',descending: true)
                          .snapshots(),
                builder: (context,snapshot){
                return snapshot.hasData ?
                    //FirebaseAuth.instance.currentUser.uid == snapshot.data.docs['idFrom']?
                  ListView.builder(
                     itemCount: snapshot.data.docs.length,
                     physics: BouncingScrollPhysics(),
                     shrinkWrap: true,
                     reverse: true,
                     itemBuilder:
                        snapshot.hasData?(context, index){
                         DocumentSnapshot userData = snapshot.data.docs[index];
                         return
                              FirebaseAuth.instance.currentUser.uid==userData.data()['idfrom']?
                              MessageTile(
                                  message: userData.data()['messageText'],
                                  sendByMe: FirebaseAuth.instance.currentUser.uid==userData.data()['idfrom'],
                              ):Container();
                      }
                      :Container(child: Text("Say Something"),)) :
                             Center(child: CircularProgressIndicator( backgroundColor: Colors.green,strokeWidth: 1,));
                        //:Constants.message(text: "Say Hi ");
                  },
             ),
        // CircularProgressIndicator(),

     ]);
   }


  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      Chat_Controller.addMessages(chatRoomId: widget.chatRoomId,message: messageEditingController.text,idfrom: FirebaseAuth.instance.currentUser.uid,idTo:widget.idTo );
      messageEditingController.text = "";
      setState(() {
       // messageEditingController.clear();

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
          appBar:  Constants.appBarMain( context, nome: widget.nome, idUser: widget.idTo ),
           body:
      //Column(
      //       children: [
      //        Container(
      //             color: Colors.blue,
      //             width: 500,
      //             height: 500,
      //             child:  SingleChildScrollView(
      //                 child:
      //                     Column(
      //                       children: [
      //                         Text("Hellooo", style: TextStyle(fontSize: 70, color:  Colors.purple),),
      //                 Text("Hellooo", style: TextStyle(fontSize: 70, color:  Colors.purple),),
      //            Text("Hellooo", style: TextStyle(fontSize: 70, color:  Colors.purple),),
      //     Text("Hellooo", style: TextStyle(fontSize: 70, color:  Colors.purple),),
      // Text("Hellooo", style: TextStyle(fontSize: 70, color:  Colors.purple),),
      // Text("Hellooo", style: TextStyle(fontSize: 70, color:  Colors.purple),),
      //                 Text("Hellooo", style: TextStyle(fontSize: 70, color:  Colors.purple),),
      //            Text("Hellooo", style: TextStyle(fontSize: 70, color:  Colors.purple),)
      //                       ],
      //                     )),
      //           ),
      //         Container(
      //           color: Colors.red,
      //           width: 500,
      //           height: 100,
      //           child: Text("Am HERE",style: TextStyle(fontSize: 30, color:  Colors.yellowAccent),),
      //         ),
      //
      //       ],
      //      )
           SingleChildScrollView(
                  child:
                           Column(
                                 children: [
                                   Container(
                                   padding: EdgeInsets.symmetric(vertical: 10),
                                   alignment: Alignment.topLeft,
                                   color: Colors.white,
                                   height: MediaQuery.of(context).size.height/1.3,
                                   child: chatMessages(),
                            ),
                        Container(
                          color: Colors.grey[100],
                          alignment: Alignment.bottomLeft,
                          height: MediaQuery.of(context).size.height/10,
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                    textCapitalization: TextCapitalization.sentences,
                                    autocorrect:true,
                                    enableSuggestions:true,
                                    //controller: messageEditingController,
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
                    ]),
      ));
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
            top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xFF78909c),
                const Color(0xFF78909c)
              ] 
                  : [
                const Color(0xFFFFAEDB9F),
                const Color(0xFFFFAEDB9F)
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