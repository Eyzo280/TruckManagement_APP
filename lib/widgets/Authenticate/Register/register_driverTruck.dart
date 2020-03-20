import 'package:flutter/material.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';

class RegisterDriverTruck extends StatefulWidget {
  final Function toggleView;

  RegisterDriverTruck({this.toggleView});

  @override
  _RegisterDriverTruckState createState() => _RegisterDriverTruckState();
}

class _RegisterDriverTruckState extends State<RegisterDriverTruck> {
  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  // Textfields state
  String email = '';
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
            body: Column(
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
                  flex: 2,
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
                                  height: 50,
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
                                          .registerWithEmailAndPassword(
                                              email: email, password: password, typeUser: 'DriverTruck');
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
          );
  }
}
