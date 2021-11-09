import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_controller.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_componentes/ItemCard_componentes.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_componentes/Post_details_componentes.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';

class tudo_categoria extends StatefulWidget {
  PostNotifier postNotifier;
  Map currentPost;
  Map mapUser;
  List<String> listPost;
  Function detailsData;
   tudo_categoria({Key key,this.postNotifier,this.mapUser,this.currentPost, this.listPost}) : super(key: key);

  @override
  _tudo_categoriaState createState() => _tudo_categoriaState();
}

class _tudo_categoriaState extends State<tudo_categoria> {


  @override
   Widget build(BuildContext context) {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context,listen: false);
    Iterable<Post> listElemen =postNotifier.postList;
    Future<void>_refreshList()async{
    getPosts(postNotifier);
   }

    return
          RefreshIndicator(
            onRefresh: _refreshList,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').orderBy('time',descending: true).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child:CircularProgressIndicator());
                }
                return
                  postNotifier.postList.length!=0?Container(
                    child:
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:CrossAxisAlignment.stretch ,
                                children: [
                                  Expanded(
                                      child: GridView.builder(
                                          //itemCount: postNotifier.postList.length,
                                            itemCount: snapshot.data.docs.length,
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
                                                   // imagem: postNotifier.postList[index].image,
                                                    imagem: snapshot.data.docs[index].data()['image'],
                                                     press: () =>
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  DetailsScreen(
                                                                    index: index,
                                                                    mapUser: widget.mapUser,
                                                                    currentPost: widget.currentPost,
                                                                    listElements: listElemen,
                                                                    listPost: widget.listPost,
                                                                    //searh: (){}
                                                                    //searchCategoria()
                                                                  ),))
                                                )
                                            );}
                                      )
                                  ),
                                ]
                            ),),
    ):Constants.message(text: "Nao Existe Nenhuma PubliCaCao");
              }
            ));
  }
}
