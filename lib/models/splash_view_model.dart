import 'package:flutter/foundation.dart';
import 'package:poc/models/base_model.dart';
import 'package:poc/services/authentication_service.dart';
import 'package:poc/widgets/base_widget.dart';

class SplashViewModel extends BaseModel {
  AuthenticationService _authenticationService;

  SplashViewModel({
    @required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  Future<bool> checkLogin() async {
    setBusy(true);
    bool isLoggedin = await _authenticationService.checkLogin();
    setBusy(false);
    return isLoggedin;
  }
}
