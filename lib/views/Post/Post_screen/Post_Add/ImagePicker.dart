import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:projecto_licenciatura/models/Post_model.dart';

import 'package:uuid/uuid.dart';


typedef StringValue = String Function(String);
// ignore: must_be_immutable
class ImagePickerFromGallery extends StatefulWidget {
  @override
  _ImagePickerFromGalleryState createState() => _ImagePickerFromGalleryState();
  StringValue callback;
  ImagePickerFromGallery(this.callback);

}

class _ImagePickerFromGalleryState extends State<ImagePickerFromGallery> {
  File _image;
  String imageUrl;

  Post postModel = Post();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;


  //image
  final picker = ImagePicker();
  final _firebaseStorage = FirebaseStorage.instance;
  PickedFile imagepicker;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                SizedBox(height: 5,),
                _image == null
                  ?Container(
                color: Colors.white,
                width: 400,
                height: 400,
                child:
                Center(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                      child: GestureDetector(
                        onTap:  (){ _show_ChoiCeDialog(context);},
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Insert Image",style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black.withOpacity(0.4) )),
                                  Icon(Icons.add_a_photo,),
                                ],
                              ),
                           ),
                    ))
                    : Stack(
                    children:[
                     Image.file(_image,width: 400, height: 400,),
                      Positioned(
                          bottom: 20.0,
                          right: 10,
                          child: GestureDetector(
                            onTap: (){_show_ChoiCeDialog(context);},
                            child: Icon(
                              Icons.camera_alt,
                                color: Colors.teal,
                               size: 20.0,
                              semanticLabel: 'Dash mascot',
                            ),
                          )
                      ),

    ])
          ]);
  }
  void postPOSTDatatoOb(BuildContext context) async{
     if(_image == null)
       {
         Navigator.of(context).pop();
       }
     else{

         await uplaodImage();
         Fluttertoast.showToast(msg: "You Add a Post");

     }

  }

  // ignore: non_constant_identifier_names
  _show_ChoiCeDialog(BuildContext context) {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Image From'),
          content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                      child: Text('Galeria'),
                      onTap: () {
                        _openGallery();
                        Navigator.of(context).pop();
                      }
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                      child: Text('Camera'),
                      onTap: () {
                        _openCamera();
                        Navigator.of(context).pop();
                      }
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                ],
              )
          )
      );
    }
    );
  }

  Future<void> _openGallery() async {

    await Permission.photos.request();
    var permissionStatus =  await Permission.photos.status;

    if (permissionStatus.isGranted) {
    //Select Image
    imagepicker = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(imagepicker.path);
    });
    if (imagepicker != null){
    //Upload to Firebase
    uplaodImage();
    }}else {
    print('Permission not granted. Try Again with permission access');
    }}


    Future<void> uplaodImage()async{
    String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString();
    var uuid = Uuid().v4();
    var arquivo = await FirebaseStorage.instance.ref().child('Post/images/$uuid').putFile(_image);
    //var arquivov = await FirebaseStorage.instance.ref().child("fotos").child(nomeImagem + ".jpg").delete();

    // Recuperar url da imagem);
    var downloadUrl = await arquivo.ref.getDownloadURL();

    // final snapshot = await  task.snapshot.ref.getDownloadURL();
     imageUrl = downloadUrl;
     widget.callback(imageUrl);
      print(imageUrl);
              // await db.collection("posts").doc()
                //   .set(postModel.toMap());
       }


  Future<void> _openCamera() async {

    await Permission.photos.request();
    var permissionStatus =  await Permission.photos.status;

    if (permissionStatus.isGranted) {
    //Select Image
    imagepicker = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(imagepicker.path);
    });


    if (imagepicker != null){
    //Upload to Firebase
      uplaodImage();
    }}else {
    print('Permission not granted. Try Again with permission access');
    }
  }


}