import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/EditarPost.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_componentes/ItemCard_componentes.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_home_view.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  final Post postModel;
  final index;
  Map currentPost;
  Map mapUser;
  List<String> listPost;
  Iterable<Post>listElements;


  DetailsScreen({Key key, this.index,this.postModel,this.mapUser,this.currentPost,  this.listPost, this.listElements}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  int quantPost=0;
  TextEditingController nomei =TextEditingController();
  TextEditingController idNomei =TextEditingController();
  int quant;
  Iterable<Post>ownImagem;
  List<String>eleImgeown;
  List<String>ownPost;
  Map listaOwn;
  String item;
  String nomeuser="";
  int quantEle;
  int quantSee;
//  Post currentPost;
  Map<String, dynamic> data;
  Map<String, dynamic> userPost;
  Iterable<Post> listpostuser;
  List<String> listPosts=[""];
  List<String> listwithoutCurrentPost;


  Future <void> getUser() async {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    var snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(postNotifier.postList[widget.index].autor).get();
    Map<String, dynamic> data = snapshot.data();
    if(widget.mapUser['userId']==postNotifier.postList[widget.index].autor)
    {nomeuser = widget.mapUser['nome'];
    }
    else{nomeuser = data['nome'];
    }
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
        quant = listUserPost.length;
        print(quant);
      }});
  }
  Future <List<ClassModeloUsuario>> getUserList() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        'usuarios' ).get( );
    return querySnapshot.docs.map( (e) =>
        ClassModeloUsuario(
          userId: e.data( )['userId'],
          nome: e.data( )['nome'],
          email: e.data( )['email'],
          senha: e.data( )['senha'],
          conSenha: e.data( )['conSenha'],
          provincia: e.data( )['provincia'],
          localidade: e.data( )['localidade'],
          // bairro:e.data()['bairro'],
          // quarteirao:e.data()['quarteirao'],
          // nrCasa: e.data()['nrCasa'],
          ddNascimento: e.data( )['ddNascimento'],
          cargo: e.data( )['cargo'],
          bi: e.data( )['bi'],
          //telefone:e.data()['telefone'],
          //  bio: e.data()['bio'],
          tipoUsuario: e.data( )['tipoUsuario'],
        ) ).toList( );
  }
  searchCategoria() async {
    String id;
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<ClassModeloUsuario> userDate= await getUserList();

   // List<Post>userPost;
    for(int i=0; i<userDate.length;i++)
    {
      List<String> listStringNome = widget.listElements.map((e) => e.autor).toList();
      if(listStringNome[widget.index]==userDate[i].userId)
      {setState(() {
        id = userDate[i].userId;
        nomei.text = userDate[i].nome;
        idNomei.text = userDate[i].userId;
        print("============================>${nomei.text}");
      });
          listpostuser=postNotifier.postList.where((element) => element.autor.contains(id)).toList();
          listPosts= listpostuser.map((e) => e.image).toList();
          if(listPosts.isEmpty)
           {
             return Text("Am Empty");
           }
       }
    }
  }


  @override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    listpostuser = postNotifier.postList;

    super.initState();
    searchCategoria();

  }

  @override
  void dispose() {
    // ignore: unnecessary_statements
    super.dispose;
    // TODO: implement dispose
  }
