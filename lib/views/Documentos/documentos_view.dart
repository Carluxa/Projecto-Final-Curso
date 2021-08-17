
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:projecto_licenciatura/views/Documentos/PDF_view.dart';
import 'package:projecto_licenciatura/controllers/pdf_api.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:projecto_licenciatura/views/Login/Setup_login/signIn.dart';


class document_view extends StatefulWidget{
 // int index;
  document_view();

  @override
  _document_viewState createState() => _document_viewState();

  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  // TODO: implement context
  BuildContext get context => throw UnimplementedError();

  @override
  void deactivate() {
    // TODO: implement deactivate
  }

  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  // TODO: implement mounted
  bool get mounted => throw UnimplementedError();

  @override
  void reassemble() {
    // TODO: implement reassemble
  }

  @override
  void setState(fn) {
    // TODO: implement setState
  }

  @override
  // TODO: implement widget
  StatefulWidget get widget => throw UnimplementedError();
}

class _document_viewState extends State<document_view> {
  bool isvisible = false;
  int currentIndex = 0;
  bool isVisibleLogin = false;
 // Map dataReceive;
  List<String> items = List<String>.generate( 10000, (i) => "Item $i" );

  setVisibleLogin() {
    setState( () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          isVisibleLogin = false;
        }
        else {
          isVisibleLogin = true;
          //print( user );
        }
      } );
    } );
  }
 Map snp;

  Future<void>checkcurrentUserM () async {
   // FirebaseAuth auth =
    User auth =FirebaseAuth.instance.currentUser;
      try {
        var snapshot = await FirebaseFirestore.instance
            .collection( 'usuarios' )
            .doc( auth.uid ).get( );
        Map<String, dynamic> dataReceive = snapshot.data( );
        snp = dataReceive;
        print( snp );
      }catch(e){
        print("O errro do document $e");
      }
  }

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    setVisibleLogin();
    if(!isVisibleLogin)
      {
        checkcurrentUserM();
      }

  }

  @override
  void dispose() {
    super.dispose( );
    _controller.dispose( );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.green[100],
        title: Text.rich(
          TextSpan(
            text: "Documentos",
            style: Theme
                .of( context )
                .textTheme
                .headline4
                .copyWith( color: Colors.grey[900] ),
          ),
        ),
        centerTitle: true,
        //leading: IconButton( icon: Icon(Icons.person_add, size: 25, color: Colors.black,),
        //   onPressed: (){
        //     Navigator.pop(context);
        //   },
      ),
      body: listDocuments( context ), );
  }


  Widget listDocuments(BuildContext context) {
    return
      Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all( 15.0 ),
                  child: Container(
                    child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all( 10.0 ),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: ListView(
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child:
                                            Card(
                                              shadowColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular( 20 ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.grey[100],
                                              child: GestureDetector(
                                                onTap: () async {
                                                  final path = 'assets/documents/PassosTerreno.pdf';
                                                  final file = await PDFApi
                                                      .loadAsset( path );
                                                  openPDF( context, file );
                                                },
                                                child:
                                                Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons.picture_as_pdf,color: Colors.red),
                                                        title: const Text('Legalizacao do Terreno'),
                                                        subtitle: Text('Passos a seguir no processo da Legalizacao',
                                                          style: TextStyle(color: Colors.black.withOpacity(0.6))),
                                                      )
                                                    ])))),
                                          Container(
                                            alignment: Alignment.center,
                                            child:
                                            Card(
                                              shadowColor: Colors.red,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular( 20 )),
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.grey[100],
                                              child:
                                              GestureDetector(
                                                onTap: () async {
                                                  final path = 'assets/documents/DUAT.pdf';
                                                  final file = await PDFApi
                                                      .loadAsset( path );
                                                  openPDF( context, file );
                                                },
                                                child:
                                                Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons.picture_as_pdf,color: Colors.red,),
                                                        title: const Text('DUAT'),
                                                        subtitle: Text('Direito de Uso e Aproveitamento de Terra',
                                                          style: TextStyle(
                                                              color: Colors.black.withOpacity(0.6))),
                                                      )]),
                                                     ),
                                                )),
                                          Container(
                                            alignment: Alignment.center,
                                            child:
                                               Card(
                                                shadowColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular( 20 )),
                                                clipBehavior: Clip.antiAlias,
                                                color: Colors.grey[100],
                                                child: GestureDetector(
                                                  onTap: () async {
                                                  final path = 'assets/documents/AutorizacaoProvisoria.pdf';
                                                  final file = await PDFApi.loadAsset( path );
                                                   openPDF( context, file );
                                                  },
                                                  child:
                                                   Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons.picture_as_pdf,color: Colors.red,),
                                                        title: const Text('AP' ),
                                                        subtitle: Text('Autorização provisória ',
                                                          style: TextStyle(
                                                              color: Colors.black.withOpacity(0.6))),
                                                      )
                                                    ]),),
                                               )),
                                           Container(
                                             alignment: Alignment.center,
                                             child:
                                             Card(
                                              shadowColor: Colors.red,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular( 20 )),
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.grey[100],
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState( () {
                                                    isvisible = !isvisible;
                                                  } );
                                                },
                                                // onTap: () async {
                                                //   final path = 'assets/documents/simples.pdf';
                                                //   final file = await PDFApi.loadAsset(path);
                                                //   openPDF(context, file);},
                                                child:
                                                Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons.picture_as_pdf,
                                                          color: Colors.red,),
                                                        trailing: Icon(
                                                          Icons.arrow_drop_down,
                                                          color: Colors.red,),
                                                        title: const Text(
                                                            'Titulação' ),
                                                      )
                                                    ]
                                                ),
                                              ),
                                            ), ),
                                          Visibility(
                                            visible: isvisible,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child:
                                              Card(
                                                  shadowColor: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular( 5 ),
                                                  ),
                                                  clipBehavior: Clip.antiAlias,
                                                  color: Colors.grey[100],
                                                  child:
                                                  Column(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () async {
                                                              final path = 'assets/documents/titulo.pdf';
                                                              final file = await PDFApi
                                                                  .loadAsset(
                                                                  path );
                                                              openPDF( context,
                                                                  file );
                                                            },
                                                            child:
                                                            ListTile(
                                                              leading: Icon(
                                                                Icons
                                                                    .picture_as_pdf,
                                                                color: Colors
                                                                    .red, ),
                                                              title: const Text(
                                                                  'Titulação do DUAT' ),
                                                            ) ),
                                                        GestureDetector(
                                                            onTap: () async {
                                                              final path = 'assets/documents/Direitosdostitulares.pdf';
                                                              final file = await PDFApi
                                                                  .loadAsset(
                                                                  path );
                                                              openPDF( context,
                                                                  file );
                                                            },
                                                            child:
                                                            ListTile(
                                                              leading: Icon(
                                                                Icons
                                                                    .picture_as_pdf,
                                                                color: Colors
                                                                    .red, ),
                                                              title: const Text(
                                                                  'Direitos dos titulares' ),
                                                            ) ),
                                                        GestureDetector(
                                                            onTap: () async {
                                                              final path = 'assets/documents/deveresDuat.pdf';
                                                              final file = await PDFApi
                                                                  .loadAsset(
                                                                  path );
                                                              openPDF( context,
                                                                  file );
                                                            },
                                                            child:
                                                            ListTile(
                                                              leading: Icon(
                                                                Icons
                                                                    .picture_as_pdf,
                                                                color: Colors
                                                                    .red, ),
                                                              title: const Text(
                                                                  'Deveres dos titulares' ),
                                                            ) )

                                                      ]
                                                  )
                                              ), ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child:
                                            Card(
                                              shadowColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular( 20 ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.grey[100],
                                              child: GestureDetector(
                                                onTap: () async {
                                                  final path = 'assets/documents/ParecerAdministrativo.pdf';
                                                  final file = await PDFApi
                                                      .loadAsset( path );
                                                  openPDF( context, file );
                                                },
                                                child:
                                                Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons.picture_as_pdf,color: Colors.red,),
                                                        title: const Text('Parecer da Administração'),
                                                        subtitle: Text('Parecer da Administração do Distrito e consulta às comunidades locais',
                                                          style: TextStyle(color: Colors.black.withOpacity(0.6))),
                                                      )
                                                    ]
                                                ),
                                              ),
                                            )),

                                          Container(
                                            alignment: Alignment.center,
                                            child:
                                            Card(
                                              shadowColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular( 20 ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.grey[100],
                                              child: GestureDetector(
                                                onTap: () async {
                                                  final path = 'assets/documents/Demarcação.pdf';
                                                  final file = await PDFApi
                                                      .loadAsset( path );
                                                  openPDF( context, file );
                                                },
                                                child:
                                                Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons.picture_as_pdf,
                                                          color: Colors.red, ),
                                                        title: const Text(
                                                            'Demarcação' ),
                                                        subtitle: Text(
                                                          'Processo técnico relativo à  demarcação',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                  0.6 ) ), ),
                                                      )
                                                    ]
                                                ),
                                              ),
                                            ), ), Container(
                                            alignment: Alignment.center,
                                            child:
                                            Card(
                                              shadowColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular( 20 ),
                                              ),
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.grey[100],
                                              child: GestureDetector(
                                                onTap: () async {
                                                  final path = 'assets/documents/ValordasTaxas.pdf';
                                                  final file = await PDFApi
                                                      .loadAsset( path );
                                                  openPDF( context, file );
                                                },
                                                child:
                                                Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons.picture_as_pdf,
                                                          color: Colors.red, ),
                                                        title: const Text(
                                                            'Pagamento' ),
                                                        subtitle: Text(
                                                          'Taxas necessarias',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                  0.6 ) ), ),
                                                      )
                                                    ]
                                                ),
                                              ),
                                            ), ),
                                        ],
                                      )
                                  )
                                ]
                            ), ),

                          Align( alignment: Alignment.bottomCenter,
                              child: buttonCustom( ) ),
                        ]
                    ), ), ),
              ),
            ] ), );
  }

  Widget buttonCustom() {
    return
      CustomNavigationBar(
          scaleFactor: 0.5,
          iconSize: 30.0,
          selectedColor: Constants.KWhite,
          strokeColor: Constants.KWhite,
          unSelectedColor: Colors.grey[600],
          backgroundColor: Constants.KDefaultBakMenu,
          borderRadius: Radius.elliptical( 50, 50 ),
          blurEffect: true,
          opacity: 0.8,
          isFloating: true,
          items: [
            CustomNavigationBarItem(
                icon: Icon( Icons.home, color: Colors.black, ),
                title: Text( "Home" )
            ),
            CustomNavigationBarItem(
                icon: Icon( Icons.post_add_outlined, color: Colors.black, ),
                title: Text( "Publicacao" )
            ),
            CustomNavigationBarItem(
                icon: Icon( AntDesign.user, color: Colors.black ),
                title: Text( "Perfil" )
            ),
            CustomNavigationBarItem(
                icon: Icon( AntDesign.wechat, color: Colors.black ),
                title: Text( "Conversa" )
            ),
          ],
          currentIndex: currentIndex,
          onTap: (index) {
            setState( () {
              currentIndex = index;
              if (currentIndex == 0) {
                Navigator.push( context,
                    MaterialPageRoute( builder: (_) => document_view( ) ) );
              }
              if (currentIndex == 1) {
                Navigator.push( context,
                    MaterialPageRoute( builder: (_) =>
                        SignIn(
                          index: currentIndex, logged: isVisibleLogin,dataReceive: snp, ) ) );
              }
              if (currentIndex == 2) {
                Navigator.push( context,
                    MaterialPageRoute( builder: (_) =>
                        SignIn(
                          index: currentIndex, logged: isVisibleLogin,dataReceive: snp, ) ) );
              }
            });
            if (currentIndex == 3) {
              Navigator.push( context,
                  MaterialPageRoute( builder: (_) =>
                      SignIn(
                        index: currentIndex, logged: isVisibleLogin, ) ) );
            }
          });
  }

  // ignore: non_constant_identifier_names
  // Future<void> checkcurrentUserM () async {
  //   var snapshot = await FirebaseFirestore.instance
  //       .collection('usuarios')
  //       .doc(FirebaseAuth.instance.currentUser.uid).get();
  //   Map<String, dynamic> data = snapshot.data();
  //   dataReceive = data;
  //   //nome = data['nome'];
  //
  // }



    void openPDF(BuildContext context, File file) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
    );

}
