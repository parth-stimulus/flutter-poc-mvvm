import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:poc/routes.dart';
import 'package:poc/widgets/base_widget.dart';
import 'package:poc/widgets/login_header.dart';
import 'package:poc/widgets/login_text_field.dart';
import 'package:provider/provider.dart';
import 'package:poc/models/login_view_model.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginModel>(
      model: LoginModel(authenticationService: Provider.of(context)),
      child: LoginHeader(),
      builder: (context, model, child) => Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child,
                  LoginTextField(
                    controller: emailController,
                    type: 'Email',
                  ),
                  LoginTextField(
                    controller: passwordController,
                    type: 'Password',
                  ),
                  model.busy
                      ? Padding(
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
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: NeumorphicButton(
                        provideHapticFeedback: true,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease,
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(50)),
                          shape: NeumorphicShape.convex,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Login',
                          ),
                        ),
                        onPressed: () async {
                          print(emailController.value.text.toString());
                          print(passwordController.value.text.toString());
                          bool loginSuccess = await model.loginWithCred(
                              emailController.value.text.toString(),
                              passwordController.value.text.toString());
                          print(loginSuccess);
                          if (loginSuccess) {
                            print(RoutePaths.Home);
                            Navigator.popAndPushNamed(context, RoutePaths.Home);
                          }
                        }),
                  ),
                  NeumorphicButton(
                      provideHapticFeedback: true,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(50)),
                        shape: NeumorphicShape.convex,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Login With Google',
                        ),
                      ),
                      onPressed: () async {
                        bool loginSuccess = await model.login();
                        print(loginSuccess);

                        if (loginSuccess) {
                          print(RoutePaths.Home);
                          Navigator.popAndPushNamed(context, RoutePaths.Home);
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
