import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:poc/constants/constants.dart';
import 'package:poc/models/post_model.dart';
import 'package:poc/routes.dart';
import 'package:tinycolor/tinycolor.dart';

class Post extends StatelessWidget {
  final PostDetails post;

  Post({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: NeumorphicButton(
        minDistance: -4,
        onPressed: () {
          Navigator.pushNamed(context, RoutePaths.image, arguments: post);
        },
        padding: const EdgeInsets.all(0),
        style: NeumorphicStyle(
            border: NeumorphicBorder(
                color: TinyColor(post.color).isLight()
                    ? TinyColor(post.color).darken(40).color
                    : post.color,
                width: 1),
            shadowLightColor: Colors.black,
            shadowDarkColor: Colors.white.withOpacity(0.4),
            shadowLightColorEmboss: Colors.black,
            shadowDarkColorEmboss: Colors.white.withOpacity(0.4),
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))),
        child: SizedBox(
          height: (MediaQuery.of(context).size.height / 3),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                post.regular,
                fit: BoxFit.cover,

                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(child: ConstantWidgets.progressIndicator);
                  }
                },

              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Stack(
                  children: <Widget>[
                    BottomImageBlurStrip(
                      image: post.regular,
                      color: post.color,
                    ),
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20, left: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width - 30,
                              child: Text(
                                post.description != null
                                    ? post.description
                                    : 'Image',
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                      bottom: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomImageBlurStrip extends StatelessWidget {
  final String image;
  final Color color;

  const BottomImageBlurStrip({Key key, this.image, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ClipRect(
        child: ShaderMask(
          blendMode: BlendMode.darken,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.bottomCenter,
              stops: [0.4, 1],
              end: Alignment(
                0,
                25 / (MediaQuery.of(context).size.height / 6),
              ),
              colors: <Color>[
                TinyColor(color).isLight()
                    ? TinyColor(color).darken(40).color
                    : color,
                Colors.transparent
              ],
            ).createShader(bounds);
          },
          child: ShaderMask(
            blendMode: BlendMode.dst,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: <Color>[Colors.black, Colors.transparent],
              ).createShader(bounds);
            },
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
              child: ClipRect(
                clipper: MyCustomClipper(),
                child: Image.network(
                  image,
//                  alignment: Alignment(0, 0.49),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // TODO: implement getClip
    Rect rect = Rect.fromLTRB(0, size.width / 2, size.width, size.width);
    return rect;
//    throw UnimplementedError();
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
