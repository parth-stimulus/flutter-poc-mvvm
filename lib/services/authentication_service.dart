import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poc/services/firebase_services.dart';

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

  Future<bool> login() async {
    FirebaseUser user = await _fbAuth.currentUser();
    if (user != null) {
      return true;
    } else {
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
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> loginWithCred(String email, String password) async {
    AuthResult isSuccess;
    String err = '';
    List<String> methods =
        await _fbAuth.fetchSignInMethodsForEmail(email: email);
    if (methods.length != 0) {
      isSuccess = await _fbAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } else {
        isSuccess = await _fbAuth.createUserWithEmailAndPassword(
            email: email, password: password);
    }
    return isSuccess != null;
  }

  Future<bool> checkLogin() async {
    FirebaseUser currentUser = await _fbAuth.currentUser();
    print(currentUser);
    return currentUser != null;
  }
}
