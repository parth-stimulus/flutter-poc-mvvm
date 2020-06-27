import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:poc/constants/constants.dart';
import 'package:poc/models/post_model.dart';

class ImageView extends StatefulWidget {
  final PostDetails postDetails;

  const ImageView({Key key, this.postDetails}) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  BoxFit fit = BoxFit.cover;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(
          widget.postDetails.description != null
              ? widget.postDetails.description
              : 'Image',
          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
        ),
      ),
      body: SizedBox.expand(
        child: GestureDetector(
          onTap: () {
            setState(() {
              fit = fit == BoxFit.cover ? BoxFit.contain : BoxFit.cover;
            });
          },
          child: Image.network(
            widget.postDetails.full,
            fit: fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(child: ConstantWidgets.progressIndicator);
              }
            },
          ),
        ),
      ),
    );
  }
}
