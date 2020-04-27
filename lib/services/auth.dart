import 'package:firebase_auth/firebase_auth.dart';
import 'package:truckmanagement_app/main.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, displayName: user.displayName) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user)); // mozna tez tak zapisac
        .map(_userFromFirebaseUser);
  }

  // logowanie anonimowe
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Logowanie za pomoca email i hasla

  Future signInWithEmailAndPassword({String email, String password}) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e);
    }
  }

  // Rejestracja za pomoca email i hasla

  Future registerWithEmailAndPassword({String email, String displayName, String nameCompany, String firstName, String lastName, String password, String type}) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = displayName;
      await user.updateProfile(userUpdateInfo);
      await DatabaseService(uid: user.uid).updateUserData(nameCompany: nameCompany,firstName: firstName, lastName: lastName, type: type);
      return user;
    } catch (e) {
      print(e);
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
