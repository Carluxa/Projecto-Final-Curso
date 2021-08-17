import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projecto_licenciatura/controllers/Post_notifier_operaction.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';


//method to get all data from firestone and add to a list
getPosts(PostNotifier postNotifier) async {
   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').orderBy("time",descending: true).get();
   List<Post> _postList = [];
   snapshot.docs.forEach((document)
   {
   Post post = Post.fromMap(document.data());
   _postList.add(post);
   });
   postNotifier.postList = _postList;
}

//method to get a current id to know who is using the app in current time
String getcurrentUID()
{
  User user = FirebaseAuth.instance.currentUser;
  String uid = user.uid;
  return uid;
}

void addPostToDb(Post postModel, String descricao,
    String dimensao, String dataDaObra, String  imagePassUrl, FirebaseFirestore firestore) async {
  //String uid = getcurrentUID();
  ClassModeloUsuario userModel = new ClassModeloUsuario();
  postModel.descricao = descricao;
  postModel.dimensao =dimensao;
  postModel.dataDaObra =dataDaObra;
  postModel.image =imagePassUrl;

  firestore.collection('posts').doc(userModel.userId).set(
    postModel.toMap(postModel),
  );
  Fluttertoast.showToast(msg: "You Add a Post");

}

/*
uploadPostImage( Post postModel, bool isUpdating, File localFile, Function foodUploaded) async {
if (localFile != null) {
print("uploading image");

var fileExtension = path.extension(localFile.path);
print(fileExtension);

//var uuid = Uuid().v4();

final Reference firebaseStorageRef =
FirebaseStorage.instance.ref().child('foods/images/fileExtension');

await firebaseStorageRef.putFile(localFile).catchError((onError) {
print(onError);
return false;
});

String url = await firebaseStorageRef.getDownloadURL();
print("download url: $url");
_uploadFood(food, isUpdating, foodUploaded, imageUrl: url);
} else {
print('...skipping image upload');
_uploadFood(food, isUpdating, foodUploaded);
}
}

*/
/*
_uploadFood(Food food, bool isUpdating, Function foodUploaded, {String imageUrl}) async {
CollectionReference foodRef = Firestore.instance.collection('Foods');

if (imageUrl != null) {
food.image = imageUrl;
}

if (isUpdating) {
food.updatedAt = Timestamp.now();

await foodRef.document(food.id).updateData(food.toMap());

foodUploaded(food);
print('updated food with id: ${food.id}');
} else {
food.createdAt = Timestamp.now();

DocumentReference documentRef = await foodRef.add(food.toMap());

food.id = documentRef.documentID;

print('uploaded food successfully: ${food.toString()}');

await documentRef.setData(food.toMap(), merge: true);

foodUploaded(food);
}
}
*/

//
/*deletePost(PostNotifier postNotifier, Function postDeleted) async {
  if (post.image != null) {
    var storageReference =
    await FirebaseStorage.instance.refFromURL(post.image);


    await storageReference.delete();

    print('image deleted');
  }

  await FirebaseFirestore.instance.collection('posts').doc(post.postId).delete();
  postDeleted(post);
}
*/