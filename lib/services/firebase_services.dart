import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poc/models/post_model.dart';

class FirebaseServices {
  CollectionReference _postColRef = Firestore.instance.collection('posts');

  Stream<List<PostDetails>> getAllPosts() {
  StreamController<List<PostDetails>> _listStream = StreamController.broadcast();
    _postColRef.snapshots().listen((snapshots) {
      if (snapshots.documents.isNotEmpty) {
        var posts = snapshots.documents
            .map((snapshot) =>
                PostDetails.fromJson(snapshot.data, snapshot.documentID))
            .where((element) => element.regular != null)
            .toList();
        _listStream.add(posts);
      }
    });
    return _listStream.stream;
  }
}
