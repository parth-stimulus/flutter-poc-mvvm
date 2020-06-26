import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:poc/models/post_model.dart';
import 'package:poc/widgets/base_widget.dart';
import 'package:poc/widgets/post.dart';
import 'package:provider/provider.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<PostModel>(
      builder: (context, model, child) => model.busy
          ? Center(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    shape: NeumorphicShape.convex,
                  ),
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                ),
              ),
          )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: model.posts.length,
              itemBuilder: (context, index) => Post(
                post: model.posts[index],
              ),
            ),
      model: PostModel(firebaseServices: Provider.of(context)),
      onModelReady: (model) => model.listenToPosts(),
    );
  }
}
