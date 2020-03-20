import 'package:flutter/material.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formkey = GlobalKey<FormState>();

  bool loading = false;

  // Textfields state
  String email = '';
  String password = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text('TruckerManagement - Login'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Text(
              'Register',
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
                            decoration: textInputDecoration.copyWith(hintText: 'Email'),
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
                            decoration: textInputDecoration.copyWith(hintText: 'Password'),
                            validator: (val) => val.isEmpty
                                ? 'Prosze podac haslo'
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
                                dynamic result = await _auth.signInWithEmailAndPassword(email: email,password: password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Prosze sparwdzic poprawnosc danych';
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: Text('Zaloguj'),
                          ),
                          SizedBox(height: 20,),
                          Text(error, style: TextStyle(color: Colors.red),),
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
