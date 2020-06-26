import 'package:flutter/material.dart';
import 'package:poc/models/splash_view_model.dart';
import 'package:poc/routes.dart';
import 'package:poc/widgets/base_widget.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashViewModel>(
      child: CircularProgressIndicator(),
      builder: (context, model, child) => Container(),
      model: SplashViewModel(authenticationService: Provider.of(context)),
      onModelReady: (model) async {
        bool isLoggedin = await model.checkLogin();
        print('splash');
        print(isLoggedin);
        if (isLoggedin) {
          Navigator.popAndPushNamed(context, RoutePaths.Home);
        } else {
          Navigator.popAndPushNamed(context, RoutePaths.Login);
        }
      },
    );
  }
}
