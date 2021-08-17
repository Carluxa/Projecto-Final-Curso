
/*
//main chat

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/views/Home_view/items/chat/Autenticate.dart';
import 'package:projecto_licenciatura/views/Home_view/items/chat/Helpper_function_chat.dart';
import 'package:projecto_licenciatura/views/Home_view/items/chat/chat_view.dart';
import 'package:projecto_licenciatura/views/Home_view/items/chat/chatroom_view.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(

      MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        accentColor: Color(0xff007EF4),
        fontFamily: "OverpassRegular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:// userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()
          //: Container(
        //child: Center(
          //child:
        Chat(),
       // ),
     // ),
    );
  }
}

*/
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/controllers/UserNotifier.dart';
import 'package:projecto_licenciatura/controllers/chat_Notifier_operation.dart';
import 'package:projecto_licenciatura/controllers/staticSignApi.dart';
import 'package:projecto_licenciatura/controllers/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
        MultiProvider(
            providers: [
          ChangeNotifierProvider(create: (_)=>PostNotifier()),
          ChangeNotifierProvider(create: (_)=>FirebaseUtils()),
          ChangeNotifierProvider(create: (_)=>ChatNotifier()),
          ChangeNotifierProvider(create: (_)=>UserNotifier()),
         ],
            child: MaterialApp (
                debugShowCheckedModeBanner:false,
                theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white),
                home:
                SplashScreen()
            )
        ),
      );
}




