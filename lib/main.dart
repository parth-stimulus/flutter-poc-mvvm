import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poc/constants/text_constants.dart';
import 'package:poc/providers.dart';
import 'package:poc/routes.dart';
import 'package:poc/views/login_view.dart';
import 'package:poc/views/splash_view.dart';
import 'package:provider/provider.dart';

import 'generated/codegen_loader.g.dart';

void main() {
  runApp(EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      supportedLocales: [TextConstantsEn.locale],
      assetLoader: CodegenLoader(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: NeumorphicApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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
