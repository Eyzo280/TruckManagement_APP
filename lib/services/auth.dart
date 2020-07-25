import 'package:firebase_auth/firebase_auth.dart';
import 'package:truckmanagement_app/main.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginUser _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? LoginUser(uid: user.uid)
        : null;
  }

  Stream<LoginUser> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user)); // mozna tez tak zapisac
        .map(_userFromFirebaseUser);
  }

  // Logowanie

  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Rejestracja

  Future registerChief({
    String email,
    String nameCompany,
    String nickName,
    String password,
  }) async {
    try {
      String createdDate = DateTime.now().toIso8601String();
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).registerChiefDatabase(
        nameCompany: nameCompany,
        nickName: nickName,
        createdDate: createdDate,
      );
      return user;
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future registerForwarder({
    String email,
    String nickName,
    String password,
  }) async {
    try {
      String createdDate = DateTime.now().toIso8601String();
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).registerForwarderDatabase(
        nickName: nickName,
        createdDate: createdDate,
      );
      return user;
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future registerTrucker({
    String email,
    String nickName,
    String password,
  }) async {
    try {
      String createdDate = DateTime.now().toIso8601String();
      AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).registerTruckerDatabase(
        nickName: nickName,
        createdDate: createdDate,
      );
      return user;
    } catch (err) {
      print(err);
      throw err;
    }
  }

  // Wylogowanie

  Future signOut(context) async {
    try {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (ctx) {
            _auth.signOut();
            return MyApp();
          },
        ),
      );
      // return await _auth.signOut();
    } catch (e) {
      print('Wystapil blad przy wylogowywaniu.');
      print(e);
      return null;
    }
  }
}
