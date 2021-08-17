import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/models/Chat_Model.dart';

class ChatNotifier with ChangeNotifier {
  List<ChatUsers> _chatList = [];
  ChatUsers _currentChat;

  UnmodifiableListView<ChatUsers> get chatList => UnmodifiableListView(_chatList);

  ChatUsers get currentChat => _currentChat;

  set postList(List<ChatUsers> chatList) {
    _chatList = chatList;
    notifyListeners();
  }

  set currentChat(ChatUsers chatModel) {
    _currentChat = chatModel;
    notifyListeners();
  }

  addPost(ChatUsers chatModel) {
    _chatList.insert(0, chatModel);
    notifyListeners();
  }

}