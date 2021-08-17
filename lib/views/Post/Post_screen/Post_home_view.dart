import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/%20Chat/chat/Show_user.dart';
import 'package:projecto_licenciatura/views/Documentos/documentos_view.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_Add/Post_Add_view.dart';
import 'package:projecto_licenciatura/controllers/Post_controller.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_componentes/PostCategorias/Electricidade_categoria.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_componentes/PostCategorias/Outros.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_componentes/PostCategorias/Tudo.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';
import 'Post_componentes/PostCategorias/Jardim.dart';
import 'Post_componentes/PostCategorias/Pintura.dart';
import 'Post_componentes/PostCategorias/Rebocos.dart';
import 'Post_componentes/PostCategorias/Serralharia.dart';
import 'Post_componentes/PostCategorias/carpintaria.dart';
import 'Post_componentes/PostCategorias/casa.dart';


// ignore: must_be_immutable, camel_case_types
class Post_home_view extends StatefulWidget {
  int index;
  bool tipoUsuario = false;
  Map snpData;
 // bool logged = false;
  Post_home_view({this.index,this.tipoUsuario,this.snpData});

  @override
  _Post_home_viewState createState() => _Post_home_viewState();
}

class _Post_home_viewState extends State<Post_home_view> {

  FirebaseAuth auth = FirebaseAuth.instance;
  Map dataReceive;
  Map postMap;
  Iterable<Post> listpostuser;
  List<String> listPosts;
  List<String> listwithoutCurrentPost;
//  String nome;
  bool isVisibleLogin= true;
  int _currentIndex = 0;
  bool tipoUsuario = false;
  bool loginView = false;
  bool viewButton = false;
  bool viewtype = false;
 // Post _currentPost;

  List<Tab>itemCategorias=[
    Tab(text: "Tudo",),
    Tab(text: "Pintura",),
    Tab(text: "construcao",),
    Tab(text: "Rebocagem",),
    Tab(text:  "Serralharia",),
    Tab(text:  "carpintaria",),
    Tab(text: "Jardinagem",),
    Tab(text:"Electricidade"),
    Tab(text: "Outros",),
  ];
//verifiCa o usuario e guarda em map para fazer a manipulaCao
  Future<void> checkcurrentUserM () async {
    var snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(auth.currentUser.uid).get();
    Map<String, dynamic> data = snapshot.data();
    dataReceive = data;
    //nome = data['nome'];
  }

  Future <void> getPostUser() async {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    var snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(postNotifier.postList[widget.index].autor).get();
    Map<String, dynamic> data = snapshot.data();
    postNotifier.postList.forEach((element) {
      if(element.autor==data['userId']){
        List<Post>listUserPost = element.toMap();
      }});
  }

 // int quantcategoriaElectricidade=0;

  //List<String>eleImgeElectricidade;
  //Iterable<Post> ElectricidadeImagem;


    // String userDatas;
  //   Future<List<QuerySnapshot>> listModelUser=FirebaseFirestore.instance.collection('usuarios' ).snapshots().toList();

    // print("---------------------------$listModelUser");
     // var streamBuilder = StreamBuilder(
     //     stream: FirebaseFirestore.instance.collection('usuarios' ).snapshots(),
     //     builder: (context, userSnapshot) {
     //       for(int i=0; i<userSnapshot.data.docs.length;i++) {
     //         DocumentSnapshot userData = userSnapshot.data.docs[i];
     //
     //       }
     //       print("--------------------------------->$userDatas");
     //       return Text("hello") ;
     //     });
     // print(userDatas);
     // PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
     // var snapshot = await FirebaseFirestore.instance.collection('usuarios')
     //                  .doc().get();
     // print("${snapshot.data()}");
  //   Map<String, dynamic> data = snapshot.data();
  //   if(widget.mapUser['userId']==postNotifier.postList[widget.index].autor)
  //   {
  //     nome = widget.mapUser['nome'];
  //   }
  //   else{
  //     nome = data['nome'];
  //   }



 // print("1---------------------$autor");

// for(int i=0;i<autor.length;i++)
//   {var ele = autor[i];
//   print("2------------------------------$ele");
//     var snapshot = await FirebaseFirestore.instance.collection('usuarios').doc(autor[i]).get();
//     Map<String, dynamic> dataUs = snapshot.data();
//     print("3-------------------------------$dataUs");
//   }

