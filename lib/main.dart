import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poc/providers.dart';
import 'package:poc/routes.dart';
import 'package:poc/views/login_view.dart';
import 'package:poc/views/splash_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: NeumorphicApp(
        title: 'Flutter Demo',
        theme: NeumorphicThemeData()
            .copyWith(textTheme: GoogleFonts.bungeeTextTheme()),
        darkTheme: NeumorphicThemeData()
            .copyWith(textTheme: GoogleFonts.bungeeTextTheme()),
        home: SplashView(),
        initialRoute: RoutePaths.Splash,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
