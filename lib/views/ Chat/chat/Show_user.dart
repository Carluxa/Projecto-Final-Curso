import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:projecto_licenciatura/views/%20Chat/chat/UserAdd.dart';
import 'package:projecto_licenciatura/views/%20Chat/chat/chat_view.dart';
import 'package:projecto_licenciatura/views/Documentos/documentos_view.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';


// ignore: camel_case_types
class show_user extends StatefulWidget {

 // bool logged;

  show_user({Key key}) : super(key: key);

  @override
  _show_userState createState() => _show_userState();
}

// ignore: camel_case_types
class _show_userState extends State<show_user> {

  int _currentIndex = 0;
  int selectedIndex = 0;
  //bool checkcurrentUser= false;
  bool naoIdentificado = true;
  //bool isVisibleLogin= true;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  void initState() {
  //  getROOM();
  //  setVisibleLogin();
    //getListView( );
    // TODO: implement initState
    super.initState( );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Constants.globalAppBar( context,
            title: Text(
                "Lista de Contactos", style: TextStyle( color: Colors.black ) ),
        ),
        body:Stack(children:[
          Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.all( 10.0 ),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Stack(
                              children: [
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance.collection('usuarios').orderBy('nome').snapshots(),
                                    builder: (context, userSnapshot) {
                                      return userSnapshot.hasData ?
                                      SizedBox(
                                          height: 690,
                                          child:
                                          ListView.builder(
                                            itemCount: userSnapshot.data.docs.length,
                                            itemBuilder: (context, index) {
                                              DocumentSnapshot userData = userSnapshot.data.docs[index];
                                              return FirebaseAuth.instance.currentUser.uid!=userData.data()['userId']?Container(
                                                child:
                                                Card(
                                                  margin: EdgeInsets.all( 10 ),
                                                  elevation: 1,
                                                  color: Colors.white,
                                                  child:
                                                  Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState( () {
                                                              selectedIndex = index;
                                                              Navigator.push( context,
                                                                  MaterialPageRoute( builder: (_) =>
                                                                      Chat(
                                                                        chatRoomId:userData.data()['userId'],
                                                                        nome: userData.data()['nome'],
                                                                        idTo: userData.data()['userId'],
                                                                        //snapshotUser: userData[index]
                                                                      )));
                                                            } );
                                                          },
                                                          child: ListTile(
                                                            leading: CircleAvatar(
                                                              backgroundColor: Colors.orange[100],child: Text(userData.data()['nome'][0],style: TextStyle(fontSize: 30,color: Colors.black ),),  ),
                                                            title: Text(userData.data( )['nome']),
                                                            subtitle: Text(userData.data()['cargo']==null?'cliente':userData.data()['cargo'],
                                                              style: TextStyle(
                                                                  color: Colors.black.withOpacity(0.6 ) ), ),
                                                          ),
                                                        )
                                                      ] ),
                                                ),
                                              ):Container();
                                            },
                                          ) ) : Center(child: CircularProgressIndicator(backgroundColor: Colors.green, strokeWidth: 2, ));
                                    }
                                ),
                              ] ),
                          // Align( alignment: Alignment.bottomCenter,
                          //     child: ButtonCustom( ) ),
                        ]
                    ) ),
                // !widget.logged?Consumer<FirebaseUtils>(
                //     builder: (context,model,child){
                //       return
                //         model.isLogin?Visibility(visible: false,
                //             child: Visibility(visible:isVisibleLogin, child: SignIn(changeStatus:model))):
                //         Visibility(visible: true,
                //             child: Visibility(visible:isVisibleLogin, child: SignIn( changeStatus:model)));
                //     }
                // ): Text(""),
              ] )
        ]),
    );
  }


  Widget buttonCustom() {
    return
      CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: Colors.white,
        strokeColor: Colors.white,
        unSelectedColor: Colors.grey[600],
        backgroundColor: Colors.green[200],
        borderRadius: Radius.elliptical( 150, 150 ),
        blurEffect: true,
        opacity: 0.8,
        items: [
          CustomNavigationBarItem(
            icon: Icon( Icons.home, color: Colors.black, ),
            title: Text( "Pagina Inicial" ),
          ),
          CustomNavigationBarItem(
            icon: Icon( AntDesign.user, color: Colors.black, ),
            title: Text( "Meus contacto" ),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState( () {
            _currentIndex = index;
            if (_currentIndex == 0) {
              //getListView( );
              Navigator.push( context,
                  MaterialPageRoute( builder: (_) => document_view()));
            }
            if (_currentIndex == 1) {
              // getListView( );
              Navigator.push(
                  context, MaterialPageRoute( builder: (_) => UserAdd( ) ) );
            }
          } );
        },
        isFloating: true,
      );
  }
}
