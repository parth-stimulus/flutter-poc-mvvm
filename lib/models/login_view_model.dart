import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:poc/enums/enums.dart';
import 'package:poc/models/base_model.dart';
import 'package:poc/services/authentication_service.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService;
  ViewState _state = ViewState.Idle;

  LoginModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  ViewState get state => _state;

  Future<bool> login() async {
    setBusy(true);
    bool isLoggedin = await _authenticationService.login();
    setBusy(false);
    return isLoggedin;
  }

  Future<bool> loginWithCred(String email, String password) async {
    setBusy(true);
    bool isLoggedin =
        await _authenticationService.loginWithCred(email, password);
    setBusy(false);
    return isLoggedin;
  }
}
