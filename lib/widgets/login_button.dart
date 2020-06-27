import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:poc/models/login_view_model.dart';
import '../routes.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function callback;
  final String text;
  final LoginModel model;

  const LoginButton({Key key,
    this.emailController,
    this.passwordController,
    this.callback,
    this.text,
    this.model})
      : super(key: key);

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
        provideHapticFeedback: true,
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
          shape: NeumorphicShape.convex,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.text,
          ),
        ),
        onPressed: () {
          widget.callback(widget.model);
        });
  }
}
