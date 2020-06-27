import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Constants {
  static const double progressIndicatorWidth = 1.5;
  static const AlwaysStoppedAnimation<Color> progressIndicatorAnimation =
      AlwaysStoppedAnimation(Colors.black);
  static const Pattern emailPattern =
      r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$";
}

class ConstantWidgets {
  static Widget progressIndicator = Padding(
    padding: const EdgeInsets.all(10),
    child: Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        shape: NeumorphicShape.convex,
      ),
      child: CircularProgressIndicator(
        strokeWidth: Constants.progressIndicatorWidth,
        valueColor: Constants.progressIndicatorAnimation,
      ),
    ),
  );
}


