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
    Size deviceSize = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                decoration: const BoxDecoration(
                  image: const DecorationImage(
                      image: const AssetImage("images/Background-Image.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Form(
                      key: _formkey,
                      child: Card(
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                        margin: EdgeInsets.all(25),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 15.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 25),
                                child: const Text(
                                  'Login',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Password'),
                                validator: (val) =>
                                    val.isEmpty ? 'Prosze podac haslo' : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email: email, password: password);
                                    if (result == null) {
                                      setState(() {
                                        error =
                                            'Prosze sparwdzic poprawnosc danych';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: const Text('Zaloguj'),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      'Don\' have an account? ',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        widget.toggleView();
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.075,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: FlatButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        color: const Color.fromRGBO(0, 0, 0, 0.3),
                        child: const Text(
                          'Kontakt',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          print('Kontakt');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
