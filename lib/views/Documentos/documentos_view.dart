
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
                                                    textTitle: "Legalização de um terreno",
                                                    text2: "",
                                                    titletext1: "Passos a Seguir\n",
                                                    titletext2: "",
                                                    text1: "Diagrama que explica qual é a sequência de acções a seguir para a legalização de um terreno de uma forma geral, nos campos as seguir explica detalhadamente os cada processo",
                                                    onpressedPdf: () async{
                                                    final path = 'assets/documents/PassosTerreno.pdf';
                                                    final file = await PDFApi
                                                        .loadAsset( path );
                                                    openPDF(context, file );
                                                  },
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
                                                    text1:"A taxa referente ao Direito de uso e aproveitamento de terra, a autorização definitiva são de 300 meticais.",
                                                    titletext2: "Conteúdo do DUAT",
                                                    text2:"a)Documento de identificação do requerente, se for pessoa singular, e Estatutos, no caso de se tratar de pessoa colectiva;\n\nb)	Esboço da localização do terreno;\n\nc)	Memória descritiva;\n\nd)	Indicação da natureza e dimensão do empreendimento que o requerente se propõe realizar;\n\ne)	Parecer do administrador do Distrito, precedido de consulta à comunidade local;\n\nf)	Edital e comprovativo da sua afixação na sede do respectivo distrito e no próprio local, durante um período de trinta dias;\n\ng)	Guia comprovativa de depósito para pagamento da taxa de autorização provisória.",
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
                                                      textTitle: "Autorização provisória",
                                                      titletext1: "Autorização provisória",
                                                      text1: "\nÉ um documento emitido após a apresentação do pedido de uso e aproveitameto da terra. Tem a duração de 5 anos para cidadão nacionais e 2 anos para cidadão estrangeiro, com a taxa de 600 meticais.",
                                                      titletext2: "",
                                                      text2: "Conteúdo do autorização provisória:\na)	Identificação da entidade que autorizou o pedido e data do despacho de autorização;\n\nb)	Número da autorização;\n\nc)	Identificação do requerente;\n\nd)	Esboço, área, localização e número de identificação da parcela no registo cadastral;\n\ne)	Prazo da autorização provisória;\n\nf)	Tipo ou tipos de exploração para que foi concedida a autorização;\n\ng)	Taxas devidas;\n\nh)	Data e local da emissão;\n\ni)	Assinatura do responsável pelos serviços que emitem a autorização e respectiva chancela.",
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
                                                        InkWell(
                                                            onTap: () async {
                                                              Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                                textTitle: "Titulação do DUAT",
                                                                titletext1: "Processo de titulação do DUAT\n",
                                                                text1: "Titulo é emitido pelos Servicos Publicos de Cadastro,gerais ou urbanos, que comprova o direito de uso e aproveitamento da terra, inclui o parecer das actividades administrativas locais, e consulta as respectivas comunidades,",
                                                                titletext2: "Elementos que constaram no  título:\n",
                                                                text2: "a)	Identificação da entidade que autorizou o pedido de  emissão do título e data do despacho de autorização;\n\nb)	Número do título;\n\nc)	Identificação do titular;\n\nd)	Área e sua definição geométrica, com as respectivas coordenadas, localização, números de identificação das parcelas confrontantes;\n\ne)	Prazo a que estiver sujeito o direito de uso e aproveitamento da terra;\n\nf)	Tipo ou tipos de exploração para que foi adquirido o direito de uso e aproveitamento da terra;\n\ng)	Descrição das benfeitorias existentes;\n\nh)	Taxas devidas;\n\ni)	Data e local da emissão;\n\nAssinatura do responsável pelos Serviços que emitem o título e respectiva chancela",
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
                                                                  'Titulação do DUAT' ),
                                                            ) ),
                                                        InkWell(
                                                            onTap: () async {
                                                              Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                                textTitle: "Direitos dos titulares",
                                                                titletext1: "Direitos dos titulares",
                                                                text1: "Direitos dos titulares do direito de uso e aproveitamento da terra, seja adquirido por ocupação, seja por autorização de um pedido:\n\na)	Defender –se contra qualquer intrusão de uma segunda parte;\n\nb)	Ter acesso à sua parcela e aos recursos hídricos de uso público através das parcelas vizinhas, constituindo para o efeito as necessárias servidões.\n\nc)	Os requerentes ou titulares do direito de uso e aproveitamento da terra podem apresentar certidão da autorização provisória ou do título às instituições de crédito, no contexto de pedido de empréstimos.",
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
                                                                text2: "a)	Utilizar a terra respeitando os princípios definidos na Constiuição e demais legislação em vigor e  no caso do exercício de actividades económicas em conformidade com os planos de exploração. \n\nb)	Dar acesso através da sua parcela aos vizinhos que não tenham comunicação com a via pública ou com os recursos hídricos de uso público. \n\nc)	Respeitar as servidões relativas a vias de acesso público ou comunitário e passagens para o gado, estabelecidas por práticas costumeiras; \n\nd)	Permitir a execução de operações e/ou instalação de acessórios e equipamento conduzidas ao abrigo de lincença de prospecções e pesquisa mineira, concessão mineira ou certificado mineiro, mediante justa indeminização; \n\ne)	Manter os marcos de fronteiras, de triangulação, de demarcação cadastral e outros que sirvam de pontos de referência;",
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
                                                    textTitle: "Parecer da Administração",
                                                    titletext1: "Parecer da Administração do Distrito e consulta às comunidades locais",
                                                    text1: "",
                                                    titletext2: "",
                                                    text2: "Parecer da administração o distrito e consulta às comunidades locais falado no do processo relativo DUART adquirida por ocupação:\n\n1.	Os serviços de Cadastro envirão ao Administrador do respectivo distrito um exemplar do pedido, para efeitos de afixação do respectivo Edital e obtenção do seu parecer, prestando-lhe a assistência técnica necessária para a recolha de informações sobre o terreno pretendido e os terrenos limítrofes.\n\n2.	Será feito um trabalho conjunto, envolvendo os Serviços de Cadastro, o Administrador do Distrito ou seu representante e as comunidades locais. O resultado desse trabalho será reduzido a escrito e assinado por um minimo de três e um máximo de nove representantes da comunidade local, bem como pelos titulares ou ocupantes dos terrenos limítrofes.\n\n3.	O parecer do Administrador do Distrito incidirá sobre a existência ou não, na área requerida, do DUAT adquirido por ocupação. Caso sobre a área requerida recaiam outros direitos, o parecer incluirá os termos pelos quais se regerá a parceria entre os titulares do direito de uso e aproveitamento da terra adquirido por ocupação e o requerente.\n\n\nTaxas referentes ao parecer Administrativo e consulta as comunidades locais",
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
                                              child: InkWell(
                                                onTap: () async {
                                                  Navigator.push(context, MaterialPageRoute(builder: (_) => TextDocuments(
                                                    textTitle: "Demarcação",
                                                    titletext1: "Processo técnico relativo à  demarcação",
                                                    text1: "1.	Emitida a autorização provisória, os Serviços de Cadastro notificarão o requerente para a comunicação do despacho e para a necessidade de fazer a demarcação;\n\n2.	Após a notificação, o requente deverá proceder à demarcação no prazo de um ano, seja por via oficial, através dos Serviços de Cadastro.\n\n3.	Findo o prazo de um ano sem que tenha sido apresentado o respectivo processo técnico e não tenha sido recebida uma justificação aceitável pelos Serviços de Cadastro, estes notificarão o requerente do iminente cancelamento da autorização provisória.\n\n4.	O requerente poderá solicitar que, em vez do cancelamento, lhe seja prorrogado o prazo por mais noventa dias. Este segundo prazo é improrrogável.",
                                                    titletext2: "",
                                                    text2: "",
                                                    onpressedPdf: () async {
                                                      final path = 'assets/documents/Demarcação.pdf';
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
                                                        title: const Text('Demarcação'),
                                                        subtitle: Text('Processo técnico relativo à  demarcação',
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
                                                    text1: "1.Emitida a autorização provisória, os Serviços de Cadastro notificarão o requerente para a comunicação do despacho e para a necessidade de fazer a demarcação;\n\n 2.Após a notificação, o requente deverá proceder à demarcação no prazo de um ano, seja por via oficial, através dos Serviços de Cadastro.\n\n3.Findo o prazo de um ano sem que tenha sido apresentado o respectivo processo técnico e não tenha sido recebida uma justificação aceitável pelos Serviços de Cadastro, estes notificarão o requerente do iminente cancelamento da autorização provisória.\n\n 4.O requerente poderá solicitar que, em vez do cancelamento, lhe seja prorrogado o prazo por mais noventa dias. Este segundo prazo é improrrogável.",
                                                    titletext2: "",
                                                    text2: "",
                                                    onpressedPdf: () async {
                                                      final path = 'assets/documents/ValordasTaxas.pdf';
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
