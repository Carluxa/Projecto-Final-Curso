import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';


class rebocos_categoria extends StatefulWidget {
  Map mapUser;
  Map currentPost;

  rebocos_categoria({Key key,this.currentPost,this.mapUser}) : super(key: key);

  @override
  _rebocos_categoriaState createState() => _rebocos_categoriaState();
}

 class _rebocos_categoriaState extends State<rebocos_categoria> {


  int quantcategoriaRebocos=0;
  int quant;
  List<String>eleImgeRebocos;
  Iterable<Post> rebocosImagem;


  searchCategoria() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    List<String> categoria = postNotifier.postList.map((value) => value.categoria).toList();
    quantcategoriaRebocos = categoria.where((element) =>element.contains("Rebocagem")).length;
    setState(() {
      rebocosImagem  = postNotifier.postList.where((element) => element.categoria.contains('Rebocagem')).toList();
      eleImgeRebocos = rebocosImagem.map((e) => e.image).toList();
      // casaImagem.forEach((element) {element.image;});

    });
  }
  @override
  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false );
    rebocosImagem =postNotifier.postList;
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
      return quantcategoriaRebocos != 0 ? Container(
        child:
        Container(
          child:
          Padding(
            padding: const EdgeInsets.all( 10.0 ),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Constants.bodyPost(
                    quantcategoria: quantcategoriaRebocos,
                    iterable: rebocosImagem,
                    eleImge: eleImgeRebocos,
                    mapUser: widget.mapUser,
                    currentPost: widget.currentPost, )
                ]
            ),
          ),
        ),
      ) : Constants.message(text: "Nao Existe Nenhuma PubliCaCao" );
    })
    );
        }
}
