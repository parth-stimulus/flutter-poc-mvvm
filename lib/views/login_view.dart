import 'dart:math';

import 'package:poc/generated/local_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:poc/constants/constants.dart';
import 'package:poc/models/either.dart';
import 'package:poc/routes.dart';
import 'package:poc/widgets/base_widget.dart';
import 'package:poc/widgets/login_button.dart';
import 'package:poc/widgets/login_header.dart';
import 'package:poc/widgets/login_text_field.dart';
import 'package:provider/provider.dart';
import 'package:poc/models/login_view_model.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginModel>(
      model: LoginModel(authenticationService: Provider.of(context)),
      child: LoginHeader(),
      builder: (context, model, child) => Scaffold(
        body: Builder(
          builder: (context) =>  ListView(
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          LoginTextField(
                            controller: emailController,
                            type: TextFieldTypes.Email,
                          ),
                          LoginTextField(
                            controller: passwordController,
                            type: TextFieldTypes.Password,
                          ),
                        ],
                      ),
                    ),
                    model.busy ? ConstantWidgets.progressIndicator : Container(),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: LoginButton(
                          model: model,
                          text: LocaleKeys.login_label_login_button.tr(),
                          emailController: emailController,
                          passwordController: passwordController,
                          callback: (LoginModel model) async {
                            bool isValid = _formKey.currentState.validate();
                            if (isValid) {
                              print(emailController.value.text.toString());
                              print(passwordController.value.text.toString());
                              Either loginSuccess = await model.loginWithCred(
                                  emailController.value.text.toString(),
                                  passwordController.value.text.toString());
                              print(loginSuccess);
                              if (loginSuccess.sucsess) {
                                print(RoutePaths.Home);
                                Navigator.popAndPushNamed(
                                    context, RoutePaths.Home);
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text(loginSuccess.err),));
                              }
                            }
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: LoginButton(
                            model: model,
                            text: LocaleKeys.login_label_gsignin_button.tr(),
                            emailController: emailController,
                            passwordController: passwordController,
                            callback: (model) async {
                              bool loginSuccess = await model.login();
                              print(loginSuccess);
                              if (loginSuccess) {
                                print(RoutePaths.Home);
                                Navigator.popAndPushNamed(
                                    context, RoutePaths.Home);
                              }
                            }))
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
