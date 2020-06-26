import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:poc/routes.dart';
import 'package:poc/services/authentication_service.dart';
import 'package:poc/views/post_view.dart';
import 'package:provider/provider.dart';

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
          'Explore',
          style: TextStyle(color: Colors.deepPurple, fontSize: 20),
        ),
        actions: <Widget>[
          NeumorphicButton(
              onPressed: () async {
                bool isSuccess =
                    await Provider.of<AuthenticationService>(context,listen: false).logOut();
                if (isSuccess) {
                  Navigator.popAndPushNamed(context, RoutePaths.Splash);
                }
              },
              child: Icon(Icons.exit_to_app))
        ],
      ),
//      appBar: PreferredSize(
//        child: Neumorphic(
////          drawSurfaceAboveChild: true,
//          style: NeumorphicStyle(
//              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
//                  bottomLeft: BorderRadius.circular(0).bottomLeft,
//                  bottomRight: BorderRadius.circular(0).bottomLeft)),
//              shape: NeumorphicShape.flat,
//              shadowDarkColorEmboss: Colors.red,
//              shadowLightColorEmboss: Colors.deepOrange,
//              depth: 5,
//              shadowDarkColor: Colors.black,
//              shadowLightColor: Color(0xff4B4B4B)),
//          child: Padding(
//            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//            child: Center(
//              child: Text(
//                'Explore',
//                style: TextStyle(color: Colors.deepPurple, fontSize: 20),
//              ),
//            ),
//          ),
//        ),
//        preferredSize: Size(double.maxFinite, 66),
//      ),
      body: PostView(),
    );
  }
}
