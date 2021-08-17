import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/Animations/fade_animation.dart';
import 'package:projecto_licenciatura/controllers/staticSignApi.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/Validation.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/signIn.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_home_view.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';



class  SignUpConstrutor extends StatefulWidget {
  int index;
  int indexSignIn;
  String label;
  Map userData;
  bool logged;
  Map dataReceive;
  String tipo;
  SignUpConstrutor({this.index,this.label,this.userData,this.dataReceive,this.logged,this.indexSignIn,this.tipo});

  @override
  _SignUpConstrutorState createState() => _SignUpConstrutorState();
}

class _SignUpConstrutorState extends State<SignUpConstrutor> {

  bool seePassword = true;
  bool isVisibleFun = false;
  TextEditingController _nome =TextEditingController();
  TextEditingController _email =TextEditingController();
  TextEditingController _bi =TextEditingController();
  TextEditingController _telefone =TextEditingController();
  TextEditingController _nrCasa =TextEditingController();
  TextEditingController _quarteirao =TextEditingController();
 String _valueCargo;
  TextEditingController _dataDNas =TextEditingController();
  String _provincia;
  String _localidade;
  TextEditingController _bairro =TextEditingController();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();


  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
 // final GlobalKey<AutoCompleteTextFieldState> _autoComplete = GlobalKey<AutoCompleteTextFieldState>();

  DateTime date = DateTime.now();
  bool autoValidate = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    if(widget.tipo == "Construtor") {
      isVisibleFun =true;
    }
    else{
      isVisibleFun=false;
    }
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
        Padding(
            padding: const EdgeInsets.symmetric( horizontal: 20 ),
            child: Container(
            child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Constants.title(context,text: widget.label),
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
                                                            label:"Nome",
                                                            icon:Icon(Icons.person,color:  Constants.KDefaultIconcolor),
                                                          function: (String value){setState(() {_nome.text=value;});}
                                                        )),
                                                        FadeAnimation( 1.3, Widgetsclass.makeinputEmail(
                                                            label:"Email",
                                                            icon:Icon(Icons.email,color:Constants.KDefaultIconcolor,),
                                                            email: _email.text,
                                                            hintText: "Por Favor introduza um email válido. ",
                                                            function: (String  value){setState(() {_email.text = value;});})),
                                                        FadeAnimation( 1.4,Widgetsclass.makeinputSenha(
                                                            label:"Senha",
                                                            ///readonly: false,
                                                            seePassword: seePassword,
                                                            funtionSenha: (){ setState((){seePassword = !seePassword;});},
                                                            icon:Icon( Icons.lock,color: Constants.KDefaultIconcolor,),
                                                            function: (value) {setState((){_pass.text = value;});},
                                                        )),
                                                        FadeAnimation( 1.5,Widgetsclass.makeinputSenha(
                                                            label:'confirme a senha',
                                                            //readonly: false,
                                                            icon:Icon( Icons.lock,color: Constants.KDefaultIconcolor,),
                                                            seePassword: seePassword,
                                                            function: (value){setState(() { _confirmPass.text = value; });},
                                                            funtionSenha: (){ setState(() { seePassword = !seePassword;});},
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
                                                                label:'Telefone ',
                                                                icon:Icon( Icons.phone_android, color: Constants.KDefaultIconcolor,),
                                                                function: (value) {setState(() {_telefone.text = value;});},
                                                            )),
                                                            FadeAnimation( 1.5, makeinputData(
                                                                "Data de Nascimento",
                                                                Icon( Icons.date_range, color: Colors.green, ) ) ),
                                                            FadeAnimation( 1.3, Widgetsclass.makeinputBI(
                                                                label:"BI",
                                                                icon:Icon( Icons.insert_drive_file, color: Constants.KDefaultIconcolor,),
                                                              funtion:(String value){
                                                                setState(() {
                                                                  _bi.text = value;
                                                                });
                                                              },
                                                            ) ),
                                                            //FadeAnimation(1.7, makeinputProv('Província',Icon(Icons.add_location, color: Colors.green,), elController:_suggestProvinceListController, seList:suggestProvinceList)),
                                                            FadeAnimation(1.4, makeinputProv()),
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
                                                                   makeinputloc(),
                                                                   FadeAnimation( 1.2,Widgetsclass.makeinputNumber(
                                                                       label:'Número da Casa',
                                                                       icon:Icon( Icons.home_outlined, color: Constants.KDefaultIconcolor),
                                                                       funtion: (value) {setState(() {_nrCasa.text = value;});},
                                                                       help: "Número da Casa Residente ",
                                                                   ) ),
                                                                   FadeAnimation( 1.3, Widgetsclass.makeinputNumber(
                                                                       label:'Quarteirão',
                                                                       icon:Icon( Icons.home_outlined, color: Constants.KDefaultIconcolor),
                                                                       funtion:(value) {setState(() {_quarteirao.text = value;});},
                                                                       help:"Número do seu Quarteirão "

                                                                   ) ),
                                                                   Visibility(
                                                                       visible: isVisibleFun,
                                                                       child: FadeAnimation(1.4, makeinputCargo())),
                                                                   SizedBox(height: 30,),
                                                                   FadeAnimation(1.5,Constants.makebutton(label: "Gravar",function: (){cadastroapi();})
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
    );
  }
  Widget makeinputProv()
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
                  hint: Text("Escolha a sua Provincia",),
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
                  onChanged :(value){ setState(() {_provincia= value;});},
              ),
            ),
            SizedBox(height: 5,),
          ]
      );
  }
  Widget makeinputloc()
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
                  hint: Text("Selecione a sua Localidade"),
                  dropdownColor: Colors.green[50],
                  elevation: 5,
                  icon: Icon(Icons.arrow_drop_down_sharp,color: Constants.KDefaultIconcolor,),
                  iconSize: 25.0,
                  underline: SizedBox(),
                  isExpanded: true,
                  value: _localidade,
                  items: Constants.suggestCityList.map((String loc) {return DropdownMenuItem<String>(value:loc,child: Text(loc));}).toList(),
                  onChanged :(value){ setState(() {_localidade = value;});}
              ),
            ),
            SizedBox(height: 5,),
          ]
      );
  }

  Widget makeinputCargo()
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
                  hint: Text("Selecione a sua profissão"),
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
               hintText: (date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString()),
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
      _dataDNas.text = date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString();
      print(date.toString());
    });
    }
  }

  Future<void >cadastroapi()
  async{
    UserCredential user;
    FirebaseAuth auth = FirebaseAuth.instance;
    if(_formkey.currentState.validate()) {

      setState(() {
        isLoading = true;
        autoValidate = false;
      });
      user = await auth.createUserWithEmailAndPassword(
          email: _email.text, password: _pass.text).then((user) async {
        setState(
                (){
              isLoading = false;
            });
        FirebaseUtils.postUserDatatoOb(
            nome: _nome.text,
            tipoUsuario: "Profissional",
            email: _email.text,
            senha: _pass.text,
            confPassword:_confirmPass.text,
            bi: _bi.text,
            telefone: _telefone.text,
            dataDNas: _dataDNas.text,
            nrCasa: _nrCasa.text,
            quarteirao: _quarteirao.text,
            provincia: _provincia,
            localidade: _localidade,
            cargo: _valueCargo,
            context: context,index: widget.index);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SignIn(index: widget.indexSignIn,)),
                (Route<dynamic> route) => false);

      }).catchError((onError) {
        print('msg: error' + onError.toString());
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error " + onError.toString());
      });
    }else{
      setState((){autoValidate = true;});
    }
  }
}
