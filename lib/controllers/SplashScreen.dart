import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/Animations/fade_animation.dart';
import 'package:projecto_licenciatura/views/Documentos/documentos_view.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
       Navigator.of(context)
           .pushReplacement(MaterialPageRoute(builder: (_) => document_view()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeAnimation(1.1, Text('BemVindo',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.blue[900], ), )),
            SizedBox(width: 28,),
            FadeAnimation(1.2, Text('Bemvindo a doce construcao',
            textAlign: TextAlign.center ,
            style: TextStyle( color: Colors.grey, fontSize: 15,), )),
            // logo here
            SizedBox(height: 50,),
            FadeAnimation(1.3, Image.asset(
              'assets/images/house1.png',
              height: 200,
            ),),
            SizedBox(
              height: 20,
            ),
            FadeAnimation(1.4,CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]),
            )
            ),],
        ),
      ),
    );
  }
}
