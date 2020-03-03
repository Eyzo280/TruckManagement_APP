import 'dart:async';

import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/loginPage/logging_page.dart';
import 'package:truckmanagement_app/widgets/userPage/user_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //---------------------------- Funkcja zmiany jezyka
  String dropdownValue = 'PL';

  void changeLanguage(newValue) {
    setState(() {
      dropdownValue = newValue;
    });
  }

  //-----------------------------
  //----------------------------- funkcja Logowania
  bool
      statusLoginUser; // W przyszlosci ma oznaczac czy uzytkownik jest zalogowany czy nie
  String _login = '';
  String _password = '';

  void logging(_login, _password) {
    _login = _login.text;
    _password = _password.text;
    if (_login.isEmpty || _password.isEmpty) {
      return;
    }
    setState(() {
      statusLoginUser = true;
    });
    print(_login + ' ' + _password);
  }

  //-----------------------------

  //----------------------------- Wylogowanie Uzytkownika
  void logout() {
    setState(() {
      statusLoginUser = null;
      _login = '';
      _password = '';
      if (statusLoginUser == null && _login == '' && _password == '') {
        // aby sprawdzilo czy napewno usunely sie dane logowania
        print('Wylogowano poprawnie (2/2)');
        return;
      } else {
        statusLoginUser = null;
        _login = '';
        _password = '';
        print('Wylogowano poprawnie (2/2)');
      }
    });
  }

  //-----------------------------
  @override
  Widget build(BuildContext context) {
    return (statusLoginUser == true
        ? UserMain(
            userLogout: logout,
            userLogin: _login,
            userPassword: _password,
          )
        : LoggingPage(dropdownValue, changeLanguage, logging));
  }
}
