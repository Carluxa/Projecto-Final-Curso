import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';
class Electricidade_categoria extends StatefulWidget {
  Map currentPost;
  Map mapUser;
  Electricidade_categoria({Key key,this.currentPost,this.mapUser}) : super(key: key);

  @override
  _Electricidade_categoriaState createState() => _Electricidade_categoriaState();
}

class _Electricidade_categoriaState extends State<Electricidade_categoria> {


  int quantcategoriaElectricidade=0;

  List<String>eleImgeElectricidade;
  Iterable<Post> electricidadeImagem;


  searchCategoria() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<String> categoria = postNotifier.postList.map((value) => value.categoria).toList();
    quantcategoriaElectricidade = categoria.where((element) =>element.contains("Electricidade")).length;
    setState(() {
      electricidadeImagem  = postNotifier.postList.where((element) => element.categoria.contains('Electricidade')).toList();
      eleImgeElectricidade = electricidadeImagem.map((e) => e.image).toList();
      // casaImagem.forEach((element) {element.image;});
    });
  }

  @override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    electricidadeImagem = postNotifier.postList;
    searchCategoria();
    print("===============================>$eleImgeElectricidade");
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
    return quantcategoriaElectricidade!=0?Container(
      child:
      Container(
        child:
        Padding(
          padding: const EdgeInsets.all( 10.0 ),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Constants.bodyPost(quantcategoria:quantcategoriaElectricidade,iterable:electricidadeImagem,eleImge:eleImgeElectricidade,mapUser: widget.mapUser,
                  currentPost: widget.currentPost,)
              ]
          ),
        ),
      ),
    ):Constants.message(text: "Nao Existe Nenhuma PubliCaCao");
  }));
}
}
