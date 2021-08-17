import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/Animations/fade_animation.dart';
import 'package:projecto_licenciatura/controllers/staticSignApi.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/Validation.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/signIn.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';


class SignUpInterressados extends StatefulWidget {
  int index;
  int indexSignIn;
  String label;
  bool logged;
  Map dataReceive;
  SignUpInterressados({this.index,this.label,this.dataReceive,this.logged,this.indexSignIn});

  @override
  _SignUpInterressadosState createState() => _SignUpInterressadosState();
}
class _SignUpInterressadosState extends State<SignUpInterressados> {

  bool seePassword = true;
  TextEditingController _nome = TextEditingController( );
  TextEditingController _email = TextEditingController( );
  final TextEditingController _pass = TextEditingController( );
  final TextEditingController _confirmPass = TextEditingController( );
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>( );
  int selectedIndex = 0;
  bool autoValidate = false;
  bool isLoading = false;

  @override
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
                          Constants.title(context,text: widget.label),
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
                                                        function: (String value) {setState((){_nome.text = value;});
                                                        })),
                                                FadeAnimation( 1.2, Widgetsclass.makeinputEmail(
                                                  label:"Email",
                                                  icon:Icon(Icons.email,
                                                    color:Constants.KDefaultIconcolor,),
                                                  function: (String value) {setState(() {
                                                    _email.text = value;
                                                  });  },)),
                                                FadeAnimation( 1.3,Widgetsclass.makeinputSenha(
                                                    label:"Senha",
                                                    seePassword: seePassword,
                                                    //readonly: false,
                                                    icon:Icon( Icons.lock,color: Constants.KDefaultIconcolor,),
                                                    function: (value) {setState((){_pass.text = value;});},
                                                    funtionSenha: () {setState(() {seePassword = !seePassword;});
                                                })),
                                                FadeAnimation( 1.8,Widgetsclass.makeinputSenha(
                                                    label:'confirme a senha',
                                                    //readonly: false,
                                                    icon:Icon( Icons.lock,color: Constants.KDefaultIconcolor,),
                                                    seePassword: seePassword,
                                                    function: (value) {setState((){ _confirmPass.text = value;});},
                                                    funtionSenha: () { setState(() {seePassword = !seePassword;});},
                                                )),
                                                SizedBox(height: 20,),
                                                Constants.makebutton(label: widget.label,function: (){cadastroapi();}),
                                                ],)
                                                    ] ), ), ),
                                            ], )
                                      )
                                    ] ),
                              ) ) )
                    ] ) ) )
    );
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

        setState((){isLoading = false;});

        FirebaseUtils.postUserDatatoOb(

             email: _email.text,
             nome: _nome.text,
             senha: _pass.text,
             tipoUsuario: "Interressado",
             confPassword: _confirmPass.text,
             context: context,
             index: widget.index,
             bi: "",
             telefone: "",
             dataDNas: "",
             nrCasa: "",
             quarteirao: "",
             provincia:"",
             localidade: "",
             cargo: "",
        );
        print("================================>$widget.indexSignIn");
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