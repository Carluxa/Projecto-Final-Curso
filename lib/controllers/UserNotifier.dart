import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';


class UserNotifier with ChangeNotifier {
  List<ClassModeloUsuario> _userList = [];
  ClassModeloUsuario _currentUser;

  UnmodifiableListView<ClassModeloUsuario> get userList => UnmodifiableListView(_userList);

  ClassModeloUsuario get currentUser => _currentUser;

  set userList(List<ClassModeloUsuario> userList) {
    _userList = userList;
    notifyListeners();
  }

  set currentUser(ClassModeloUsuario userModel) {
    _currentUser = userModel;
    notifyListeners();
  }

  addUser(ClassModeloUsuario userModel) {
    _userList.insert(0, userModel);
    notifyListeners();
  }

  deleteUser(UserNotifier userNotifier,int index) {
    _userList.removeWhere((_user) => _user.userId == userNotifier.userList[index].userId);
    notifyListeners();
  }
}