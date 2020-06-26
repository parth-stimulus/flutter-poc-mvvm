import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String type;

  LoginTextField({this.controller, this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Neumorphic(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (val) {
            if (type.toLowerCase() == 'email') {
              Pattern pattrn =
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
              if (pattrn.allMatches(val).isNotEmpty) {
                return null;
              } else {}
              return 'Please enter a valid Email';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(hintText: type),
          controller: controller,
          obscureText: type.toLowerCase() == 'password',
        ),
      ),
    );
  }
}
