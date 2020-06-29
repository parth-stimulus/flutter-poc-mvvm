import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poc/generated/local_keys.g.dart';
import 'package:poc/models/either.dart';
import 'package:poc/services/firebase_services.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthenticationService {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _fbAuth = FirebaseAuth.instance;
  final FirebaseServices _firebaseServices;

  StreamController<FirebaseUser> _userController =
      StreamController<FirebaseUser>();

  AuthenticationService({FirebaseServices firebaseServices})
      : _firebaseServices = firebaseServices;

  Stream<FirebaseUser> get user => _userController.stream;

  Future<bool> logOut() async {
    return _fbAuth.signOut().then((value) => true);
  }

  Future<Either> login() async {
    FirebaseUser user = await _fbAuth.currentUser();
    if (user != null) {
      return Either(true, '');
    } else {
      try {
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final AuthResult auth = await _fbAuth.signInWithCredential(credential);
        if (auth.user != null) {
          _userController.sink.add(user);
          return Either(true, '');
        } else {
          return Either(false, '');
        }
      } catch (e) {
        return Either(false, e.message);
      }
    }
  }

  Future<Either> loginWithCred(String email, String password) async {
    AuthResult isSuccess;
    Either either;
    String err = '';
    List<String> methods =
        await _fbAuth.fetchSignInMethodsForEmail(email: email);
    if (methods.length != 0) {
      try {
        isSuccess = await _fbAuth.signInWithEmailAndPassword(
            email: email, password: password);
        if (isSuccess != null) {
          either = Either(true, '');
        }
      } catch (e) {
        switch (e.message) {
          case 'The given password is invalid. [ Password should be at least 6 characters ]':
            either = Either(false, e.message);
            break;
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            either = Either(false, LocaleKeys.login_err_no_user.tr());
            break;
          case 'The password is invalid or the user does not have a password.':
            either = Either(false, LocaleKeys.login_loginErrMsg_password.tr());
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            either = Either(false, LocaleKeys.login_err_no_network.tr());
            break;
          default:
            either = Either(false, e.message);
            print('Case ${e.message} is not yet implemented');
            break;
        }
      }
      if (isSuccess != null) {
        either = Either(true, '');
      }
    } else {
      try {
        isSuccess = await _fbAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (isSuccess != null) {
          either = Either(true, '');
        }
      } catch (e) {
        switch (e.message) {
          case 'The given password is invalid. [ Password should be at least 6 characters ]':
            either = Either(false, e.message);
            break;
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            either = Either(false, LocaleKeys.login_err_no_user.tr());
            break;
          case 'The password is invalid or the user does not have a password.':
            either = Either(false, LocaleKeys.login_loginErrMsg_password.tr());
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            either = Either(false, LocaleKeys.login_err_no_network.tr());
            break;
          default:
            either = Either(false, e.message);
            print('Case ${e.message} is not yet implemented');
            break;
        }
      }
    }
    return either;
  }

  Future<Either> checkLogin() async {
    Either either;
    try {
      FirebaseUser currentUser = await _fbAuth.currentUser();
      print(currentUser);
      either = Either(currentUser != null, '');
    } catch (e) {
      either = Either(false, e.message);
    }
    return either;
  }
}
