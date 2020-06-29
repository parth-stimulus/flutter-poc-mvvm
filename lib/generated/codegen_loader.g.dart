// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

    static const Map<String,dynamic> en = {
  "login": {
    "loginErrMsg_email": "Please enter a valid Email",
    "loginErrMsg_password": "Please enter a valid Password",
    "label_password": "Password",
    "label_email": "Email",
    "err_password": "Invalid Password",
    "err_no_user": "Sorry we can not Find any user with This email",
    "err_no_network": "Please Check Your Internet Connection",
    "label_login_button": "Login",
    "label_gsignin_button": "Login With Googles"
  },
  "home": {
    "Appbar_lable": "explore"
  }
};
  static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
