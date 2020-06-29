import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:poc/generated/local_keys.g.dart';
import 'package:poc/routes.dart';
import 'package:poc/services/authentication_service.dart';
import 'package:poc/views/post_view.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(
          LocaleKeys.home_Appbar_lable.tr(),
          style: TextStyle(color: Colors.deepPurple, ),
        ),
        actions: <Widget>[
          NeumorphicButton(
              onPressed: () async {
                bool isSuccess = await Provider.of<AuthenticationService>(
                        context,
                        listen: false)
                    .logOut();
                if (isSuccess) {
                  Navigator.popAndPushNamed(context, RoutePaths.Splash);
                }
              },
              child: Icon(Icons.exit_to_app))
        ],
      ),
      body: PostView(),
    );
  }
}
