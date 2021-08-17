import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';

import 'package:provider/provider.dart';
class serralharia_categoria extends StatefulWidget {
  Map mapUser;
  Map currentPost;
  serralharia_categoria({Key key,this.mapUser,this.currentPost}) : super(key: key);

  @override
  _serralharia_categoriaState createState() => _serralharia_categoriaState();
}

class _serralharia_categoriaState extends State<serralharia_categoria> {



  int quantcategoriaSerralharia=0;

  List<String>eleImgeSerralharia;
  Iterable<Post> serralhariaImagem;


  searchCategoria() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<String> categoria = postNotifier.postList.map((value) => value.categoria).toList();
    quantcategoriaSerralharia = categoria.where((element) =>element.contains("Serralharia")).length;
    setState(() {
      serralhariaImagem  = postNotifier.postList.where((element) => element.categoria.contains('Serralharia')).toList();
      eleImgeSerralharia = serralhariaImagem.map((e) => e.image).toList();
      // casaImagem.forEach((element) {element.image;});
    });
  }
  @override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    serralhariaImagem =postNotifier.postList;
    searchCategoria();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier = Provider.of<PostNotifier>( context, listen: false );
    Future<void>_refreshList()async{
      searchCategoria();
    }
    return RefreshIndicator(
        onRefresh: _refreshList,
        child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').orderBy('time',descending: true).snapshots(),
    builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return Center( child: CircularProgressIndicator( ) );
    }
    return
    quantcategoriaSerralharia!=0?Container(
      child:
      Container(
        child:
        Padding(
          padding: const EdgeInsets.all( 10.0 ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Constants.bodyPost(quantcategoria:quantcategoriaSerralharia,iterable:serralhariaImagem,eleImge:eleImgeSerralharia, mapUser: widget.mapUser,
                  currentPost: widget.currentPost,)
              ]
          ),
        ),
      ),
    ):Constants.message(text: "Nao Existe Nenhuma PubliCaCao");
  }
    ));}
  }