String _seeImage="";
  bool seeImage=true;
  int indexp;

  User user =FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<String> listStringDesrisao = widget.listElements.map((e) => e.descricao).toList();
    List<String> listStringData = widget.listElements.map((e) => e.dataDaObra).toList();
    if(seeImage==true) {
     List<String> listStringElemets = widget.listElements.map((e) => e.image).toList();
      _seeImage = listStringElemets[widget.index];
    }
    else{
      _seeImage = listPosts[indexp];
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: Constants.globalAppBar( context,
          title: Text(
            "Foto",// data['nome'],
            style: TextStyle( color: Colors.black ), ), ),
        body:
        //postNotifier.postList.length == 0
        postNotifier.postList.length==null ? Center(child: CircularProgressIndicator(backgroundColor: Colors.green, strokeWidth: 2,)):
            Stack(
              children: [
                Container(
                  child: Padding(
                   padding: const EdgeInsets.all( 10.0 ),
                      child:  Container(
                                       child: ListView(
                                         children: [
                                       Column(
                                         children: [
                                           Container(
                                                         child:
                                                         Column(
                                                           children: [
                                                             Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                               children: [
                                                                 Row(
                                                                   children: [
                                                                    //CircleAvatar(backgroundColor: Colors.green[100],child: Text(nomei.text[0]),),
                                                                     SizedBox(width: 10,),
                                                                     GestureDetector(
                                                                         onTap: (){
                                                                           Navigator.push( context,
                                                                             MaterialPageRoute( builder: (_) => Perfil_Home_view(id: idNomei.text) ));
                                                                           },
                                                                         child: Text(nomei.text, style: TextStyle(fontSize: 15),)),
                                                                   ],
                                                                 ),

                                                                 //SizedBox(width: 200,),
                                                                 // IconButton(icon: Icon(Icons.menu_sharp), onPressed: (){
                                                                 //   return
                                                                  PopupMenuButton<String>(
                                                                     icon:  postNotifier.postList[widget.index].autor==auth.currentUser.uid?Icon(Icons.more_vert):Icon(Icons.more_vert,color: Colors.transparent,),
                                                                     onSelected: (String choise){
                                                                        if(choise=="Editar")
                                                                        {    Navigator.push( context, MaterialPageRoute( builder: (_) =>
                                                                                     EditarPost(nome:widget.mapUser,label: "Editar Publicação",index:widget.index)));
                                                                        }
                                                                        if(choise=="Remover")
                                                                        {  dialog(postNotifier
                                                                        //    _onPostDeleted(postNotifier.currentPost)
                                                                        );
                                                                          }},
                                                                     itemBuilder: (BuildContext context) {
                                                                       return Constants.choices.map(
                                                                            (String choises) {
                                                                               return PopupMenuItem<String> (
                                                                                  value: choises,
                                                                                  child: ListTile(
                                                                                          title: Text(choises)),
                                                                                 );}).toList();}
                                                                     ),
                                                             ]),
                                                             Container(
                                                               width: 400,
                                                               height: 400,
                                                               child:
                                                               Image.network(_seeImage,
                                                                 fit: BoxFit.cover,),
                                                             ),
                                                            Row(
                                                              children: [
                                                                Text("${postNotifier.postList[widget.index].likecount}"),
                                                                Icon(Icons.favorite,color:Colors.red,),
                                                              ],
                                                            ),
                                                               Column(
                                                                 mainAxisSize: MainAxisSize.max,
                                                                 crossAxisAlignment:CrossAxisAlignment.stretch ,
                                                                 children: [
                                                                   Text(
                                                                       listStringDesrisao[widget.index],
                                                                       style: TextStyle( color: Colors.black.withOpacity(0.4))),
                                                                  /* Text(listStringData[widget.index],
                                                                     style: TextStyle(
                                                                         fontStyle: FontStyle.italic,
                                                                         color: Colors.black.withOpacity(0.4)),),*/
                                                                 ],
                                                               ),
                                                             SizedBox(height: 10,),
                                                            Column(
                                                               mainAxisSize: MainAxisSize.max,
                                                               crossAxisAlignment:CrossAxisAlignment.stretch ,
                                                               children: [
                                                                 Container (
                                                                   // width: 300,
                                                                   height: 600,
                                                                   child: GridView.builder(
                                                                       itemCount: listPosts.length,
                                                                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                         childAspectRatio: 0.75,
                                                                         crossAxisCount: 3,
                                                                         mainAxisSpacing: 20,
                                                                         crossAxisSpacing: 20,
                                                                       ),
                                                                       itemBuilder: (BuildContext context, int index) {
                                                                         return Container(
                                                                             alignment: Alignment.center,
                                                                             child:
                                                                             ItemCard(
                                                                                 index:index,
                                                                                 imagem: listPosts[index],
                                                                                 press: () {
                                                                                   setState(() {
                                                                                     Navigator.push(context,
                                                                                         MaterialPageRoute(
                                                                                           builder: (context) =>
                                                                                               DetailsScreen(index: index,  currentPost:widget.currentPost,
                                                                                                   mapUser:widget.mapUser,listElements: widget.listElements,listPost:widget.listPost,),));
                                                                                   });
                                                                                     }
                                                                             )
                                                                         );
                                                                       }
                                                                       )
                                                                 )
                                                               ])
                           ]))])]))
                   )),
                if(listPosts.length==null)
                  Center(child: CircularProgressIndicator(backgroundColor: Colors.green, strokeWidth: 2,)),
              ],
            ),
             //Center(child: CircularProgressIndicator(backgroundColor: Colors.green, strokeWidth: 2, ))
    );

  }
  deletePost(PostNotifier postNotifier, Function onPostDeleted) async {
    if (postNotifier.postList[widget.index].image != null) {
      var storageReference =  FirebaseStorage.instance.refFromURL(postNotifier.postList[widget.index].image);


      await storageReference.delete();

      print('image deleted');
    }

    await FirebaseFirestore.instance.collection('posts').doc(postNotifier.postList[widget.index].postId).delete();
    onPostDeleted();
  }

  dialog(PostNotifier postNotifier){
    _onPostDeleted(){
             postNotifier.deletePost(postNotifier,widget.index);
           }
    return
         showDialog( context: context, builder: (BuildContext context) {
            return AlertDialog(
                  title: Column(
                    children: [
                      ListTile(
                            title: Text("Apagar?",style: TextStyle(color: Colors.black),)),
                    ],
                  ),
                         shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        content: SingleChildScrollView(
                        child: ListBody(
                        children: [
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Padding(padding: EdgeInsets.symmetric( horizontal: 30.0 ) ),
                          GestureDetector(
                                  child: Container(child: Text( 'Apagar' )),
                                  // ignore: unnecessary_statements
                                  onTap: () async {
                                    setState(() {
                                      deletePost(postNotifier,_onPostDeleted);
                                    });
                                    Navigator.push( context,
                                        MaterialPageRoute( builder: (_) => Post_home_view()));}
                                  ),
                                  Divider(height: 10,),
                                  Padding( padding: EdgeInsets.all(8.0)),
                                  GestureDetector(
                                  child: Container(child: Text( 'Cancelar' )),
                                   onTap: () {
                                   Navigator.of( context ).pop( );
                                    }
                                   ),
                               ],
                           ),],
                   ),
                )
          );
  } );
}
}