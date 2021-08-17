import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/Animations/fade_animation.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';




class  Editar extends StatefulWidget {
  int index;
  Map mapUser;
  Editar({this.index,this.mapUser});

  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<Editar> {

String _valueCargo;
   TextEditingController _nome = TextEditingController();
   TextEditingController _email = TextEditingController();
   TextEditingController _bi = TextEditingController();
   TextEditingController _telefone = TextEditingController();
   TextEditingController _nrCasa = TextEditingController();
   TextEditingController _quarteirao = TextEditingController();
   TextEditingController _dataDNas = TextEditingController();
   TextEditingController _provincia = TextEditingController();
   TextEditingController _localidade = TextEditingController();

   var _suggestCityListController = new TextEditingController();
   var _suggestProvinceListController =  new TextEditingController();

  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  final GlobalKey<AutoCompleteTextFieldState> _autoComplete = GlobalKey<AutoCompleteTextFieldState>();
  bool isLoading = false;

  UserCredential user;
  FirebaseAuth auth = FirebaseAuth.instance;
  int selectedIndex = 0;
  DateTime date = DateTime.now();
  bool autoValidate = false;
  bool controllerOperation;

  List suggestCargoList = [
    "Pintor",
    "Serralheiro",
    "Marceneiro",
    "Pedreiro",
    "Ajudante",
    "Arquitecto",
    "Jardineiro",
    "carpinteiro",
    "Interressado"
  ];

  List suggestProvinceList = [
    "Maputo Cidade",
    "Maputo Provincia",
    "Gaza",
    "Imhambane",
    "Manica",
    "Sofala",
    "Tete",
    "Zambezia",
    "Niassa",
    "Cabo Delegado",
    "Nampula",
  ];

  List suggestCityList =[
    "Maputo Cidade",
    "Maputo Provincia",
    "Xai-Xai",
    "Imhambane",
    "chimoio",
    "Beira",
    "Tete",
    "Quelimane",
    "Lichinga",
    "Pemba",
    "Nampula",
  ];
   getUser() async {
     setState(() {
       isLoading = true;
     });
     _nome.text = widget.mapUser['nome'];
     _email.text =widget.mapUser['email'];
     _telefone.text =widget.mapUser['telefone'];
     _dataDNas.text =widget.mapUser['ddNascimento'];
     _bi.text =widget.mapUser['bi'];
     //_provincia =widget.mapUser[''];
   //  _nrCasa.text =widget.mapUser['nrCasa'];
     _quarteirao.text =widget.mapUser['quarteirao'];
     setState(() {
       isLoading = false;
     });
   }

@override
  void initState() {

  // TODO: implement initState
    super.initState();
    getUser();
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
                                                      FadeAnimation( 1.2, makeinputName("Nome", Icon(Icons.person,color:  Colors.green))),
                                                      FadeAnimation( 1.2, makeinputEmail("email", Icon(Icons.email,color:Colors.green,))),
                                                      FadeAnimation( 1.4,makeinputNumberTelefone('Telefone ', Icon( Icons.phone_android, color: Colors.green,))),
                                                      FadeAnimation( 1.5, makeinputData( "Data de Nascimento", Icon( Icons.date_range, color: Colors.green, ) ) ),
                                                //      FadeAnimation( 1.3,makeinputSenha("Senha",Icon( Icons.lock,color: Colors.green,))),
                                                 //     FadeAnimation( 1.8,makeinputConfSenha('confirme a senha',Icon( Icons.lock,color: Colors.green,))),
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
                                                            FadeAnimation( 1.3, makeinputBI( "Bi", Icon( Icons.insert_drive_file, color: Colors.green, ) ) ),
                                                            FadeAnimation(1.7, makeinputAutoCompleteTextFieldCity('Província',Icon(Icons.add_location, color: Colors.green,), elController:_suggestProvinceListController, seList:suggestProvinceList)),
                                                            FadeAnimation(1.8, makeinputAutoCompleteTextField('Localidade',Icon(Icons.add_location, color: Colors.green,),elController:_suggestCityListController, seList:suggestCityList)),
                                                            FadeAnimation( 1.1, makeinputNumberNrCasa( 'Numero da Casa', Icon( Icons.home_outlined, color: Colors.green, ) ) ),
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
                                                        FadeAnimation( 1.3, makeinputNumberQuarteirao( 'Quarteirao', Icon( Icons.home_outlined, color: Colors.green, ) ) ),
                                                        //FadeAnimation(1.4, makeinputCargo('Cargo')),
                                                        SizedBox(height: 30,),
                                                        FadeAnimation(1.4,Constants.makebutton(label: "Guardar",function:(){saveEdit();})),
                                                      ]), ),
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

  makeinputEmail(label,icon) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants.globalformat(label),
          TextFormField(
            controller :_email,
            onChanged: (String value) {setState(() {
              _email.text = value;
            });},
            decoration:Constants.globalformatField(icon),
            validator: (String value) {
              if (value.isEmpty) {
                return "campo obrigatório*";
              }
              if (!RegExp(r"[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-].[a-z]").hasMatch(
                  value)) {
                return 'Por favor, insira um endereço de e-mail válido';
              }
              return null;
            },
          ),
          SizedBox(height: 5,),
        ],
      );
  }


  makeinputData(String label,Icon icon)
  {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat(label),
            TextField(
              controller: _dataDNas,
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
  Widget makeinputCargo(String label)
  {   return
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants.globalformat(label),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[600],width: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.only(),
            child:
            DropdownButton(
              hint: Text("Escolha a sua Profissao",),
              dropdownColor: Colors.green[50],
              elevation: 5,
              icon: Icon(Icons.arrow_drop_down_sharp,color: Colors.green,),
              iconSize: 25.0,
              underline: SizedBox(),
              //isExpanded: true,
              value: _valueCargo,
              items: suggestCargoList.map((valueCargo){
                return DropdownMenuItem(value:valueCargo,child: Text(valueCargo)
                );
              }).toList(),
              onChanged :(value){
                setState(() {
                  _valueCargo = value;
                });},
            ),
          ),
          SizedBox(height: 30,),
        ]
    );
  }

  Widget makeinputNumberTelefone(label,Icon icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label),
        TextFormField(
            controller: _telefone,
            keyboardType: TextInputType.phone,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
            decoration: Constants.globalformatField(icon),
            onChanged: (value)
            {
              setState(() {
                _telefone.text = value;
              });},
            validator: (value){
              if(value.isEmpty)
              {
                return "Campo obrigatorio*";
              }
              if(label=='Telefone')
              {
                if(value.length==8)
                {
                  return "Numero invalido";
                }
              }
              return null;
            }),
        SizedBox(height: 5,),
      ],
    );
  }

  Widget makeinputNumberQuarteirao(label,Icon icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label),
        TextFormField(
          controller: _quarteirao,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
          decoration: Constants.globalformatField(icon),
          onChanged: (String value)
          {setState(() {
            _quarteirao.text = value;
          });
          },
          validator: (String value){
            if(value.isEmpty)
            {
              return "Campo obrigatorio*";
            }
            if(!RegExp(r"[0-9]").hasMatch(value))
            {
              return"Por favor, insira um numero valido";
            }
            return null;
          },
        ),
        SizedBox(height: 5,),
      ],
    );
  }
  //todo nao guarda na db
  Widget makeinputNumberNrCasa(label,Icon icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label),
        TextFormField(
          controller: _nrCasa,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
          decoration: Constants.globalformatField(icon),
          onChanged: (value)
          {
            setState(() {
              _nrCasa.text = value;
            });
          },
          validator: (value){
            if(value.isEmpty)
            {
              return "Campo obrigatorio*";
            }
            if(!RegExp(r"[0-9]").hasMatch(value))
            {
              return"Por favor, insira um numero valido";
            }
            return null;
          },
        ),
        SizedBox(height: 5,),
      ],
    );
  }
  Widget makeinputBI(String label, Icon icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label),
        TextFormField(
          controller: _bi,
          decoration: Constants.globalformatField(icon),
          onChanged: (String value){
            setState(() {
              _bi.text = value;
            });
          },
          validator: (String value){
            if(value.isEmpty)
            {
              return "Campo obrigatorio*";
            }
            if(value.length != 13)
            {
              return "Campo invalido";
            }
            if (!RegExp (r"[0-9]+[A-Z]").hasMatch(value)) {
              return  'Por favor, insira um BI válido' ;}
            return null;
          }, ),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget makeinputName(String label, Icon icon,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label),
        TextFormField(
          controller: _nome,
          decoration: Constants.globalformatField(icon),
          onChanged: (value) {setState((){_nome.text = value;});},
          validator: (String value){
            if(value.isEmpty)
            {
              return "Campo obrigatorio*";
            }
            if(value.length <= 2)
            {
              return "Nome Invalido";
            }
            return null;
          },

        ),
        SizedBox(height: 5,),
      ],
    );
  }


  Widget makeinputAutoCompleteTextFieldCity(String label,Icon icon,{elController, seList}) {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat(label),
            AutoCompleteTextField(
              // key: _autoComplete,
              //controller:  elController,
              clearOnSubmit: true,
              suggestions: seList,
              style: TextStyle(color: Colors.grey[900],fontSize: 16.0),
              decoration: Constants.globalformatField(icon),
              itemFilter: (item, query){
                return item.toLowerCase().startsWith(query.toLowerCase());
              },
              itemSorter: (a,b){
                return a.compareTo(b);
              },
              itemSubmitted: (item){
                elController.text = item;
                setState(() {
                  _provincia = item;
                });
              },
              itemBuilder: (context, item){
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    //colors: Colors.amberAccent,
                    children: [
                      Text(
                        item,style: TextStyle(
                          color: Colors.grey),
                      )
                    ],
                  ),
                );
              }, key: null,

            ),SizedBox(height: 5,),
          ]);
  }
  //todo nao guada na bd
  Widget makeinputAutoCompleteTextField(String label,Icon icon,{elController, seList}) {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat(label),
            AutoCompleteTextField(
              key: _autoComplete,
              //  controller:  elController,
              clearOnSubmit: true,
              suggestions: seList,
              style: TextStyle(color: Colors.grey[900],fontSize: 16.0),
              decoration: Constants.globalformatField(icon),
              itemFilter: (item, query){
                return item.toLowerCase().startsWith(query.toLowerCase());
              },
              itemSorter: (a,b){
                return a.compareTo(b);
              },
              itemSubmitted: (item){
                elController.text = item;
                setState(() {
                  _localidade = item;
                });
              },
              itemBuilder: (context, item){
                return Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    //colors: Colors.amberAccent,
                    children: [
                      Text(
                        item,style: TextStyle(
                          color: Colors.grey),
                      )
                    ],
                  ),
                );
              },
            ),SizedBox(height: 5,),
          ]);
  }
  Future<void >saveEdit()
  async{
    if(_formkey.currentState.validate()) {

      setState(() {
        isLoading = true;
        autoValidate = false;
      });
        updateUserDatatoOb();

  }}

  void updateUserDatatoOb() async{
    User firebaseUser = auth.currentUser;
    ClassModeloUsuario userModel = new ClassModeloUsuario();

    userModel.email =_email.text;
    userModel.nome =_nome.text;
    userModel.bi =_bi.text;
    userModel.telefone=_telefone.text;
    userModel.ddNascimento= _dataDNas.text;
    userModel.nrCasa=_nrCasa.text;
    userModel.quarteirao=_quarteirao.text;
    userModel.provincia =_provincia.text;
    userModel.localidade=_localidade.text;
    userModel.cargo =_valueCargo;

    userModel.userId = firebaseUser.uid;

    await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(firebaseUser.uid)
        .update(userModel.toMap());

    Fluttertoast.showToast(msg: "Editado");
    //await FirebaseUtils.updateFirebaseToken();
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Perfil_Home_view()));

   // sendVerificationEmail();
  }

  void sendVerificationEmail() async {
    User firebaseUser = auth.currentUser;
    await firebaseUser.sendEmailVerification();

    Fluttertoast.showToast(msg: "email Verification link has sent to your email.");

    Navigator.pop(context);

  }

// Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn())));
//        .catchError (e) {
//          if (e.code == 'User-not-found') {
//            print('No user found for that email');
//          }else if (e.code == 'wrong- password') {
//            print('Wrong password provided for that user');
//          }
//        }

}
