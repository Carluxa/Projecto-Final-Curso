import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';

class pintura_categoria extends StatefulWidget{

  PostNotifier postNotifier;
  Map mapUser;
  Map currentPost;

  pintura_categoria({Key key, this.postNotifier,this.mapUser,this.currentPost}) : super( key: key );

  @override
  _pintura_categoriaState createState() => _pintura_categoriaState( );

}

class _pintura_categoriaState extends State<pintura_categoria> {
int quantcategoriapintura=0;
int quant;
Iterable<Post>item;

List<String> pinturaImagem;
List<String>eleImgePintura;

  searchCategoria() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<String> categoria = postNotifier.postList.map((value) => value.categoria).toList();
    quantcategoriapintura = categoria.where((element) =>element.contains("Pintura")).length;

    setState(() {
      item = postNotifier.postList.where((element) => element.categoria.contains('Pintura')).toList();
      eleImgePintura = item.map((e) => e.image).toList();
      //item.forEach((element) { pinturaImagem = [element.image];});
    });
  }

  @override
  void initState() {
    searchCategoria();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier = Provider.of<PostNotifier>(
        context, listen: false );
    Future<void>_refreshList()async{
      searchCategoria();
    }
    return
      RefreshIndicator(
        onRefresh: _refreshList,
        child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('time',descending: true).snapshots(),
         builder: (context, snapshot) {
           if (!snapshot.hasData) {
             return Center( child: CircularProgressIndicator( ) );
           }
           return
             quantcategoriapintura != 0 ?
             Container(
                 child:
                 Padding(
                     padding: const EdgeInsets.all( 10.0 ),
                     child: Column(
                         mainAxisSize: MainAxisSize.max,
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Constants.bodyPost(
                               quantcategoria: quantcategoriapintura,
                               iterable: item,
                               eleImge: eleImgePintura,
                               mapUser: widget.mapUser,
                               currentPost: widget.currentPost,
                           ),
                         ]
                     ) ) ) : Constants.message(text: "Nao Existe Nenhuma PubliCaCao");
            })
          );
  }
}