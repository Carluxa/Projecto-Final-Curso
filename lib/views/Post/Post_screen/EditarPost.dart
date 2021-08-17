import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_home_view.dart';
import 'package:projecto_licenciatura/controllers/Post_controller.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';




// ignore: must_be_immutable
class EditarPost extends StatefulWidget {
  Map nome;
  String label;
  Map userData;
  int index;

  EditarPost({this.nome,this.label,this.userData,this.index});

  @override
  _EditarPostState createState() => _EditarPostState();
}

class _EditarPostState extends State<EditarPost> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final picker = ImagePicker();
  PickedFile imagepicker;

  FirebaseAuth auth = FirebaseAuth.instance;
 String _descricao;
  String  _categoria;
  String _dataDaObra;

  String imagePassUrl="";
  DateTime date = DateTime.now();
  Post currentPost;
  File _image;


  User currentUser;
  String nome;
  Map dataReceive;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    PostNotifier postNotifier = Provider.of<PostNotifier>(context);
    if(postNotifier.currentPost!=null)
    {
      currentPost =postNotifier.currentPost;

    }else{
      currentPost = Post();
      print(currentPost);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context,listen: false);
    return
      Scaffold(
        body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 30.0),
          child: Column(
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.close), onPressed: (){_show_ChoiCeDialogExit(context);}),
                    Text(widget.label,style: TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>Perfil_Home_view()));},
                      child: Container(width: 40,height: 40,child: CircleAvatar(radius: 80, child: Text(widget.nome['nome'][0],style: TextStyle(color: Colors.green,fontSize: 25),),backgroundColor: Colors.green[100],),
                      ),
                    )],
                ),
                Expanded(
                  child: ListView(
                      children:[
                        Column(
                            children:[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                    children: [
                                      Form(
                                          key: _formkey,
                                          child: Column(children: [
                                            makeinputdescricao(postNotifier),
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Container(child:imagesShow(postNotifier),)),
                                            SizedBox(height: 5.0,),
                                            makeinputCargo(postNotifier),
                                            SizedBox(height: 3.0,),
                                            makeinputData("Data Da Obra ",Icon(Icons.date_range),postNotifier),])),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: EdgeInsets.only(left: 200),
                                        child: FloatingActionButton.extended(
                                          onPressed: (){publicar(context,postNotifier);},
                                          label: Text('Editar',style: TextStyle(color: Colors.black),),
                                          icon: Icon(Icons.post_add,color: Colors.black),backgroundColor: Colors.green[400],),)
                                    ]),)])]),
                ),
              ]),));
  }

  Widget makeinputCargo(PostNotifier postNotifier)
  {//_categoria = postNotifier.postList[widget.index].categoria;
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat("categoria"),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[600],width: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(),
              child:
              DropdownButton(
                  hint: Text(postNotifier.postList[widget.index].categoria),
                  dropdownColor: Colors.green[50],
                  elevation: 5,
                  icon: Icon( Icons.arrow_drop_down_sharp, color: Constants.KDefaultIconcolor),
                  iconSize: 25.0,
                  value: _categoria,
                  underline: SizedBox(),
                  isExpanded: true,
                  items:Constants.suggestCategoriaList.map( (valueC) {
                               return DropdownMenuItem(
                                   value: valueC, child: Text( valueC));}).toList(),
                  onChanged :(String value) {

                    setState( () {
                    if(value==null)
                      {
                        _categoria = postNotifier.postList[widget.index].categoria;
                      }
                    else{
                      _categoria = value;
                    }

                                   });},
              ),
            ),
            SizedBox(height: 5,),
          ]
      );
  }

  Widget makeinputdescricao( PostNotifier postNotifier)
  {  // _descricao= postNotifier.postList[widget.index].descricao;
  return
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          TextFormField(
           // controller: _descricao,
            initialValue: postNotifier.postList[widget.index].descricao,
            decoration: InputDecoration(
              labelText: "Descricao",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              fillColor: Colors.black,
            ),
            validator:
                (String value){
                if(value.isEmpty)
                {
                  return "Campo obrigatorio*";
                }
                if(value.length <= 10)
                {
                  return "Descricao incompleta";
                }
                return null;
              },
            onChanged: (String value) {
                setState(() {
                  if(value==null){
                    _descricao= postNotifier.postList[widget.index].descricao;
                  }else{
                    _descricao = value;}
                });
            },
          ),]);
  }


  makeinputData(String label,Icon icon,PostNotifier postNotifier)
  {//_dataDaObra = postNotifier.postList[widget.index].dataDaObra;
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat(label),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: postNotifier.postList[widget.index].dataDaObra,
                hintStyle: TextStyle(color: Colors.black),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey[400],)
                ),
                focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                prefixIcon: icon ,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[400],
                  ),
                ),),
              onTap: (){selectTimePicker(context,postNotifier);
              },),
            SizedBox(height: 5,),
          ]
      );
  }

  Future<Null>selectTimePicker(BuildContext context,PostNotifier postNotifier)async{

    final DateTime picked = await showDatePicker(context: context,
        initialDate: date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget child){
          return Theme(
            data: ThemeData(
                primaryColor: Color(0xFFC41A3B),
                accentColor: Color(0xFFC41A3B)),child: child,);
        }
    );
    if(picked != null && picked != date )
    {  setState(() {
      date = picked;
      if(date == null)
        {_dataDaObra = postNotifier.postList[widget.index].dataDaObra;}
      else{
        _dataDaObra = date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString();
      }

    });
    }
  }
  bool onbutoonhek=false;
  imagesShow(PostNotifier postNotifier){
    imagePassUrl = postNotifier.postList[widget.index].image;
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5,),
            Container(
                color: Colors.white,
                width: 400,
                height: 400,
                child:
                Center(
                  child:
                   Stack(
                     children: [
                       //Image.file(_image,width: 400, height: 400,),
                       Container(
                         width: 400,
                         height: 400,
                         child:
                        onbutoonhek==false?Image.network(postNotifier.postList[widget.index].image,
                           fit: BoxFit.cover,):
                        _image!=null? Image.file(_image,width: 400, height: 400,
                          fit: BoxFit.cover,):
                        CircularProgressIndicator()
                       ),
                     ],
                   ),
    ))]);
  }


  void addPostToDb(PostNotifier postNotifier) async {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);

    String uid = getcurrentUID();
    Post postModel = new Post();

    postModel.descricao = _descricao;
    if(_dataDaObra==null)
      {
         postModel.dataDaObra = postNotifier.postList[widget.index].dataDaObra;
      }else{
      postModel.dataDaObra =_dataDaObra;
    }
    postModel.image = imagePassUrl;
    postModel.autor = uid;
    postModel.image = postNotifier.postList[widget.index].image;

    if(_categoria==null)
      {
        postModel.categoria = postNotifier.postList[widget.index].categoria;
      }
    else {
      postModel.categoria = _categoria;
    }
    postModel.postId =postNotifier.postList[widget.index].postId;

     await FirebaseFirestore.instance
         .collection('posts')
         .doc(postNotifier.postList[widget.index].postId)
         .update(postModel.toMap());

    postNotifier.addPost(postModel.toMap());

     Fluttertoast.showToast(msg: "You update a Post");
  }

  void publicar(BuildContext context,PostNotifier postNotifier)
  {
    if(_formkey.currentState.validate()) {

      addPostToDb(postNotifier);

      Navigator.pop(context);
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (_) => DetailsScreen(mapUser: widget.userData,)),
        //         (Route<dynamic> route) => false);
    }
  }


  // ignore: non_constant_identifier_names
  Future<void> _show_ChoiCeDialogExit(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Are you Sure?'),
          content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                      child: Text('Yes'),
                      onTap: () {
                        //ToDO back
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Post_home_view()));

                      }
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                      child: Text('No'),
                      onTap: () {
                        Navigator.of(context).pop();
                      }
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                ],
              )
          )
      );
    });
  }
}