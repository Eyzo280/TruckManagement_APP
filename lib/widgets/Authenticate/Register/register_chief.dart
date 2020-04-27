import 'package:flutter/material.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';

class RegisterChief extends StatefulWidget {
  final Function toggleView;

  RegisterChief({this.toggleView});

  @override
  _RegisterChiefState createState() => _RegisterChiefState();
}

class _RegisterChiefState extends State<RegisterChief> {
  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  // Textfields state
  String email = '';
  String displayName = '';
  String firstName = '';
  String lastName = '';
  String nameCompany = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('TruckerManagement - Register'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
                          child: Container(
                            height: 700,
                            child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: new AssetImage("images/top_login_page.jpg"),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 9,
                    fit: FlexFit.tight,
                    child: Container(
                      color: Colors.grey[500],
                      child: Column(
                        children: <Widget>[
                            Form(
                              key: _formkey,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 80.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Email'),
                                      validator: (val) =>
                                          val.isEmpty ? 'Prosze podac email' : null,
                                      onChanged: (val) {
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'DisplayName'),
                                      validator: (val) => val.length < 6
                                          ? 'Prosze podac haslo wieksze, niz 6 znakow'
                                          : null,
                                      obscureText: true,
                                      onChanged: (val) {
                                        setState(() {
                                          displayName = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Imie'),
                                      validator: (val) => val.length < 6
                                          ? 'Prosze podac haslo wieksze, niz 6 znakow'
                                          : null,
                                      obscureText: true,
                                      onChanged: (val) {
                                        setState(() {
                                          firstName = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Nazwisko'),
                                      validator: (val) => val.length < 6
                                          ? 'Prosze podac haslo wieksze, niz 6 znakow'
                                          : null,
                                      obscureText: true,
                                      onChanged: (val) {
                                        setState(() {
                                          lastName = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Nazwa Firmy'),
                                      validator: (val) => val.length < 6
                                          ? 'Prosze podac haslo wieksze, niz 6 znakow'
                                          : null,
                                      obscureText: true,
                                      onChanged: (val) {
                                        setState(() {
                                          nameCompany = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: textInputDecoration.copyWith(
                                          hintText: 'Password'),
                                      validator: (val) => val.length < 6
                                          ? 'Prosze podac haslo wieksze, niz 6 znakow'
                                          : null,
                                      obscureText: true,
                                      onChanged: (val) {
                                        setState(() {
                                          password = val;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    RaisedButton(
                                      onPressed: () async {
                                        if (_formkey.currentState.validate()) {
                                          setState(() {
                                            loading = true;
                                          });
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(nameCompany: nameCompany,
                                                  email: email, displayName: displayName, firstName: firstName, lastName: lastName, password: password, type: 'Chief');
                                          if (result == null) {
                                            setState(() {
                                              error = 'Prosze sprawdzic poprawnosc danych.';
                                              loading = false;
                                            });
                                          }
                                        }
                                      },
                                      child: Text('Zarejestruj'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      error,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: FlatButton(
                                  child: Text('Kontakt'),
                                  onPressed: () {
                                    print('Kontakt');
                                  },
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
                          ),
            ),
          );
  }
}
