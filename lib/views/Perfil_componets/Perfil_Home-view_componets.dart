import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/controllers/UserNotifier.dart';
import 'package:projecto_licenciatura/controllers/userController.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/EditarConstrutor.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/EditarInteressado.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_info_componets.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class Perfil_Home_view extends StatefulWidget {
Map snp;
  Perfil_Home_view({this.snp});

  @override
  _Perfil_Home_viewState createState() => _Perfil_Home_viewState();
}

class _Perfil_Home_viewState extends State<Perfil_Home_view> {

  FirebaseAuth auth = FirebaseAuth.instance;
  Map snp;
  Future<void>checkcurrentUserM () async {
    // FirebaseAuth auth =
    User auth =FirebaseAuth.instance.currentUser;
      try {
        var snapshot = await FirebaseFirestore.instance
            .collection( 'usuarios' )
            .doc( auth.uid ).get( );
        Map<String, dynamic> dataReceive = snapshot.data( );
        snp = dataReceive;
        print( snp );
      }catch(e){
        print("O errro do document $e");
      }
  }
  @override
  void initState() {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    getUser(userNotifier);
    checkcurrentUserM();
    print("------------------->$snp");

    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              snp['userId']==auth.currentUser.uid?IconButton(
                  icon: Icon(Icons.edit, size: 25, color: Colors.black,),
                  onPressed: snp['tipoUsuario']=="Interressado"?(){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Editarconstrutor(userData:widget.snp)));
                  }:(){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Editarconstrutor(userData: widget.snp,)));}
              ):Text(""),
              snp['userId']==auth.currentUser.uid?IconButton(
                  icon: Icon(Icons.power_settings_new, size: 25, color: Colors.red,),
                  onPressed:logOut
              ):Text("")
            ],
          )
         ],
    ),
      body:
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
                        backgroundColor: Colors.green[100],
                        //backgroundImage: AssetImage('assets/Images/house1.png'),
                        //Icon(Icons.add_a_photo),
                        child:Text(
                          snp['nome'][0],
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
                  snp['nome'],style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold),
                ),
                Text(snp['bio']==null?"Sem Bio":snp['bio'],style: TextStyle(fontSize: 16, color:Colors.blue[900] ),),
                SizedBox(
                  height: 20,
                  width: 200,
                  child: Divider(
                    color: Colors.purple[200],
                  ),
                ),
                perfil_info(text: snp['email'],icon: Icons.email,onpressed: (){}),
                perfil_info(text: snp['cargo'],icon: Icons.work,onpressed: (){}),
                perfil_info(text: snp['provincia'],icon: Icons.place,onpressed: (){}),
                perfil_info(text: snp['localidade'],icon: Icons.place,onpressed: (){}),
                perfil_info(text: snp['telefone'],icon: Icons.phone,onpressed: (){}),
                perfil_info(text: snp['ddNascimento'],icon: Icons.date_range,onpressed: (){}),
                //Perfil_info(text: "Publicocoes",icon: Icons.post_add_outlined,onpressed: (){Navigator.push(
                 //   context, MaterialPageRoute( builder: (_) => DetailsScreen()));}),
                //todo publicocoes
              ],
            ),
          ),
        ),
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


