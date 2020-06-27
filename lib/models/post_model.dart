import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:poc/models/base_model.dart';
import 'package:poc/services/firebase_services.dart';

class PostModel extends BaseModel {
  final FirebaseServices _firebaseServices;

  List<dynamic> _posts = [];

  List<dynamic> get posts => _posts;

  PostModel({FirebaseServices firebaseServices})
      : _firebaseServices = firebaseServices;

  listenToPosts() {
    setBusy(true);
    _firebaseServices.getAllPosts().listen((event) {
      print(event);
      _posts = event;
      notifyListeners();
      setBusy(false);
    });
  }
}

class PostDetails {
  final String id;
  final String description;
//  final DateTime created_at;
  final Color color;
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String documentId;

  PostDetails(
      {this.id,
      this.description,
//      this.created_at,
      this.documentId,
      this.color,
      this.raw,
      this.full,
      this.regular,
      this.small,
      this.thumb});

  static PostDetails fromJson(Map<dynamic, dynamic> map, documentId) {
    return PostDetails(
      id: map['id'],
      description: map['description'],
      color: hexToColor(map['color'] !=  null ? map['color'] : '#000000'),
      raw: map['raw'],
      full: map['full'],
      regular: map['regular'],
      small: map['small'],
      thumb: map['thumb'],
      documentId: map['documentId'],
    );
  }

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
