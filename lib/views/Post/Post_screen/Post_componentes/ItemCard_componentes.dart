import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_controller.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';
import 'package:projecto_licenciatura/models/Like.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatefulWidget{

  String imagem;
  final Function press;
  final String categoriaIndex;
  final String dataDaObra;
  final String categoria;
  final String autor;
  int index;
  ItemCard({
    Key key,
    this.index,
    this.imagem,
    this.press,
    this.categoriaIndex,
    //this.descricao,
    this.dataDaObra,
    //this.imageModel,
    this.categoria,
    this.autor,
    //this.dimensao,
    //this.postId,
    // this.likecount
  }): super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override

  bool isliked=false;
  int likecount=0;

  Post postModel;
  Map postMap;

  Iterable<Post> listpostuser;
  List<String> listPosts;
  List<String> listwithoutCurrentPost;
  TextEditingController nome = TextEditingController();

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
      if(postNotifier.postList[widget.index].autor==userDate[i].userId)
      {
       // setState(() {
          id = userDate[i].userId;
          nome.text = userDate[i].nome;
       // });
        listpostuser=postNotifier.postList.where((element) => element.autor.contains(id)).toList();
        listPosts= listpostuser.map((e) => e.image).toList();
      }
      else{
        print("----------------------------->Not iguals");
      }
    }
  }



   // Future<void> checkcurrentPost (PostNotifier postNotifier) async {
   //   var snapshot = await FirebaseFirestore.instance
   //       .collection('likes')
   //       .doc(postNotifier.postList[widget.index].postId).get();
   //   Map<String, dynamic> data = snapshot.data();
   //   postMap = data;
   //       //nome = data['nome'];
   //     }

  Future <List<Likes>> getUserLists() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        'likes' ).get( );
    return querySnapshot.docs.map( (e) =>
        Likes(
          userId: e.data( )['userId'],
          likebool: e.data( )['likebool'],
          likesip: e.data()['likesip']
        )).toList();
  }

  Iterable<Post> listpostusers;
  List<String> listPostss;
  List<String> listwithoutCurrentPosts;

  searchId() async {

    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<Likes> userDate = await getUserLists( );
    Likes likes = new Likes();
    //isliked=false;
     setState((){
       isliked = !isliked;
     });
      likes.likebool = isliked;
      likes.userId = postNotifier.postList[widget.index].autor;
      likes.likesip = FirebaseAuth.instance.currentUser.uid;
      postNotifier.postList[widget.index].like = isliked;

      FirebaseFirestore.instance.collection( 'likes' ).doc().set(
          likes.toMap( likes ));

    if(isliked==true) {
         FirebaseFirestore.instance.collection('posts').doc(postNotifier.postList[widget.index].postId).update({'likecount':postNotifier.postList[widget.index].likecount+1});
       }
       else{
         FirebaseFirestore.instance.collection('posts').
         doc(postNotifier.postList[widget.index].postId).
         update({'likecount':postNotifier.postList[widget.index].likecount-=1});
       }
      //
      // for(int i=0; i<userDate.length;i++)
      //   {
          // print("------------------------>${userDate[i].likebool}");
          //          //todo current user on userDate[i}.userId
          //    if(postNotifier.postList[widget.index].postId == userDate[i].likesip)
          //      {
          //        setState(() {
                  // isliked = userDate[i].likebool;
                   print(isliked);
             //     });
             //   }
             // else
             //   {
             //     setState(() {
             //       isliked = userDate[i].likebool;
             //     });
             //   }

      //
        isliked = postNotifier.postList[widget.index].like;
    }


     void initState() {
       PostNotifier postNotifier = Provider.of<PostNotifier>(
           context, listen: false);
       getPosts(postNotifier);
       searchCategoria();
       //checkcurrentPost(postNotifier);
       super.initState();
      // searchId();
     }


     Widget build(BuildContext context) {
       PostNotifier postNotifier = Provider.of<PostNotifier>(
           context, listen: false );
       //isliked =(widget.like[widget.currentUserId]==false);
       // isliked = (postMap['like']==false);

       return
         Stack(
             children: [
               Container(
                   decoration: BoxDecoration(
                     color: Colors.grey[100],
                     borderRadius: BorderRadius.circular( 20 ),
                   ),
                   child: InkWell(
                       onTap: widget.press,
                       child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Expanded(
                               child:
                               // child: Hero(
                               // tag: "${postNotifier.currentPost}",
                               Stack(
                                   children: [
                                     Container(
                                         height: 400,
                                         width: 400,
                                         padding: EdgeInsets.all( 20 ),
                                         child: Image.network(
                                           widget.imagem != null
                                               ? widget.imagem
                                               :
                                           'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freeiconspng.com%2Fimages%2Fno-image-icon&psig=AOvVaw3XQHALDL0X3hQfMYQYDC2L&ust=1623123853945000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIizu4XLhPECFQAAAAAdAAAAABAD'
                                           , fit: BoxFit.cover,),
                                     ),

                                   ] ),
                             ),
                             //  ),
                             /*  Padding(
                         padding: const EdgeInsets.symmetric(vertical: 20/4),
                         child: Text(postNotifier.postList[widget.index].dataDaObra=null?"":postNotifier.postList[widget.index].dataDaObra,
                           style: TextStyle(color: Colors.black),
                         )),*/
                             //      Container(
                             //           padding: const EdgeInsets.symmetric(vertical: 20/4),
                             //               child: Row(
                             //                    children: [
                             //                   //Text("${postNotifier.postList[widget.index].dataDaObra}",
                             //                  // style: TextStyle(fontWeight: FontWeight.bold),),
                             //                  //   SizedBox(width: 60,),
                             //                  //  GestureDetector(
                             //                  //      onTap:handleLikePost,
                             //                  //      child: Icon(isliked?Icons.favorite:Icons.favorite_border, size: 25, color: Colors.red,)),
                             //                  //     SizedBox(width: 10,),
                             //                  //     Icon(Icons.comment, size: 25, color: Colors.black,),
                             //                    ],
                             //               ),
                             //      ),
                             GestureDetector(
                                 child: Icon( isliked ? Icons.favorite : Icons
                                     .favorite_border, size: 30,
                                   color: Colors.red, ),
                                 onTap: () {searchId();} )
                           ] ) ) )
             ] );
     }
}