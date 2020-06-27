import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:poc/constants/constants.dart';
import 'package:poc/generated/local_keys.g.dart';
import 'package:poc/models/login_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextFieldTypes type;

  LoginTextField({this.controller, this.type});

  String getHint() {
    switch (type) {
      case TextFieldTypes.Email:
        return LocaleKeys.login_label_email.tr();
        // TODO: Handle this case.
        break;
      case TextFieldTypes.Password:
        return LocaleKeys.login_label_password.tr();
        // TODO: Handle this case.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Neumorphic(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          keyboardType: type == TextFieldTypes.Email ?TextInputType.emailAddress : TextInputType.visiblePassword,
          validator: (val) {
            if (type == TextFieldTypes.Email) {
              Pattern pattern = Constants.emailPattern;
              if (pattern.allMatches(val).isEmpty) {
                return null;
              } else {
                return LocaleKeys.login_loginErrMsg_email.tr();
              }
            } else {
              if (val.isNotEmpty) {
                return null;
              } else {
                return LocaleKeys.login_loginErrMsg_password.tr();
              }
            }
          },
          decoration: InputDecoration(labelText: getHint()),
          controller: controller,
          obscureText: type == TextFieldTypes.Password,
        ),
      ),
    );
  }
}
