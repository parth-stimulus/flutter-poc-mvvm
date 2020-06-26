import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LoginHeader extends StatefulWidget {
  LoginHeader({Key key}) : super(key: key);

  @override
  _LoginHeaderState createState() => _LoginHeaderState();
}

class _LoginHeaderState extends State<LoginHeader> {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
        height: 150.0,
        width: 150.0,
      ),
      style: NeumorphicStyle(
          shape: NeumorphicShape.convex,
          lightSource: LightSource.topLeft,
          shadowDarkColorEmboss: Colors.deepPurple,
          depth: 2,
          surfaceIntensity: 0.5,
          border: NeumorphicBorder(color: Colors.deepPurple, width: 0.5),
          shadowDarkColor: Colors.deepPurple,
          shadowLightColor: Colors.deepPurple,
          boxShape:
              NeumorphicBoxShape.path(NeumorphicFlutterLogoPathProvider())),
    );
  }
}

