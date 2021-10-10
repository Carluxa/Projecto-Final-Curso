
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/SetUpCadastros/signUpProfissionais.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/Validation.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';




// ignore: must_be_immutable
class  SignUp extends StatefulWidget {
  bool logged;
  Map dataReceive;
  int index;
  SignUp({this.logged,this.dataReceive,this.index});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  String _valueCargo;
  bool isVisible = false;
  bool isLoading = false;

@override
  Widget build(BuildContext context) {
    final double categoryHeight = 460;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.green[50],
        appBar: Constants.globalAppBar(context),
        body: isLoading ? Constants.cirlularProgress():
        Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Constants.title(context,text: "Cadastro"),
                      SizedBox( height: 20, ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                           Container(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                       Container(
                                          width: 350,
                                          margin: EdgeInsets.only(
                                              right: 10, top: 70 ),
                                          height: categoryHeight,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                20.0 ), ),
                                          child: ListView(
                                            children:[
                                              Padding(padding: EdgeInsets.all( 16.0 ),
                                              child:Container(
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                            width: 350,
                                                            margin: EdgeInsets.only( right: 10, top: 70 ),
                                                            height: categoryHeight,
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(20.0),),
                                                            child: ListView(
                                                                children:[
                                                                  Padding(
                                                                    padding: EdgeInsets.all( 16.0 ),
                                                                    child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Center(
                                                                              child: Widgetsclass.makeinputCargo(
                                                                                label:"Tipo de Utilizador",
                                                                                texthint:Text("Escolha o Tipo de Utilizador",),
                                                                                value: _valueCargo,
                                                                                funtionItem:
                                                                                    Constants.suggestTipoList.map((valueCargo){
                                                                                      return DropdownMenuItem(value:valueCargo,child: Text(valueCargo)
                                                                                      );
                                                                                    }).toList(),
                                                                                funtion: (value){
                                                                                    setState( () {
                                                                                      if(value=="Construtor"){
                                                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpConstrutor(indexSignIn:widget.index,index:0,label: "Cadastro",logged: widget.logged,dataReceive:widget.dataReceive,tipo: _valueCargo,)));
                                                                                      }
                                                                                      if(value=="Cliente"){
                                                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpConstrutor(indexSignIn:widget.index,index:1,label:"Cadastro",logged: widget.logged,dataReceive:widget.dataReceive,tipo: _valueCargo,)));
                                                                                      }
                                                                                      _valueCargo = value;
                                                                                      print("o valor do Campo é $_valueCargo");
                                                                                    });},
                                                                              ),
                                                                          )
                                                      ]),
                                                ),
                                                SizedBox(height: 15,),
                                              ])
                                      ),
                                  ])
                          ),
                        ),
                        ]) )
                        ])))]))));
  }
}
