import 'package:email_validator/email_validator.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Constants {
  static const double progressIndicatorWidth = 1.5;
  static const AlwaysStoppedAnimation<Color> progressIndicatorAnimation =
      AlwaysStoppedAnimation(Colors.black);
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


