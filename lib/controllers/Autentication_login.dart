//
//
// import 'dart:async';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
//
//
// class Autentication extends StatefulWidget {
//   _AutenticationState createState() => _AutenticationState();
// }
//
//
// class _AutenticationState extends State<Autentication> {
//
//   @override
//   final auth = FirebaseAuth.instance;
//   User user;
//   Timer timer;
//
//   void initState() {
//     setState( () {
//       user = auth.currentUser;
//       user.sendEmailVerification( );
//       timer = Timer.periodic( Duration( seconds: 1 ), (timer) {
//         checkEmailVerifired( );
//       } );
//     } );
//
//     super.initState( );
//   }
//
//   void dispose() {
//     timer.cancel( );
//     super.dispose( );
//   }
//
//   Stream<User> get authStateChanges => auth.idTokenChanges( );
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: Text( 'Loading' )
//       ),
//     );
//   }
//
// //Terminar sessao
//   Future<void> signOut() async {
//     await auth.signOut( );
//   }
//
//   //Todo verifiation
//
//   Future<void> checkEmailVerifired() async {
//     user = auth.currentUser;
//     await user.reload( );
//     if (user.emailVerified) {
//       timer.cancel( );
//       //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));}
//       if (!user.emailVerified) {
//         print( 'Email exist' );
//       }
//     }
//   }
//
// }