    //quantcategoriaElectricidade = autor.where((element) =>element.contains(dataReceive['userId'])).length;
    //print(quantcategoriaElectricidade);
    // setState(() {
    //   ElectricidadeImagem  = postNotifier.postList.where((element) => element.categoria.contains(dataReceive['userId'])).toList();
    //   eleImgeElectricidade = ElectricidadeImagem.map((e) => e.image).toList();
    //   // casaImagem.forEach((element) {element.image;});
    // });

  void initState() {
    super.initState();
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    getType();
    getPosts(postNotifier);
    checkcurrentUserM();

   // getType();
  }

// Be sure to cancel subscription after you are done
  @override
  dispose() {
    super.dispose();
  }

  Future <void> getType() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(auth.currentUser.uid).get();
    Map<String, dynamic> data = snapshot.data();
      if(data['tipoUsuario'] == 'Interressado')
      {
        viewtype = true;
      }
      else
        {
           viewtype = false;
        }
    viewButton=true;
  }

  @override
  Widget build(BuildContext context) {
   // PostNotifier postNotifier = Provider.of<PostNotifier>(context,listen: false);
    //FirebaseUtils firebaseUtils  = Provider.of<FirebaseUtils>(context,listen: false);
    // ignore: cancel_subscriptions
    return   DefaultTabController(
        length: itemCategorias.length,
        initialIndex: 0,
        child:
            Scaffold(
             resizeToAvoidBottomInset: false,
             backgroundColor: Colors.white,
              appBar: Constants.globalAppBar( context,
          title: Text(
              "Publicações", style: TextStyle( color: Colors.black ) ),
          // action: [
          //   // IconButton(
          //   //     icon: Icon( Icons.search, size: 20, color: Colors.black, ),
          //   //     onPressed: () {} )
          // ],
          button:  TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.green,
                  labelColor: Colors.green[300],
                  tabs:itemCategorias),
      ),
      body:


        // !widget.logged? Consumer<FirebaseUtils>(
        //     builder: (context,model,child){
        //       return
        //          model.isLogin?Visibility(visible: false,
        //          child: Visibility(visible:isVisibleLogin, child: SignIn(changeStatus:model))):
        //          Visibility(visible: true,
        //              child: Visibility(visible:isVisibleLogin, child: SignIn( changeStatus:model)));
        //     }
        // ):
       Consumer<PostNotifier>(
             builder: (context,notifier,child){
               return
                  Post_CrudBuild(context,notifier);}),
         )
    );
  }


  // ignore: non_constant_identifier_names
   Widget Post_CrudBuild(BuildContext context, PostNotifier postnotifier)
   {
     return
       Stack(
         children: [
           TabBarView(
               children:[
                    tudo_categoria(mapUser: dataReceive, currentPost: postMap,listPost:listPosts),
                    pintura_categoria(mapUser: dataReceive, currentPost: postMap),
                    casa_categoria(mapUser: dataReceive, currentPost: postMap),
                    rebocos_categoria(mapUser: dataReceive, currentPost: postMap),
                    serralharia_categoria(mapUser: dataReceive, currentPost: postMap),
                    carpintaria_categoria(mapUser: dataReceive, currentPost: postMap),
                    Jardim_categoria(mapUser: dataReceive, currentPost: postMap),
                    Electricidade_categoria(mapUser: dataReceive, currentPost: postMap),
                    Outros_categoria(mapUser: dataReceive, currentPost: postMap),
                 ]),
                     Align(alignment:Alignment.bottomCenter,child: viewButton?ButtonCustom():Text("")),
                   ],
                 );
   }

