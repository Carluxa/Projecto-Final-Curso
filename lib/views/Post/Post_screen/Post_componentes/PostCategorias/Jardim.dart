import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';
class Jardim_categoria extends StatefulWidget {
  Map mapUser;
  Map currentPost;
  Jardim_categoria({Key key,this.currentPost,this.mapUser}) : super(key: key);

  @override
  _Jardim_categoriaState createState() => _Jardim_categoriaState();
}

class _Jardim_categoriaState extends State<Jardim_categoria> {


  int quantcategoriaJardim=0;

  List<String>eleImgeJardim;
  Iterable<Post> jardimImagem;


  searchCategoria() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<String> categoria = postNotifier.postList.map((value) => value.categoria).toList();
    quantcategoriaJardim = categoria.where((element) =>element.contains("Jardinagem")).length;
    setState(() {
      jardimImagem  = postNotifier.postList.where((element) => element.categoria.contains('Jardinagem')).toList();
      eleImgeJardim = jardimImagem.map((e) => e.image).toList();
      // casaImagem.forEach((element) {element.image;});
    });
  }
  @override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    jardimImagem =postNotifier.postList;
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
    return quantcategoriaJardim!=0?Container(
      child:
      Container(
        child:
        Padding(
          padding: const EdgeInsets.all( 10.0 ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Constants.bodyPost(quantcategoria:quantcategoriaJardim,iterable:jardimImagem,eleImge:eleImgeJardim, mapUser: widget.mapUser,
                  currentPost: widget.currentPost,)
              ]
          ),
        ),
      ),
    ):Constants.message(text: "Nao Existe Nenhuma PubliCaCao");
  }));
  }
}
