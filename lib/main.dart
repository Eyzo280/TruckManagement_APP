import 'dart:async';

import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/error_page/error_page.dart';
import 'package:truckmanagement_app/widgets/loginPage/logging_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/chief_main.dart';
import 'package:truckmanagement_app/widgets/userPage/forwarder_acc/forwarder_main.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
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
  List user_list_type = ['Chief', 'Trucker', 'Forwarder'];

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
  String _type_acc = '';

  void logging(_login, _password) {
    _login = _login.text;
    _password = _password.text;

    if (_login.isEmpty || _password.isEmpty) {
      return;
    }

    setState(() {
      _type_acc = 'Chief'; // W przyszlosci ma pobierac typ konta z bazy danych

      // Sprawdzenie czy dany typ konta istnieje
      for (var i = 0; i < user_list_type.length; i++) {
        if (_type_acc != user_list_type[i]) {
          if (i == user_list_type.length - 1) {
            _login = '';
            _password = '';
            _type_acc = '';

            print(
                'Uzytkownik z konta: Login: ${_login}, Password: ${_password}, probowal zalogowac sie z nieistniejacym typem konta');
            return;
          }
        } else {
          statusLoginUser = true;

          print(
              'Zalogowano na Login: ${_login}, Password: ${_password}, Type_acc: ${_type_acc}');
          return;
        }
      }
    });
  }

  //-----------------------------

  //----------------------------- Wylogowanie Uzytkownika
  void logout() {
    setState(() {
      statusLoginUser = null;
      _login = '';
      _password = '';
      _type_acc = '';
      if (statusLoginUser == null &&
          _login == '' &&
          _password == '' &&
          _type_acc == '') {
        // aby sprawdzilo czy napewno usunely sie dane logowania
        print('Wylogowano poprawnie (2/2)');
        return;
      } else {
        statusLoginUser = null;
        _login = '';
        _password = '';
        _type_acc = '';
        print('Wylogowano poprawnie (2/2)');
      }
    });
  }

  //-----------------------------
  @override
  Widget build(BuildContext context) {
    return (statusLoginUser == true
        ? _type_acc == 'Chief'
            ? ChiefMain(
                userLogout: logout,
                userLogin: _login,
                userPassword: _password,
              )
            : _type_acc == 'Trucker'
                ? TruckerMain()
                : _type_acc == 'Forwarder'
                    ? ForwarderMain()
                    : ErrorPage() // jezeli w jakis sposob funkcja nie zatrzyma logowania to wyskoczy ta strona
        : LoggingPage(dropdownValue, changeLanguage, logging));
  }
}
