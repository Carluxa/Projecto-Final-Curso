import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';

class carpintaria_categoria extends StatefulWidget {
  Map mapUser;
  Map currentPost;
  carpintaria_categoria({Key key,this.mapUser,this.currentPost}) : super(key: key);

  @override
  _carpintaria_categoriaState createState() => _carpintaria_categoriaState();
}

class _carpintaria_categoriaState extends State<carpintaria_categoria> {


  int quantcategoriacarpintaria=0;

  List<String>eleImgecarpintaria;
  Iterable<Post> carpintariaImagem;


  searchCategoria() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<String> categoria = postNotifier.postList.map((value) => value.categoria).toList();
    quantcategoriacarpintaria = categoria.where((element) =>element.contains("carpintaria")).length;
    setState(() {
      carpintariaImagem  = postNotifier.postList.where((element) => element.categoria.contains('carpintaria')).toList();
      eleImgecarpintaria = carpintariaImagem.map((e) => e.image).toList();
      // casaImagem.forEach((element) {element.image;});
    });
  }

  @override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    carpintariaImagem =postNotifier.postList;
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
    return quantcategoriacarpintaria!=0?Container(
      child:
      Container(
        child:
        Padding(
          padding: const EdgeInsets.all( 10.0 ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Constants.bodyPost(quantcategoria:quantcategoriacarpintaria,iterable:carpintariaImagem,eleImge:eleImgecarpintaria,mapUser: widget.mapUser,
                  currentPost: widget.currentPost,)
              ]
          ),
        ),
      ),
    ):Constants.message(text: "Nao Existe Nenhuma PubliCaCao");
  }
));
  }
}
