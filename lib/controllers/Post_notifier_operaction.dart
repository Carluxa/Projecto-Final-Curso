import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/models/Post_model.dart';


class PostNotifier with ChangeNotifier {
  List<Post> _postList = [];
  Post _currentPost;

  UnmodifiableListView<Post> get postList => UnmodifiableListView(_postList);

  Post get currentPost => _currentPost;

  set postList(List<Post> postList) {
    _postList = postList;
    notifyListeners();
  }

  set currentPost(Post postModel) {
    _currentPost = postModel;
    notifyListeners();
  }

  addPost(Post postModel) {
    _postList.insert(0, postModel);
    notifyListeners();
  }

  deletePost(PostNotifier postNotifier,int index) {
    _postList.removeWhere((_post) => _post.postId == postNotifier.postList[index].postId);
    notifyListeners();
  }
}