import 'package:chatzie/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';

class AccessController extends GetxController{

  final _auth = FirebaseAuth.instance;
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;


  Future register(String email, String password) async {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future logIn(String email, String password) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future signOut() async {
    return _auth.signOut();
  }

  Future<FirebaseUser> fbSignIn(BuildContext context) async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(customPermissions: ['email']);
    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential =
    FacebookAuthProvider.getCredential(accessToken: accessToken.token);
    var a =
    await _fAuth.signInWithCredential(credential);
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(mode: 1)));
    return a.user;
  }

  Future fbSignOut(BuildContext context) async {
    print('Signed out');
    return await facebookSignIn.logOut();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

}