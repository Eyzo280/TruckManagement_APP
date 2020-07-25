import 'package:flutter/material.dart';
import 'package:truckmanagement_app/models/Authenticate.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  final Size deviceSize;

  SignIn({
    this.toggleView,
    this.deviceSize,
  });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();

  // Form Data
  final _formkey = GlobalKey<FormState>();
  Login loginData = Login(
    email: null,
    password: null,
  );
  //

  // state
  bool loading = false;
  String error = '';
  //

  // Focus fields
  FocusNode focusPassword = FocusNode();
  //

  Future logging() async {
    setState(() {
      error = '';
      loading = true;
    });
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      await _auth
          .signInWithEmailAndPassword(
              email: loginData.email, password: loginData.password)
          .catchError((err) {
        setState(() {
          error = 'Prosze sprawdzic poprawnosc danych';
          loading = false;
        });
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Form(
          key: _formkey,
          child: Card(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            margin: EdgeInsets.all(25),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
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
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) =>
                        val.isEmpty ? 'Prosze podac email' : null,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => focusPassword.requestFocus(),
                    onSaved: (val) {
                      loginData = Login(
                        email: val,
                        password: loginData.password,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) =>
                        val.isEmpty ? 'Prosze podac haslo' : null,
                    onFieldSubmitted: (_) => logging(),
                    focusNode: focusPassword,
                    obscureText: true,
                    onSaved: (val) {
                      loginData = Login(
                        email: loginData.email,
                        password: val,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: error == '' ? 0 : 1,
                    child: Text(
                      error,
                      style: TextStyle(
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    constraints:
                        BoxConstraints(minHeight: error == '' ? 0 : 20),
                    child: SizedBox(),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    constraints: BoxConstraints(
                        minWidth: loading == false ? 110 : 30,
                        minHeight: loading == false ? 40 : 20),
                    child: RaisedButton(
                      onPressed: loading ? null : logging,
                      child: loading
                          ? const FittedBox(
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Zaloguj'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
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
                          onPressed: loading
                              ? null
                              : () {
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
          height: widget.deviceSize.height * 0.075,
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
            onPressed: loading
                ? () {}
                : () {
                    print('Kontakt');
                  },
          ),
        ),
      ],
    );
  }
}
