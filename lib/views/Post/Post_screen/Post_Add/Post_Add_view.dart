import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_home_view.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_Add/ImagePicker.dart';
import 'package:projecto_licenciatura/controllers/Post_controller.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class post_Add_view extends StatefulWidget {
  Map nome;
  String label;
  Map userData;
  int index;

  post_Add_view({this.nome,this.label,this.userData,this.index});

  @override
  _post_Add_viewState createState() => _post_Add_viewState();
}

class _post_Add_viewState extends State<post_Add_view> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  DocumentReference documentReference;
  FirebaseAuth auth = FirebaseAuth.instance;
//  var _suggestCityListController = new TextEditingController();
  String _descricao;
  String _categoria;
  String _dataDaObra;

  String imagePassUrl="";
  DateTime date = DateTime.now();
  Post currentPost;


  User currentUser;
  String nome;
  Map dataReceive;

  @override
   void didChangeDependencies() {
  // TODO: implement didChangeDependencies
   super.didChangeDependencies();
   PostNotifier postNotifier = Provider.of<PostNotifier>(context,listen: false);
   if(postNotifier.currentPost!=null)
   {
     currentPost =postNotifier.currentPost;

   }else{
     currentPost = Post();
   }
   }
   @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 30.0),
            child: Column(
              children:[
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         IconButton(icon: Icon(Icons.close), onPressed: (){show_choicedialogexit(context);}),
                         Text(widget.label,style: TextStyle(fontWeight: FontWeight.bold),),
                          GestureDetector(
                          //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>Perfil_Home_view()));},
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
                                           makeinputdescricao(),
                                           Padding(
                                             padding: const EdgeInsets.all(10.0),
                                             child: Container(child:ImagePickerFromGallery((value){return imagePassUrl = value;})),),
                                           SizedBox(height: 5.0,),
                                           makeinputCargo(),
                                           SizedBox(height: 3.0,),
                                           makeinputData("Data Da Obra ",Icon(Icons.date_range)),])),
                                           SizedBox(height: 5,),
                                           Padding(
                                             padding: EdgeInsets.only(left: 200),
                                             child: FloatingActionButton.extended(
                                               onPressed: (){publicar(context);},
                                               label: Text('Publicar',style: TextStyle(color: Colors.black),),
                                               icon: Icon(Icons.post_add,color: Colors.black),backgroundColor: Colors.green,),)
                                                 ]),)])]),
                   ),
    ]),));
  }


  Widget makeinputCargo()
  {
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
                  hint: Text( "Escolha a categoria"),
                  dropdownColor: Colors.green[50],
                  elevation: 5,
                  icon: Icon( Icons.arrow_drop_down_sharp, color: Constants.KDefaultIconcolor),
                  iconSize: 25.0,
                  underline: SizedBox(),
                  isExpanded: true,
                  value: _categoria,
                  items: Constants.suggestCategoriaList.map( (value) {
                                 return DropdownMenuItem(value: value, child: Text(value));}).toList(),
                  onChanged :(value) {setState( () {_categoria = value;} );}
              ),
            ),
            SizedBox(height: 5,),
          ]
      );
  }


  Widget makeinputdescricao()
{
  return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Descricao",
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                fillColor: Colors.black,
              ),
              onChanged: (String value) {
                _descricao = value;
                },
              validator:  (String value){
                if(value.isEmpty)
                {
                  return "Campo obrigatorio*";
                }
                if(value.length <= 10)
                {
                  return "Descricao deve conter mais de 10 caracteres";
                }
                return null;
              },
               ),]);
}
  makeinputData(String label,Icon icon)
  {
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat(label),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                hintText: (date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString()),
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
              onTap: (){
                selectTimePicker(context);
              },),
            SizedBox(height: 5,),
          ]
      );
  }

  Future<Null>selectTimePicker(BuildContext context)async{
    final DateTime picked = await showDatePicker(context: context,
        initialDate: date,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030),
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
      _dataDaObra= date.day.toString()+'/'+date.month.toString()+'/'+date.year.toString();
      print(date.toString());
    });
    }
  }
  void addPostToDb(PostNotifier postNotifier) async {
    String uid = getcurrentUID();
    Post postModel = new Post();

    CollectionReference postRef = FirebaseFirestore.instance.collection('posts');


    postModel.descricao = _descricao;
    postModel.dataDaObra =_dataDaObra;
    postModel.image = imagePassUrl;
    postModel.autor = uid;
    postModel.categoria = _categoria;
    postModel.likecount = 0;

    documentReference = await  postRef.add(postModel.toMap());
    postModel.postId =documentReference.id;

    await FirebaseFirestore.instance
           .collection('posts')
           .doc(postModel.postId).set(postModel.toMap());
    //await FirebaseFirestore.instance.collection('posts').doc(postModel.postId).update(postModel.toMap());
    print({postModel.postId});

   // PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);

    setState(() {
      postNotifier.addPost(postModel.toMap());
    });

    Fluttertoast.showToast(msg: "You Add a Post");
  }

  void publicar(BuildContext context)
  {
    PostNotifier postNotifier = Provider.of<PostNotifier>(context, listen: false);
    if(_formkey.currentState.validate()) {
      addPostToDb(postNotifier);
      getPosts(postNotifier);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => Post_home_view()),
              (Route<dynamic> route) => false);
    }
  }


  // ignore: non_constant_identifier_names
  Future<void> show_choicedialogexit(BuildContext context) {
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