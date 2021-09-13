import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/EditarConstrutor.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_info_componets.dart';


// ignore: must_be_immutable
class Perfil_Home_view extends StatefulWidget {
   Map snp;
   String id;

  Perfil_Home_view({this.snp,this.id});

  @override
  _Perfil_Home_viewState createState() => _Perfil_Home_viewState();
}

class _Perfil_Home_viewState extends State<Perfil_Home_view> {

  FirebaseAuth auth = FirebaseAuth.instance;
  Map snp;
  DocumentSnapshot userData;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
         elevation: 0,
         brightness: Brightness.light,
         backgroundColor: Colors.white,
          leading: IconButton( icon: Icon(Icons.arrow_back, size: 25, color: Colors.black,),
          onPressed: (){
           Navigator.pop(context);
           },
          ),
         actions: [
                                    StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                                 .collection("usuarios")
                                                 .doc(widget.id)
                                                 .snapshots(),
                                                  builder: (context,snapshot) {
                                                      userData = snapshot.data;
                                                   return snapshot.hasData ?
                                                     Row(
                                                     children: [
                                                       userData.data()['userId'] == auth.currentUser.uid?IconButton(
                                                      icon: Icon(Icons.edit, size: 25, color: Colors.black,),
                                                      onPressed:  userData.data()['tipoUsuario']=="Interressado"?(){
                                                      Navigator.push(context, MaterialPageRoute(builder: (_) => Editarconstrutor(userdata:widget.snp)));
                                                      }:(){
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (_) => Editarconstrutor(index: widget.id,)));}
                                ):Text(""),
                                                       userData.data()['userId']==auth.currentUser.uid?IconButton(
                                    icon: Icon(Icons.power_settings_new, size: 25, color: Colors.red,),
                                    onPressed:logOut
                                ):Text("")
                              ],
                            ): Container();}
                                                    )
                                                    ]),
                                              body: StreamBuilder(
                                                    stream: FirebaseFirestore.instance
                                                            .collection("usuarios")
                                                            .doc(widget.id)
                                                            .snapshots(),
                                                  builder: (context,snapshot) {
                                                        userData = snapshot.data;
                                                        return snapshot.hasData ?
                                                            SafeArea(
                                                              child: Card(
                                                              color: Colors.grey[100],
                                                              shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(30),),
                                                              child: Column(
                                                              children: [
                                                                Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundColor: Colors
                                                      .green[100],
                                                  child: Text(
                                                    userData.data()['nome'][0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 90
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          userData.data()['nome'], style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold ),
                                        ),
                                        Text(userData.data()['bio'] == null
                                            ? "Sem Bio"
                                            : userData.data()['bio'], style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.blue[900] ), ),
                                        SizedBox(
                                          height: 20,
                                          width: 200,
                                          child: Divider(
                                            color: Colors.purple[200],
                                          ),
                                        ),
                                        perfil_info( text: userData.data()['email'],
                                            icon: Icons.email,
                                            onpressed: () {} ),
                                        userData.data()['cargo'] != null ? perfil_info(
                                            text: userData.data()['cargo'],
                                            icon: Icons.work,
                                            onpressed: () {} ) : Container( ),
                                        perfil_info( text: userData.data()['provincia'],
                                            icon: Icons.place,
                                            onpressed: () {} ),
                                        perfil_info( text: userData.data()['localidade'],
                                            icon: Icons.place,
                                            onpressed: () {} ),
                                        perfil_info( text: userData.data()['telefone'],
                                            icon: Icons.phone,
                                            onpressed: () {} ),
                                        perfil_info( text: userData.data()['ddNascimento'],
                                            icon: Icons.date_range,
                                            onpressed: () {} ),
                                        //Perfil_info(text: "Publicocoes",icon: Icons.post_add_outlined,onpressed: (){Navigator.push(
                                        //   context, MaterialPageRoute( builder: (_) => DetailsScreen()));}),
                                        //todo publicocoes
                                      ],
                                    ),
                                  ),
                                ): Container();})
                          );
                        }

  logOut()async {
    return
      showDialog( context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: ListTile(
                title: ListTile(
                              title:Text( "Tem a Certeza que deseja"),
                             subtitle:Center(child: Text("sair da sua Conta?",style: TextStyle(color:Colors.black ),)),),),
          ),
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding( padding: EdgeInsets.symmetric( horizontal: 30.0 ) ),
                            GestureDetector(
                                child: Text( 'Sair' ),
                                onTap: () async {
                                  await auth.signOut( );
                                  SystemNavigator.pop( );
                                }
                            ),
                            Divider(height: 10,),
                            Padding( padding: EdgeInsets.all(8.0)),
                            GestureDetector(
                                child: Text( 'Cancelar' ),
                                onTap: () {
                                  Navigator.of( context ).pop( );
                                }
                            ),
                          ],
                        ),

                    //  Padding( padding: EdgeInsets.all( 8.0 ) ),
                    ],
                  ),
            )
        );
      } );
  }
}


