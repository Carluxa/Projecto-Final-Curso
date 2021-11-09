import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';
class casa_categoria extends StatefulWidget {
  Map mapUser;
  Map currentPost;

  casa_categoria({Key key,this.currentPost,this.mapUser}) : super(key: key);

  @override
  _casa_categoriaState createState() => _casa_categoriaState();
}

class _casa_categoriaState extends State<casa_categoria> {


  int quantcategoriacasa=0;
  int quant;
  List<String>eleImgecasa;
  Iterable<Post> casaImagem;


  searchCategoria() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<String> categoria = postNotifier.postList.map((value) => value.categoria).toList();
    quantcategoriacasa = categoria.where((element) =>element.contains("construcao")).length;
    setState(() {
      casaImagem  = postNotifier.postList.where((element) => element.categoria.contains('construcao')).toList();
      eleImgecasa = casaImagem.map((e) => e.image).toList();
      // casaImagem.forEach((element) {element.image;});

    });

  }
@override
  void initState() {
  PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
  casaImagem =postNotifier.postList;
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
    return quantcategoriacasa!=0?Container(
      child:
      Container(
        child:
        Padding(
          padding: const EdgeInsets.all( 10.0 ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Constants.bodyPost(quantcategoria:quantcategoriacasa,eleImge:eleImgecasa,iterable: casaImagem, mapUser: widget.mapUser,
                  currentPost: widget.currentPost,),
              ]
          ),
        ),
      ),
    ):Constants.message(text: "Nao Existe Nenhuma PubliCaCao");
  }));
  }
}
