import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/Animations/fade_animation.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/Validation.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_home_view.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';


// ignore: must_be_immutable
class EditarInteressado extends StatefulWidget {

  Map userData;
  EditarInteressado({Key key,this.userData}) : super(key: key);

  @override
  _EditarInteressadoState createState() => _EditarInteressadoState();
}

class _EditarInteressadoState extends State<EditarInteressado> {

  bool seePassword = true;
  String _nome;
  String _email;
  DateTime date = DateTime.now();
  String _dataDNas;
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>( );
  int selectedIndex = 0;
  bool autoValidate = false;
  bool isLoading = false;
  String _telefone;


  Widget build(BuildContext context) {
    final double categoryHeight = 460;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.green[50],
        appBar: Constants.globalAppBar(context),
        body: isLoading ? Constants.cirlularProgress() :
        Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
            child: Container(
                child: Column(
                    children: [
                      Constants.title(context,text: "Editar"),
                      SizedBox( height: 20, ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:
                          Form(
                              key: _formkey,
                              child: Container(
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
                                            children: [Padding(
                                              padding: EdgeInsets.all( 16.0 ),
                                              child: Container(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Column(
                                                        children:[
                                                          //email
                                                          FadeAnimation( 1.2, Widgetsclass.makeinputName(
                                                              label:"Nome",
                                                              icon:Icon(Icons.person,color:Constants.KDefaultIconcolor,),
                                                                  nome: widget.userData['nome'],
                                                                  function: (String value){
                                                                  setState(() {
                                                                  if(value==null)
                                                                  {_nome= widget.userData['nome'];}
                                                                  else{_nome= value;}
                                                                  });
                                                                  }
                                                              )),
                                                          FadeAnimation( 1.2, Widgetsclass.makeinputEmail(
                                                            label:"Email",
                                                            icon:Icon(Icons.email,color:Constants.KDefaultIconcolor,),
                                                            nome: widget.userData['email'],
                                                                email: _email,
                                                                hintText: "Por Favor introduza um email válido. ",
                                                                function: (String  value){setState(() {
                                                                if(value==null)
                                                                {_email = widget.userData['email'];}
                                                                else{_email = value;}
                                                                },
                                                          );})),
                                                          FadeAnimation( 1.4,Widgetsclass.makeinputNumberTelefone(
                                                            telefone: widget.userData['telefone'],
                                                            label:'Telefone ',
                                                            icon:Icon( Icons.phone_android, color: Constants.KDefaultIconcolor,),
                                                            function: (value) {setState(() {
                                                              if(value==null){
                                                                _telefone = value;
                                                              }
                                                              else{_telefone = value;}});},
                                                          )),
                                                          FadeAnimation( 1.5, makeinputData( "Data de Nascimento",
                                                            Icon( Icons.date_range, color: Colors.green,), ) ),

                                                          FadeAnimation( 1.4,Widgetsclass.makeinputSenha(
                                                            senha: widget.userData['senha'],
                                                            //readonly: true,
                                                            label:"Senha",
                                                            helperText:"Campos não Editável",
                                                            seePassword: seePassword,
                                                            //funtionSenha: (){ setState((){seePassword = !seePassword;});},
                                                            icon:Icon( Icons.lock,color: Constants.KDefaultIconcolor,),
                                                            //function: (value) {setState((){_pass.text = value;});},
                                                          )),
                                                          FadeAnimation( 1.5,Widgetsclass.makeinputSenha(
                                                            senha: widget.userData['conSenha'],
                                                            //readonly: true,
                                                            helperText:"Campo não Editável",
                                                            label:'confirme a senha',
                                                            icon:Icon( Icons.lock,color: Constants.KDefaultIconcolor,),
                                                            seePassword: seePassword,
                                                          )),
                                                          SizedBox(height: 20,),
                                                          Constants.makebutton(label: "Editar",function: (){Editarapi();}),
                                                        ],)
                                                    ] ), ), ),
                                            ], )
                                      )
                                    ] ),
                              ) ) )
                    ] ) ) )
    );
  }

  makeinputData(String label,icon)
  {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat(label),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: widget.userData['ddNascimento'],
                hintStyle: TextStyle(color: Colors.black),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[400],)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                prefixIcon: icon ,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400],
                  ),
                ),),
              onTap: (){
                selectTimePicker(context);
              },),
            SizedBox(height: 5,),
          ]
      );
  }

  Future<Null>selectTimePicker(BuildContext context)async{
    final DateTime picked = await showDatePicker(context: context,
        initialDate: date,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child){
          return Theme(
            data: ThemeData(
                primaryColor: Color(0xFFC41A3B),
                accentColor: Color(0xFFC41A3B)),child: child,);
        }
    );
    if(picked != null && picked != date )
    {  setState(() {
      date = picked;
      if(date==null)
      {
        _dataDNas= widget.userData['ddNascimento'];
      }
      else{
        _dataDNas = date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString();
      }});
    }
  }

  // ignore: non_constant_identifier_names
  Future <void> Editarapi() async {
    ClassModeloUsuario usuarioModel = new ClassModeloUsuario();
    if(_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
        autoValidate = false;
      });
      if(_nome==null) {usuarioModel.nome = widget.userData['nome'];}else{usuarioModel.nome=_nome;}
      if(_email==null) {usuarioModel.email = widget.userData['email'];}else{usuarioModel.email=_email;}
      if(_telefone==null) {usuarioModel.telefone = widget.userData['telefone'];}else{usuarioModel.telefone=_telefone;}
      if(_dataDNas==null) {usuarioModel.ddNascimento = widget.userData['ddNascimento'];}else{usuarioModel.ddNascimento=_dataDNas;}

      usuarioModel.tipoUsuario = widget.userData['tipoUsuario'];
      usuarioModel.senha = widget.userData['senha'];
      usuarioModel.conSenha = widget.userData['conSenha'];
      usuarioModel.userId = widget.userData['userId'];


      await FirebaseFirestore.instance.collection( 'usuarios' )
          .doc( widget.userData['userId'] )
          .update( usuarioModel.toMap( ) );

      Fluttertoast.showToast( msg: "Editado com Sucesso" );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => Post_home_view()),
              (Route<dynamic> route) => false
      ).catchError((onError) {
        print('msg: error' + onError.toString());
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error " + onError.toString());
      });
    }else{
      setState((){autoValidate = true;});
    }}
}

