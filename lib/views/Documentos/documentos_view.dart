
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:projecto_licenciatura/views/Documentos/PDF_view.dart';
import 'package:projecto_licenciatura/controllers/pdf_api.dart';
import 'package:projecto_licenciatura/views/Documentos/TextDocuments.dart';
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
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(context,MaterialPageRoute(builder: (_) =>
                                              TextDocuments(
                                                    textTitle: "Legaliza????o de um terreno",
                                                    text2: "",
                                                    titletext1: "Passos a Seguir\n",
                                                    titletext2: "",
                                                    text1: "Diagrama que explica qual ?? a sequ??ncia de ac????es a seguir para a legaliza????o de um terreno de uma forma geral, nos campos as seguir explica detalhadamente os cada processo",
                                                    onpressedPdf: () async{
                                                    final path = 'assets/documents/PassosTerreno.pdf';
                                                    final file = await PDFApi
                                                        .loadAsset( path );
                                                    openPDF(context, file );
                                                  },
                                                diagrama: "assets/images/diagramaPng.png",
                                                 )));
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
                                              InkWell(
                                                onTap: () async {
                                                  Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                    textTitle: "DUAT",
                                                    titletext1: "Direito de Uso e Aproveitamento de Terra",
                                                    text1:"A taxa referente ao Direito de uso e aproveitamento de terra, a autoriza????o definitiva s??o de 300 meticais.",
                                                    titletext2: "Conte??do do DUAT",
                                                    text2:"a)Documento de identifica????o do requerente, se for pessoa singular, e Estatutos, no caso de se tratar de pessoa colectiva;\n\nb)	Esbo??o da localiza????o do terreno;\n\nc)	Mem??ria descritiva;\n\nd)	Indica????o da natureza e dimens??o do empreendimento que o requerente se prop??e realizar;\n\ne)	Parecer do administrador do Distrito, precedido de consulta ?? comunidade local;\n\nf)	Edital e comprovativo da sua afixa????o na sede do respectivo distrito e no pr??prio local, durante um per??odo de trinta dias;\n\ng)	Guia comprovativa de dep??sito para pagamento da taxa de autoriza????o provis??ria.",
                                                    onpressedPdf: () async {
                                                      final path = 'assets/documents/DUAT.pdf';
                                                      final file = await PDFApi
                                                          .loadAsset( path );
                                                      openPDF( context, file );
                                                    },
                                                  )));
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
                                                child: InkWell(
                                                  onTap: () async {
                                                    Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                      textTitle: "Autoriza????o provis??ria",
                                                      titletext1: "Autoriza????o provis??ria",
                                                      text1: "\n?? um documento emitido ap??s a apresenta????o do pedido de uso e aproveitameto da terra. Tem a dura????o de 5 anos para cidad??o nacionais e 2 anos para cidad??o estrangeiro, com a taxa de 600 meticais.",
                                                      titletext2: "",
                                                      text2: "Conte??do do autoriza????o provis??ria:\na)	Identifica????o da entidade que autorizou o pedido e data do despacho de autoriza????o;\n\nb)	N??mero da autoriza????o;\n\nc)	Identifica????o do requerente;\n\nd)	Esbo??o, ??rea, localiza????o e n??mero de identifica????o da parcela no registo cadastral;\n\ne)	Prazo da autoriza????o provis??ria;\n\nf)	Tipo ou tipos de explora????o para que foi concedida a autoriza????o;\n\ng)	Taxas devidas;\n\nh)	Data e local da emiss??o;\n\ni)	Assinatura do respons??vel pelos servi??os que emitem a autoriza????o e respectiva chancela.",
                                                      onpressedPdf: () async {
                                                        final path = 'assets/documents/AutorizacaoProvisoria.pdf';
                                                        final file = await PDFApi.loadAsset( path );
                                                        openPDF( context, file );
                                                      },
                                                    )));

                                                  },
                                                  child:
                                                   Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons.picture_as_pdf,color: Colors.red,),
                                                        title: const Text('AP' ),
                                                        subtitle: Text('Autoriza????o provis??ria ',
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
                                                            'Titula????o' ),
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
                                                        InkWell(
                                                            onTap: () async {
                                                              Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                                textTitle: "Titula????o do DUAT",
                                                                titletext1: "Processo de titula????o do DUAT\n",
                                                                text1: "Titulo ?? emitido pelos Servicos Publicos de Cadastro,gerais ou urbanos, que comprova o direito de uso e aproveitamento da terra, inclui o parecer das actividades administrativas locais, e consulta as respectivas comunidades,",
                                                                titletext2: "Elementos que constaram no  t??tulo:\n",
                                                                text2: "a)	Identifica????o da entidade que autorizou o pedido de  emiss??o do t??tulo e data do despacho de autoriza????o;\n\nb)	N??mero do t??tulo;\n\nc)	Identifica????o do titular;\n\nd)	??rea e sua defini????o geom??trica, com as respectivas coordenadas, localiza????o, n??meros de identifica????o das parcelas confrontantes;\n\ne)	Prazo a que estiver sujeito o direito de uso e aproveitamento da terra;\n\nf)	Tipo ou tipos de explora????o para que foi adquirido o direito de uso e aproveitamento da terra;\n\ng)	Descri????o das benfeitorias existentes;\n\nh)	Taxas devidas;\n\ni)	Data e local da emiss??o;\n\nAssinatura do respons??vel pelos Servi??os que emitem o t??tulo e respectiva chancela",
                                                                onpressedPdf: () async {
                                                                  final path = 'assets/documents/titulo.pdf';
                                                                  final file = await PDFApi.loadAsset( path );
                                                                  openPDF( context, file );
                                                                },
                                                              )));
                                                            },
                                                            child:
                                                            ListTile(
                                                              leading: Icon(
                                                                Icons
                                                                    .picture_as_pdf,
                                                                color: Colors
                                                                    .red, ),
                                                              title: const Text(
                                                                  'Titula????o do DUAT' ),
                                                            ) ),
                                                        InkWell(
                                                            onTap: () async {
                                                              Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                                textTitle: "Direitos dos titulares",
                                                                titletext1: "Direitos dos titulares",
                                                                text1: "Direitos dos titulares do direito de uso e aproveitamento da terra, seja adquirido por ocupa????o, seja por autoriza????o de um pedido:\n\na)	Defender ???se contra qualquer intrus??o de uma segunda parte;\n\nb)	Ter acesso ?? sua parcela e aos recursos h??dricos de uso p??blico atrav??s das parcelas vizinhas, constituindo para o efeito as necess??rias servid??es.\n\nc)	Os requerentes ou titulares do direito de uso e aproveitamento da terra podem apresentar certid??o da autoriza????o provis??ria ou do t??tulo ??s institui????es de cr??dito, no contexto de pedido de empr??stimos.",
                                                                titletext2: "",
                                                                text2: "",
                                                                onpressedPdf: () async {
                                                                  final path = 'assets/documents/Direitosdostitulares.pdf';
                                                                  final file = await PDFApi.loadAsset( path );
                                                                  openPDF( context, file );
                                                                },
                                                              )));
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
                                                        InkWell(
                                                            onTap: () async {
                                                              Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                                textTitle: "Deveres dos titulares do DUAT:",
                                                                titletext1: "Deveres dos titulares do DUAT:",
                                                                text1: "",
                                                                titletext2: "",
                                                                text2: "a)	Utilizar a terra respeitando os princ??pios definidos na Constiui????o e demais legisla????o em vigor e  no caso do exerc??cio de actividades econ??micas em conformidade com os planos de explora????o. \n\nb)	Dar acesso atrav??s da sua parcela aos vizinhos que n??o tenham comunica????o com a via p??blica ou com os recursos h??dricos de uso p??blico. \n\nc)	Respeitar as servid??es relativas a vias de acesso p??blico ou comunit??rio e passagens para o gado, estabelecidas por pr??ticas costumeiras; \n\nd)	Permitir a execu????o de opera????es e/ou instala????o de acess??rios e equipamento conduzidas ao abrigo de lincen??a de prospec????es e pesquisa mineira, concess??o mineira ou certificado mineiro, mediante justa indeminiza????o; \n\ne)	Manter os marcos de fronteiras, de triangula????o, de demarca????o cadastral e outros que sirvam de pontos de refer??ncia;",
                                                                onpressedPdf: () async {
                                                                  final path = 'assets/documents/deveresDuat.pdf';
                                                                  final file = await PDFApi.loadAsset( path );
                                                                  openPDF( context, file );
                                                                },
                                                              )));
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
                                              child: InkWell(
                                                onTap: () async {
                                                  Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                    textTitle: "Parecer da Administra????o",
                                                    titletext1: "Parecer da Administra????o do Distrito e consulta ??s comunidades locais",
                                                    text1: "",
                                                    titletext2: "",
                                                    text2: "Parecer da administra????o o distrito e consulta ??s comunidades locais falado no do processo relativo DUART adquirida por ocupa????o:\n\n1.	Os servi??os de Cadastro envir??o ao Administrador do respectivo distrito um exemplar do pedido, para efeitos de afixa????o do respectivo Edital e obten????o do seu parecer, prestando-lhe a assist??ncia t??cnica necess??ria para a recolha de informa????es sobre o terreno pretendido e os terrenos lim??trofes.\n\n2.	Ser?? feito um trabalho conjunto, envolvendo os Servi??os de Cadastro, o Administrador do Distrito ou seu representante e as comunidades locais. O resultado desse trabalho ser?? reduzido a escrito e assinado por um minimo de tr??s e um m??ximo de nove representantes da comunidade local, bem como pelos titulares ou ocupantes dos terrenos lim??trofes.\n\n3.	O parecer do Administrador do Distrito incidir?? sobre a exist??ncia ou n??o, na ??rea requerida, do DUAT adquirido por ocupa????o. Caso sobre a ??rea requerida recaiam outros direitos, o parecer incluir?? os termos pelos quais se reger?? a parceria entre os titulares do direito de uso e aproveitamento da terra adquirido por ocupa????o e o requerente.\n\n\nTaxas referentes ao parecer Administrativo e consulta as comunidades locais",
                                                    onpressedPdf: () async {
                                                      final path = 'assets/documents/ParecerAdministrativo.pdf';
                                                      final file = await PDFApi.loadAsset( path );
                                                      openPDF( context, file );
                                                    },
                                                  )));
                                                },
                                                child:
                                                Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(Icons.picture_as_pdf,color: Colors.red,),
                                                        title: const Text('Parecer da Administra????o'),
                                                        subtitle: Text('Parecer da Administra????o do Distrito e consulta ??s comunidades locais',
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
                                              child: InkWell(
                                                onTap: () async {
                                                  Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                    textTitle: "Demarca????o",
                                                    titletext1: "Processo t??cnico relativo ??  demarca????o",
                                                    text1: "1.	Emitida a autoriza????o provis??ria, os Servi??os de Cadastro notificar??o o requerente para a comunica????o do despacho e para a necessidade de fazer a demarca????o;\n\n2.	Ap??s a notifica????o, o requente dever?? proceder ?? demarca????o no prazo de um ano, seja por via oficial, atrav??s dos Servi??os de Cadastro.\n\n3.	Findo o prazo de um ano sem que tenha sido apresentado o respectivo processo t??cnico e n??o tenha sido recebida uma justifica????o aceit??vel pelos Servi??os de Cadastro, estes notificar??o o requerente do iminente cancelamento da autoriza????o provis??ria.\n\n4.	O requerente poder?? solicitar que, em vez do cancelamento, lhe seja prorrogado o prazo por mais noventa dias. Este segundo prazo ?? improrrog??vel.",
                                                    titletext2: "",
                                                    text2: "",
                                                    onpressedPdf: () async {
                                                      final path = 'assets/documents/Demarca????o.pdf';
                                                      final file = await PDFApi.loadAsset( path );
                                                      openPDF( context, file );
                                                    },
                                                  )));
                                                },
                                                child:
                                                Column(
                                                    children: [
                                                      ListTile(
                                                        leading: Icon(
                                                          Icons.picture_as_pdf,
                                                          color: Colors.red, ),
                                                        title: const Text('Demarca????o'),
                                                        subtitle: Text('Processo t??cnico relativo ??  demarca????o',
                                                          style: TextStyle(color: Colors.black.withOpacity(0.6)),),)
                                                    ]),
                                              ),),),
                                          Container(
                                            alignment: Alignment.center,
                                            child:
                                            Card(
                                              shadowColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular( 20 ),),
                                              clipBehavior: Clip.antiAlias,
                                              color: Colors.grey[100],
                                              child: InkWell(
                                                onTap: () async {
                                                  Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                    textTitle: "Valor das Taxas",
                                                    titletext1: "Valor das Taxas",
                                                    text1: "1.Emitida a autoriza????o provis??ria, os Servi??os de Cadastro notificar??o o requerente para a comunica????o do despacho e para a necessidade de fazer a demarca????o;\n\n 2.Ap??s a notifica????o, o requente dever?? proceder ?? demarca????o no prazo de um ano, seja por via oficial, atrav??s dos Servi??os de Cadastro.\n\n3.Findo o prazo de um ano sem que tenha sido apresentado o respectivo processo t??cnico e n??o tenha sido recebida uma justifica????o aceit??vel pelos Servi??os de Cadastro, estes notificar??o o requerente do iminente cancelamento da autoriza????o provis??ria.\n\n 4.O requerente poder?? solicitar que, em vez do cancelamento, lhe seja prorrogado o prazo por mais noventa dias. Este segundo prazo ?? improrrog??vel.",
                                                    titletext2: "",
                                                    text2: "",
                                                    onpressedPdf: () async {
                                                      final path = 'assets/documents/ValordasTaxas.pdf';
                                                      final file = await PDFApi.loadAsset( path );
                                                      openPDF( context, file );
                                                    },
                                                    tb: "Payments",
                                                  )));
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
              Navigator.push(context,
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