/*
  Widget checkUser (){
    return
      StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc()
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return checkRole(snapshot.data);
            }
            return null;
            // return LinearProgressIndicator();
          });
  }
  checkRole(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return Center(
        child: Text('no data set in the userId document in firestore'),
      );
    }
    // ignore: unrelated_type_equality_checks

  }*/

  // ignore: non_constant_identifier_names
  Widget ButtonCustom()
  {   PostNotifier postNotifier = Provider.of<PostNotifier>(context);
    return
    CustomNavigationBar(
      iconSize: 30.0,
      selectedColor: Colors.white,
      strokeColor: Colors.white,
      unSelectedColor: Colors.grey[600],
      backgroundColor: Colors.green[200],
      borderRadius: Radius.elliptical(150, 150),
      isFloating: true,
      blurEffect: true,
      opacity: 0.8,
      items:  viewtype ? Constants.floatingButtonsInteressado : Constants.floatingButtonsProfissional,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
            _currentIndex = index;
            if(viewtype==true){

                  if (_currentIndex == 0) {
                  Navigator.push( context,
                  MaterialPageRoute( builder: (_) => document_view( ) ) );
                  }
                  if (_currentIndex == 1) {
                  Navigator.push( context,
                  MaterialPageRoute( builder: (_) => Post_home_view( ) ) );
                  }
                  if (_currentIndex == 2) {
                  Navigator.push( context,
                  MaterialPageRoute( builder: (_) => Perfil_Home_view(snp:widget.snpData) ) );
                  }
                  if (_currentIndex ==3) {
                  Navigator.push( context,
                  MaterialPageRoute( builder: (_) => show_user()) );
                  }
                  }
                  else{
                  if (_currentIndex == 0) {
                  Navigator.push( context,
                  MaterialPageRoute( builder: (_) => document_view( ) ) );
                  }
                  if (_currentIndex == 1) {
                  Navigator.push( context,
                  MaterialPageRoute( builder: (_) => Post_home_view( ) ) );
                  }
                  if (_currentIndex == 2) {
                  Navigator.push( context,MaterialPageRoute( builder: (_) => post_Add_view(nome: dataReceive,label: "Nova Publicação") ) );
                  }
                  if (_currentIndex == 3) {
                  Navigator.push(context,MaterialPageRoute( builder: (_) => Perfil_Home_view(snp:widget.snpData)));
                  }
                  if (_currentIndex ==4) {
                  Navigator.push(context,MaterialPageRoute( builder: (_) => show_user()));
                  }
                  }
                    }
                  );
                 });
                }}




  /* Expanded(
                  child: Container(

                        child: Stack(
                          children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:CrossAxisAlignment.stretch ,
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                  itemCount: postNotifier.postList.length,
                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                   childAspectRatio: 0.75,
                                   crossAxisCount: 2,
                                   mainAxisSpacing: 20,
                                     crossAxisSpacing: 20,
                                     ),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(

                                        alignment: Alignment.center,
                                        child:
                                        ItemCard(
                                            index:index,
                                            press: () =>
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailsScreen(index: index),))
                                        )
                                         );}
                                    )
                                ),
                             ]
                            ),),
                            tipoUsuario?Align(alignment:Alignment.bottomCenter,child: ButtonCustomInterressado ()):
                            Align(alignment:Alignment.bottomCenter,child: ButtonCustom()),
                          ])
    )
    ),

      ])
    );*/


/*
  Widget adminPage(DocumentSnapshot snapshot) {
    return Center(
        child: Text('${snapshot.data()} ${snapshot.data['name']}'));
  }

  Widget userPage(DocumentSnapshot snapshot) {
    return Center(child: Text(snapshot.data['name']));
  }
*/














/*
    Future<void> uplaodImage()async{
               String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
              FirebaseStorage storage = FirebaseStorage.instance;
              var pastaRaiz = storage.ref();
              var arquivo = await pastaRaiz
                          .child("fotos")
                          .child(nomeImagem + ".jpg").putFile(_image);

                      // Recuperar url da imagem);
                    var downloadUrl = await arquivo.ref.getDownloadURL();
                     // final snapshot = await  task.snapshot.ref.getDownloadURL();

      setState(() {
      imageUrl = downloadUrl;
      widget.callback(imageUrl);
      });

               await db.collection("posts").doc()
                   .set(postModel.toMap());
       }*/

 /* void postPublicacoesDatatoOb() async{

    User firebaseUser = auth.currentUser;
    ClassModeloUsuario userModel = new ClassModeloUsuario();

    userModel.email =_email;
    userModel.nome =_nome;
    userModel.senha =_password;

    await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(firebaseUser.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Register Success");

    //await FirebaseUtils.updateFirebaseToken();

    sendVerificationEmail();

    setState((){
      isLoading = false;
    });
  }*/

