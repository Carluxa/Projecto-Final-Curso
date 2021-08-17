import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';


class UserAdd extends StatefulWidget {
  const UserAdd({Key key}) : super(key: key);

  @override
  _UserAddState createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: Constants.globalAppBar(context,
            title: Text("Meus Contacto",style: TextStyle(color: Colors.black),),),
        body: Container(
          //todo meus ContaCtos todos que ja Conversou
          child: Text ("Äm here "),),
    );
  }
  Future <void> getListView() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(auth.currentUser.uid).get();
    Map<String, dynamic> data = snapshot.data();
    setState(() {
      if(data['tipoUsuario'] == 'Interressados') {
      }
    });
    //where(auth.currentUser.uid,isEqualTo: userId);
    return false;
  }
}
