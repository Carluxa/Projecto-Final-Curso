import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/Animations/fade_animation.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/Validation.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_home_view.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';

// ignore: must_be_immutable
class Editarconstrutor extends StatefulWidget {
  Map userdata;
  String index;
  String _bio;
 // String label;

  Editarconstrutor({Key key,this.userdata,this.index}) : super(key: key);

  @override
  _EditarconstrutorState createState() => _EditarconstrutorState();
}

class _EditarconstrutorState extends State<Editarconstrutor> {

  bool seePassword = true;
  String _nome;
  String  _email;
  String  _bi;
  String _telefone;
  String _nrCasa;
  String _quarteirao;
  String _valueCargo;
  String _dataDNas;
  String _provincia;
  String _localidade;
 // TextEditingController _bairro =TextEditingController();

 // final TextEditingController _pass = TextEditingController();
  //final TextEditingController _confirmPass = TextEditingController();
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  DateTime date = DateTime.utc(1990,1,1);
  bool autoValidate = false;
  bool isLoading = false;
  String _bio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final double categoryHeight = 460;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.green[50],
        appBar: Constants.globalAppBar(context),
        body: isLoading ?  Constants.cirlularProgress():
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("usuarios")
                .doc(widget.index)
                .snapshots(),
            builder: (context,snapshot) {
              DocumentSnapshot userData = snapshot.data;
              return snapshot.hasData ?
              Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Constants.title(context,text: "Editar"),
                      SizedBox( height: 20, ),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child:
                          Form( key: _formkey,
                            child: Container(
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: <Widget>[
                                      Container(
                                          width: 350,
                                          margin: EdgeInsets.only(
                                              right: 10, top: 70 ),
                                          height: categoryHeight,
                                          decoration: Constants.boxDecorationCadastro(),
                                          child: ListView(
                                            children: [Padding(
                                              padding: EdgeInsets.all( 16.0 ),
                                              child: Container(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(height: 20,),
                                                      FadeAnimation( 1.2, Widgetsclass.makeinputName(
                                                          label:"Bibliografia",
                                                         // icon:Icon(Icons.bio, color:  Constants.KDefaultIconcolor,),
                                                          nome: userData.data()['bio']==null?"":userData.data()['bio'],
                                                          function: (String value){
                                                            setState(() {
                                                              if(value==null)
                                                              {
                                                                _bio= userData.data()['bio'];
                                                              }
                                                              else
                                                              {_bio= value;
                                                              }
                                                            });
                                                          }

                                                      )),
                                                      FadeAnimation( 1.2, Widgetsclass.makeinputName(
                                                          label:"Nome",
                                                          icon:Icon(Icons.person, color:  Constants.KDefaultIconcolor,),
                                                          nome: userData.data()['nome'],
                                                          function: (String value){
                                                            setState(() {
                                                              if(value==null)
                                                                {
                                                                  _nome= userData.data()['nome'];
                                                                }
                                                              else
                                                                {_nome= value;
                                                                }
                                                            });
                                                          }

                                                      )),
                                                      FadeAnimation( 1.3, Widgetsclass.makeinputEmail(
                                                          label:"Email",
                                                          nome: userData.data()['email'],
                                                          icon:Icon(Icons.email,color:Constants.KDefaultIconcolor,),
                                                          email: _email,
                                                          hintText: "Por Favor introduza um email válido. ",
                                                          function: (String  value){setState(() {
                                                            if(value==null)
                                                              {
                                                                _email = userData.data()['email'];
                                                              }else{
                                                              _email = value;
                                                            }
                                                            }
                                                            );})),
                                                      FadeAnimation( 1.4,Widgetsclass.makeinputSenha(
                                                        senha: userData.data()['senha'],
                                                        readonly: true,
                                                        label:"Senha",
                                                        helperText:"Campos não Editável",
                                                        seePassword: seePassword,
                                                        //funtionSenha: (){ setState((){seePassword = !seePassword;});},
                                                        icon:Icon( Icons.lock,color: Constants.KDefaultIconcolor,),
                                                        //function: (value) {setState((){_pass.text = value;});},
                                                      )),
                                                      FadeAnimation( 1.5,Widgetsclass.makeinputSenha(
                                                        senha: userData.data()['conSenha'],
                                                        readonly: true,
                                                        helperText:"Campo não Editável",
                                                        label:'confirme a senha',
                                                        icon:Icon( Icons.lock,color: Constants.KDefaultIconcolor,),
                                                        seePassword: seePassword,
                                                      )),
                                                    ] ), ), ),
                                            ], )
                                      ),
                                      Container(
                                          width: 350,
                                          margin: EdgeInsets.only( right: 10, top: 70 ),
                                          height: categoryHeight,
                                          decoration: Constants.boxDecorationCadastro(),
                                          child: ListView(
                                              children:[
                                                Padding( padding: EdgeInsets.all( 16.0 ),
                                                    child:Container(
                                                      child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: <Widget>[
                                                            SizedBox(height: 20,),
                                                            FadeAnimation( 1.4,Widgetsclass.makeinputNumberTelefone(
                                                              telefone: userData.data()['telefone'],
                                                              label:'Telefone ',
                                                              icon:Icon( Icons.phone_android, color: Constants.KDefaultIconcolor,),
                                                              function: (value) {setState(() {
                                                                if(value==null){
                                                                  _telefone = value;
                                                                }
                                                                else{_telefone = value;}});},
                                                            )),
                                                            FadeAnimation( 1.5, makeinputData( "Data de Nascimento",
                                                                Icon( Icons.date_range, color: Colors.green,),userData) ),
                                                            FadeAnimation( 1.3, Widgetsclass.makeinputBI(
                                                              bi: userData.data()['bi'],
                                                              label:"BI",
                                                              icon:Icon( Icons.insert_drive_file, color: Constants.KDefaultIconcolor,),
                                                              funtion:(String value){
                                                                setState(() {
                                                                  if(value==null)
                                                                    {
                                                                      _bi= userData.data()['bi'];
                                                                    }
                                                                  _bi = value;
                                                                });
                                                              },
                                                            ) ),
                                                            //FadeAnimation(1.7, makeinputProv('Província',Icon(Icons.add_location, color: Colors.green,), elController:_suggestProvinceListController, seList:suggestProvinceList)),
                                                            FadeAnimation(1.4, makeinputProv(userData)),
                                                          ] ),
                                                    )),])),
                                      Container(
                                          width: 350,
                                          margin: EdgeInsets.only( right: 10, top: 70 ),
                                          height: categoryHeight,
                                          decoration: Constants.boxDecorationCadastro(),
                                          child: ListView(
                                              children:[
                                                Padding( padding: EdgeInsets.all( 16.0 ),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        SizedBox(height: 20,),
                                                        //FadeAnimation(1.1, makeinputAutoCompleteTextField('Localidade',Icon(Icons.add_location, color: Colors.green,),elController:_suggestCityListController, seList:suggestCityList)),
                                                        makeinputloc(userData),
                                                        FadeAnimation( 1.2,Widgetsclass.makeinputNumber(

                                                          label:'Número da Casa',
                                                          icon:Icon( Icons.home_outlined, color: Constants.KDefaultIconcolor),
                                                          funtion: (value) {
                                                            setState(() {
                                                                    if(value==null) {
                                                                      _nrCasa = userData.data()['nrCasa'];
                                                                      value=_nrCasa;
                                                                    } else{_nrCasa = value;}});},
                                                          help: "Número da Casa Residente ",
                                                          numbers:userData.data()['nrCasa'],
                                                        ) ),
                                                        FadeAnimation( 1.3, Widgetsclass.makeinputNumber(
                                                            numbers:userData.data()['quarteirao'],
                                                            label:'Quarteirão',
                                                            icon:Icon( Icons.home_outlined, color: Constants.KDefaultIconcolor),
                                                            funtion:(value) {
                                                              setState(() {
                                                                if(value==null){_quarteirao=userData.data()['quarteirao'];}
                                                                else{_quarteirao = value;}});},
                                                            help:"Número do seu Quarteirão "
                                                        ) ),
                                                        FadeAnimation(1.4, makeinputCargo(userData)),
                                                        SizedBox(height: 30,),
                                                        FadeAnimation(1.5,Constants.makebutton(label: "Gravar",function: (){Editarapi(userData);})
                                                        )]), ),
                                              ])
                                      ),
                                    ])
                            ),
                          )
                      )
                    ])
            )
        )
    :Container();}));
  }
  Widget makeinputProv(DocumentSnapshot userdata)
  {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat('Província'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600],width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(),
              child:
              DropdownButton(
                hint: Text(userdata.data()['provincia']),
                dropdownColor: Colors.green[50],
                elevation: 5,
                icon: Icon(Icons.arrow_drop_down_sharp,color: Constants.KDefaultIconcolor,),
                iconSize: 25.0,
                underline: SizedBox(),
                isExpanded: true,
                value: _provincia,
                items:Constants.suggestProvinceList.map(
                        (String valueProv){
                      return DropdownMenuItem<String>(value:valueProv,child: Text(valueProv));
                    }).toList(),
                onChanged :(value){ setState(() {
                  if(value==null){
                    _provincia =userdata.data()['provincia'];
                  }else{_provincia= value;}});},
              ),
            ),
            SizedBox(height: 5,),
          ]
      );
  }
  Widget makeinputloc(DocumentSnapshot userdata)
  {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat("Localidade"),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600],width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(),
              child:
              DropdownButton(
                  hint: Text(userdata.data()['localidade']),
                  dropdownColor: Colors.green[50],
                  elevation: 5,
                  icon: Icon(Icons.arrow_drop_down_sharp,color: Constants.KDefaultIconcolor,),
                  iconSize: 25.0,
                  underline: SizedBox(),
                  isExpanded: true,
                  value: _localidade,
                  items: Constants.suggestCityList.map((String loc) {return DropdownMenuItem<String>(value:loc,child: Text(loc));}).toList(),
                  onChanged :(value){ setState(() {
                    if(value==null){_localidade=userdata.data()['localidade'];}else{_localidade = value;}});}
              )),
            SizedBox(height: 5,),
          ]
      );
  }

  Widget makeinputCargo(DocumentSnapshot userdata)
  {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat("Cargo"),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600],width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(),
              child:
              DropdownButton<String>(
                hint: userdata.data()['cargo']==null?Text("cliente"):Text(userdata.data()['cargo']),
                dropdownColor: Colors.green[50],
                elevation: 5,
                icon:  Icon(Icons.arrow_drop_down_sharp,color: Constants.KDefaultIconcolor,),
                iconSize: 25.0,
                underline: SizedBox(),
                isExpanded: true,
                value: _valueCargo,
                 items:Constants.suggestCargoList.map(
                         (String value){
                       return DropdownMenuItem<String>(
                           value:value,
                           child: Text(value)
                       );
                     }).toList(),
                onChanged :(value){
                  setState(() {
                    _valueCargo = value;
                  });},
              ),
            ),
            SizedBox(height: 5,),
          ]
      );
  }

  makeinputData(String label,icon,DocumentSnapshot userdata)
  {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat(label),
            TextField(
              //readOnly: true,
              decoration: InputDecoration(
                hintText:  userdata.data()['ddNascimento'],
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
                selectTimePicker(context,userdata);
              },),
            SizedBox(height: 5,),
          ]
      );
  }


  Future<Null>selectTimePicker(BuildContext context,DocumentSnapshot userdata)async{
    final DateTime picked = await showDatePicker(context: context,
        initialDate: date,
        errorFormatText: "dd/mm/yyyy",
        firstDate: DateTime(1940),
        lastDate: DateTime(2003),
        builder: (BuildContext context, Widget child){
          return Theme(
            data: ThemeData(
                primaryColor: Color(0xFFC41A3B),
                accentColor: Color(0xFFC41A3B)),child: child,);
        },
    );
    if(picked != null && picked != date )
    {  setState(() {
      date = picked;
      if(date==null)
        {
          _dataDNas= userdata.data()['ddNascimento'];
        }
      else{
        _dataDNas = date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString();
      }});
    }
  }
  Widget makeinputBio(DocumentSnapshot userdata)
  {    return
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          TextFormField(
            initialValue: userdata.data()['bio']==null?"Introduza a sua bibliografia":userdata.data()['bio'],
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              fillColor: Colors.black,
            ),
            onChanged: (String value) {
              _bio = value;

              // print(currentPost.descricao);
            },
          ),]);
  }
  User user = FirebaseAuth.instance.currentUser;
  // ignore: non_constant_identifier_names
  Future <void> Editarapi(DocumentSnapshot userdata) async {
    ClassModeloUsuario usuarioModel = new ClassModeloUsuario();
    if(_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
        autoValidate = false;
      });
      if(_bio==null) {usuarioModel.bio = userdata.data()['bio'];}else{usuarioModel.bio=_bio;}
      if(_nome==null) {usuarioModel.nome = userdata.data()['nome'];}else{usuarioModel.nome=_nome;}
      if(_email==null) {usuarioModel.email = userdata.data()['email'];}else{usuarioModel.email=_email;}
      if(_telefone==null) {usuarioModel.telefone =userdata.data()['telefone'];}else{usuarioModel.telefone=_telefone;}
      if(_dataDNas==null) {usuarioModel.ddNascimento = userdata.data()['ddNascimento'];}else{usuarioModel.ddNascimento=_dataDNas;}
      if(_bi==null) {usuarioModel.bi = userdata.data()['bi'];}else{usuarioModel.bi=_bi;}
      if(_provincia==null) {usuarioModel.provincia = userdata.data()['provincia'];}else{usuarioModel.provincia=_provincia;}
      if(_localidade==null) {usuarioModel.localidade = userdata.data()['localidade'];}else{usuarioModel.localidade=_localidade;}
      if(_nrCasa==null) {usuarioModel.nrCasa = userdata.data()['nrCasa'];}else{usuarioModel.nrCasa=_nrCasa;}
      if(_quarteirao==null) {usuarioModel.quarteirao = userdata.data()['quarteirao'];}else{usuarioModel.quarteirao=_quarteirao;}
      if(_valueCargo==null) {usuarioModel.cargo =userdata.data()['cargo'];}else{usuarioModel.cargo=_valueCargo;}

      usuarioModel.tipoUsuario = userdata.data()['tipoUsuario'];
      usuarioModel.senha = userdata.data()['senha'];
      usuarioModel.conSenha =userdata.data()['conSenha'];
      usuarioModel.userId = userdata.data()['userId'];


      await FirebaseFirestore.instance.collection( 'usuarios' )
          .doc( userdata.data()['userId'] )
          .update( usuarioModel.toMap( ) );

      Fluttertoast.showToast( msg: "Editado com Sucesso" );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => Perfil_Home_view(id: user.uid,)),
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

