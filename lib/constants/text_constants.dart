import 'package:flutter/cupertino.dart';

class TextConstantsEn {
  static Locale locale =
      Locale.fromSubtags(languageCode: 'en');
  static const String loginErrMsg_email = 'Please enter a valid Email';
  static const String loginErrMsg_password =
      'Please enter a Non empty Password';
  const TextConstantsEn();
}

class TextConstants {
  static const TextConstantsEn en = TextConstantsEn();
}
