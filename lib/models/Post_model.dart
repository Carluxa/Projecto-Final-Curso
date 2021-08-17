import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/models/ClassModeloUsuario.dart';


class Post{

  FirebaseAuth auth = FirebaseAuth.instance;

   String descricao;
   String dataDaObra;
   String image, autor ;
   String dimensao, postId ;
   ClassModeloUsuario userModel;
   String categoria;
   int likecount=0;
   dynamic like;
   Timestamp time;
  //bool isliked;
   Color color;
   String currentuserId;
  Post({this.image,this.likecount,this.autor,this.dimensao,
         this.descricao ,this.dataDaObra, this.postId, this.color,this.categoria,this.currentuserId,this.time,this.like});


  toMap([Post postModel]) {
    return {
      'postId': postId,
      'likecount':likecount,
      'like':like,
      'image': image,
      'descricao': descricao,
      'dataDaObra': dataDaObra,
      'categoria':categoria,
      'color': color,
      "autor": autor,
      "time":FieldValue.serverTimestamp(),
    };
  }
  int getLikeCount(likes) {
    // if no likes, return 0
    if (likes == null) {
      return 0;
    }
    int count = 0;
    // if the key is explicitly set to true, add a like
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  factory Post.fromMap(Map map) {
    return Post(
      postId: map["postId"],
      likecount:map["likecount"],
      image: map["image"],
      categoria: map["categoria"],
      descricao: map["descricao"],
      dataDaObra: map["dataDaObra"],
      dimensao: map["dimensao"],
      color: map["color"],
      currentuserId: map["userId"],
      autor: map["autor"],
      time: map['time'],
      like: map['like'],
    );
  }


  // Post.fromSnapshot(DocumentSnapshot snapshot)
  // {
  //    Map data = snapshot.data();
  //    postId: data[postId];
  //    image: data[image];
  //    descricao: data[descricao];
  //    dataDaObra: data[dataDaObra];
  //    dimensao: data[dimensao];
  //    categoria:data[categoria];
  //     userId: data[userId];
  //
  // }
}
