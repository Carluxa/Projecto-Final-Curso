import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/controllers/UserNotifier.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_home_view.dart';


class FirebaseUtils with ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLogin=false;


  /*
static final StorageReference notificationsStorageReference =
FirebaseStorage.instance.ref().child(Constants.statues);

static CollectionReference statuesCollectionsReference =
FirebaseFirestore.instance.collection(Constants.statues);

static Future<String> uploadImageToStorage(File file) async {
print("uploadImageToStorage");
final StorageUploadTask storageUploadTask = notificationsStorageReference
    .child(Utilities.getFileName(file))
    .putFile(file);
final StorageTaskSnapshot storageTaskSnapshot =
(await storageUploadTask.onComplete);
final url = (await storageTaskSnapshot.ref.getDownloadURL());
print("url : $url");
return url;
}

static Future postNotification(PostModel model, String filePath) async {
if (filePath != null) {
// here deleteing old image from storage
if (model.imageURL != null && model.imageURL.contains("https://")) {
await FirebaseStorage.instance
    .getReferenceFromUrl(model.imageURL)
    .then((onValue) {
onValue.delete();
});
}

model.imageURL = await uploadImageToStorage(File(filePath));
print("addProdcut url ${model.imageURL}");
}

DocumentReference ref = statuesCollectionsReference.doc();

if (model.docid != null) {
ref = statuesCollectionsReference.doc(model.docid);
}
model.docid = ref.id;
model.imageURL = model.imageURL;
print(model.toMap().toString());
return await ref.set(model.toMap());
}*/

// //Metodo Signup
// //Metodo Signup


  // static cadastroapi(String nome,String email,String pass,String ConfPassword,bool isLoading)
  // async {
  //   FirebaseAuth auth =FirebaseAuth.instance;
  //   UserCredential user;
  //   User firebaseUser = auth.currentUser;
  //   ClassModeloUsuario userModel = new ClassModeloUsuario();
  //
  //   user = await auth.createUserWithEmailAndPassword(
  //       email: email, password: pass ).then( (user) async {
  //     isLoading=false;
  //     userModel.email =email;
  //     userModel.nome =nome;
  //     userModel.senha =pass;
  //     userModel.conSenha=ConfPassword;
  //     userModel.userId = firebaseUser.uid;
  //
  //     await FirebaseFirestore.instance
  //         .collection("usuarios")
  //         .doc(firebaseUser.uid)
  //         .set(userModel.toMap());
  //
  //     Fluttertoast.showToast(msg: "Register Success");
  //     await FirebaseUtils.updateFirebaseToken();
  //
  //   }).catchError((onError) {
  //   print('msg: error' + onError.toString());
  //   Fluttertoast.showToast(msg: "error " + onError.toString());
  //   });
  // }

  // void sendVerificationEmail() async {
  //   User firebaseUser = auth.currentUser;
  //   await firebaseUser.sendEmailVerification();
  //
  //   Fluttertoast.showToast(msg: "email Verification link has sent to your email.");
  //
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (_) => Post_home_view()),
  //           (Route<dynamic> route) => false);
  //
  // }


// static updateFirebaseToken() async {
//
//   FirebaseMessaging firebaseMessaging;
//   String token = await firebaseMessaging.getToken();
// print("updateFirebaseToken $token");
// User user = FirebaseAuth.instance.currentUser;
//
// await FirebaseFirestore.instance
//     .collection("usuarios")
//     .doc(user.uid)
//     .update({'firebaseToken': token});
//}

static removeFirebaseToken() async {
User user = FirebaseAuth.instance.currentUser;

await FirebaseFirestore.instance
    .collection("usuarios")
    .doc(user.uid)
    .update({'firebaseToken': ''});
}

static getTipoUsuario(String tipoUsuario)async
 {
   User user = FirebaseAuth.instance.currentUser;

   FirebaseFirestore.instance
  .collection('usuarios')
   .doc(user.uid)
   .get();
 // .where('tipoUsuario', isEqualTo: tipoUsuario)
}

  static void postUserDatatoOb(
      {
        String email, String nome, String senha,
        String bi, String telefone,String dataDNas,
        String nrCasa,String quarteirao, String provincia,
        String localidade, String cargo, String tipoUsuario,
        String confPassword,String bio,context,index
      }) async{
    User firebaseUser =   FirebaseAuth.instance.currentUser;
    ClassModeloUsuario userModel = new ClassModeloUsuario();

    userModel.email =email;
    userModel.nome =nome;
    userModel.senha =senha;
    userModel.bi =bi;
    userModel.conSenha= confPassword;
    userModel.telefone=telefone;
    userModel.ddNascimento= dataDNas;
    userModel.nrCasa=nrCasa;
    userModel.quarteirao=quarteirao;
    userModel.provincia =provincia;
    userModel.localidade=localidade;
    userModel.tipoUsuario=tipoUsuario;
    userModel.cargo =cargo;
    userModel.bio = bio;
    userModel.userId = firebaseUser.uid;

    await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(firebaseUser.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Register Success");
  //  await FirebaseUtils.updateFirebaseToken();

    sendVerificationEmail(context,index);
  }

  static sendVerificationEmail(context,index) async {
    User firebaseUser =  FirebaseAuth.instance.currentUser;
    await firebaseUser.sendEmailVerification();

    Fluttertoast.showToast(msg: "email Verification link has sent to your email.");

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => Post_home_view(index:index)),
            (Route<dynamic> route) => false);

  }
  static Future<void>checkcurrentUserM ({snp}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var snapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(auth.currentUser.uid).get();
    Map<String, dynamic> dataReceive = snapshot.data();
    return snp=dataReceive;
  }
}