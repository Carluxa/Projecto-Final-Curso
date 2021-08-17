import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projecto_licenciatura/controllers/UserNotifier.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';

getUser(UserNotifier userNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('usuarios').get();
  List<ClassModeloUsuario> _userList = [];
  snapshot.docs.forEach((document)
  {
    ClassModeloUsuario user = ClassModeloUsuario.fromMap(document.data());
    _userList.add(user);
  });
  userNotifier.userList = _userList;
}

