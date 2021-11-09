import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/Animations/fade_animation.dart';
import 'package:projecto_licenciatura/controllers/UserNotifier.dart';
import 'package:projecto_licenciatura/controllers/userController.dart';
import 'package:projecto_licenciatura/views/%20Chat/chat/Show_user.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/SetUpCadastros/SignUp.dart';
import 'package:projecto_licenciatura/controllers/staticSignApi.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/Validation.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_home_view.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  FirebaseUtils changeStatus;
  bool logged=false;
  int index;
  Map dataReceive;
  SignIn({this.changeStatus,this.logged,this.index,this.dataReceive});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email, _password;
  bool _isvisible = true;
  final GlobalKey<FormState>_formkey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _seePassword = true;
  Map snp;

  Future<void>checkcurrentUserM () async {
    User auth= FirebaseAuth.instance.currentUser;
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection( 'usuarios' )
          .doc( auth.uid ).get( );
      Map<String, dynamic> dataReceive = snapshot.data( );
      snp = dataReceive;
    }catch(e)
    {
      print("o erro de login $e");
    }
  }

  @override
  void initState() {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    getUser(userNotifier);
    print("------------------->${userNotifier.userList}");
    super.initState();

    checkcurrentUserM();
  }
  User  user = FirebaseAuth.instance.currentUser;
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
           widget.index==1?!widget.logged?bodyMethod(): Post_home_view(snpData: widget.dataReceive, ):
               widget.index==2?!widget.logged?bodyMethod():Perfil_Home_view(id:user.uid):
                   widget.index==3?!widget.logged?bodyMethod():show_user():Text("")
    );
  }


   Widget bodyMethod()
  {return
    _isLoading?
    Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.green[50],
          strokeWidth: 2,)): Visibility(
      visible: _isvisible,
         child: Container(
            color: Colors.black87,
            child:
                  Container(
                     width: double.infinity,
                     padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                     margin: EdgeInsets.symmetric(vertical: 150, horizontal: 20),
                     decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(20),
                       color: Colors.green[50],
                      boxShadow: [
                         BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 10),
                            blurRadius: 20)
                            ],),
                    child: ListView(
                      children:[
                        Column(
                         children:[
                             Row(
                               children: [
                                 Text("Login",style: Theme.of(context).textTheme.headline5,),
                                 // IconButton(
                                 //   alignment: Alignment(59.0,-3.0),
                                 //   onPressed:(){ Navigator.push( context,
                                 //       MaterialPageRoute( builder: (_) =>document_view()) );},
                                 //   icon: Icon (Icons.close),color: Colors.red,),
                               ],
                             ),
                             SizedBox(height: 10,),
                               Form(
                                   key: _formkey,
                                      child: Column(
                                        children:[
                                        SizedBox(height: 30,),
                                        FadeAnimation(1.1, Widgetsclass.makeinputEmail(
                                            label:"Email",
                                            icon:Icon(Icons.email_outlined , color: Constants.KDefaultIconcolor,),
                                            function: (String  value){setState(() {_email = value;});})),
                                        SizedBox(height: 20,),
                                        FadeAnimation(1.1, Widgetsclass.makeinputSenha(
                                            label:"Senha",
                                            readonly: false,
                                            icon:Icon(Icons.lock,color: Constants.KDefaultIconcolor),
                                            function: (value) {setState((){_password = value;});},
                                            funtionSenha:  (){setState(() {_seePassword =! _seePassword;});},
                                            seePassword: _seePassword,
                                        )),
                                        SizedBox(height: 20,),
                                       ]),),
                           Constants.makebutton(label: "Entrar",function: (){login();}),
                           SizedBox(height: 20,),
                           Container(
                             child:
                             GestureDetector(
                                 onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>SignUp(dataReceive:widget.dataReceive, index: widget.index)));},
                                 child: Text('Cadastre aqui',)),
                             alignment: Alignment.centerRight,
                           )
                         ]),
                    ]),
        ),
      ),
    );
  }


  void login () async {

    if (_formkey.currentState.validate()) {
      setState( () {
        _isLoading = true;
        // widget.isVisibleLogin =!widget.isVisibleLogin;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email,
            password: _password
        );
        setState(
                (){
              _isLoading = false;
              _isvisible = false;
                });
        Fluttertoast.showToast( msg: "Login Success" );
        if (widget.index == 1) {
          Navigator.push( context,
              MaterialPageRoute( builder: (_) =>
                  Post_home_view( ) ) );
        } else if (widget.index == 2) {
          Navigator.push( context,
              MaterialPageRoute( builder: (_) =>
                  Perfil_Home_view(id:user.uid)));
        } else if (widget.index == 3) {
          Navigator.push( context,
              MaterialPageRoute( builder: (_) => show_user( ) ) );
        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
  /*
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email, password: _password ).
        then( (user) async {
          setState(
                  (){
                _isLoading = false;
                _isvisible = false;
               // widget.changeStatus.changeStatus( );

          if(user!=null) {
            Fluttertoast.showToast( msg: "Login Success" );
            if (widget.index == 1) {
              Navigator.push( context,
                  MaterialPageRoute( builder: (_) =>
                      Post_home_view( ) ) );
            } else if (widget.index == 2) {
              Navigator.push( context,
                  MaterialPageRoute( builder: (_) =>
                      Perfil_Home_view( snp: snp, ) ) );
            } else if (widget.index == 3) {
              Navigator.push( context,
                  MaterialPageRoute( builder: (_) => Show_user( ) ) );
            }
            print("------------------------------->$user");
          }else{
            print("user iguals null  $user");
          }
                  });
          //await FirebaseUtils.updateFirebaseToken( );
        } ).catchError( (onError) {
          setState( () {
            _isLoading = false;
          } );
          // authProblems errorType;
          // switch (onError.message) {
          //   case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          //     errorType = authProblems.UserNotFound;
          //     break;
          //   case 'The password is invalid or the user does not have a password.':
          //     errorType = authProblems.PasswordNotValid;
          //     break;
          //   case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          //     errorType = authProblems.NetworkError;
          //     break;
          // // ...
          //   default:
          //     print( 'Case----------> ${onError.message} is not yet implemented' );
          // }
//          Fluttertoast.showToast( msg: "error " + onError.toString() ,timeInSecForIosWeb: 60);
        } );
*/
      }
    else
      {
        print("not in");
      }
    }
  }
