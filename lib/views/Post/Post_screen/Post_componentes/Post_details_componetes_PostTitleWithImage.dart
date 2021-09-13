import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/controllers/Post_controller.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PostTitleWithImage extends StatefulWidget{
  final Post postModel;
  final ClassModeloUsuario userModel;
  final index;
   Map snapshot;
   PostTitleWithImage({Key key, @required this.postModel, this.userModel,this.index,this.snapshot}) : super(key: key);

  @override
  _PostTitleWithImageState createState() => _PostTitleWithImageState();
}

class _PostTitleWithImageState extends State<PostTitleWithImage> {

  void initState() {
    PostNotifier postNotifier = Provider.of<PostNotifier>(
        context, listen: false);
    getPosts(postNotifier);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context);
    return
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // ignore: deprecated_member_use
              FlatButton(onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) =>
                  Perfil_Home_view(id: widget.snapshot['userId'],),
              ),),
                child:  Text(widget.snapshot['nome'],
                  style:Theme.of(context).
                  textTheme.headline6.
                  copyWith(color: Colors.black, fontWeight: FontWeight.bold),), ),
                  ]),),
          ListPost(postModel: postNotifier.currentPost,),
     ]         );
  }
}

class ListPost extends StatefulWidget {
 final Post postModel;



  ListPost({Key key, this.postModel,}) : super(key: key);
      @override
      _ListPostState createState() => _ListPostState(postModel);
    }

    class _ListPostState extends State<ListPost> {
     final Post postModel;
     //final ListPost_model listPost;
      List <ListPost> listpost=[];
      int selectedIndex = 0;
    // var postListmodel = List <Post>();
     _ListPostState(this.postModel,);


    @override
    Widget build(BuildContext context) {
       return Expanded(
         child: ListView.builder(
                 scrollDirection: Axis.vertical,
                // itemCount: ListPost.length,
                 itemBuilder: (context, index) =>buildCategory(index),
              ),
       );
    }

    Widget buildCategory(int index) {
    return
        Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  //Text(
                  //ListPost[index],
                  //style: TextStyle(
                   //fontWeight: FontWeight.bold,
                   //color: selectedIndex== index ? Colors.green[200] : Colors.green[100],
                Column(
                  children: [
               //Image.asset(postModel.image, fit: BoxFit.fill),
                        Text('image here'),
                        SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                       child: Row(
                         children: [
                            //Text("${  .dataDaObra}",
                             //style: TextStyle(fontWeight: FontWeight.bold),),
                             SizedBox(width: 230),
                             Icon(Icons.favorite_border, size: 25,
                             color: Colors.black,),
                             SizedBox(width: 10),
                             Icon(Icons.comment, size: 25, color: Colors.black,),
                         ],
                       ),
                          ),
                    Text("${widget.postModel.descricao}", style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),),
                 ],),

                  ],
               ),
            );
          }
}
