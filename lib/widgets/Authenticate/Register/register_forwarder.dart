import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/checkboxformfield.dart';
import '../../../models/Authenticate.dart';
import '../../../services/auth.dart' as auth;

class RegisterForwarder extends StatefulWidget {
  final Function toggleView;
  final Size deviceSize;

  RegisterForwarder({
    this.toggleView,
    this.deviceSize,
  });

  @override
  _RegisterForwarderState createState() => _RegisterForwarderState();
}

class _RegisterForwarderState extends State<RegisterForwarder> {
  final _formkey = GlobalKey<FormState>();

  bool checkBoxValue = false;
  bool loading = false;

  // Register Data
  Forwarder data = Forwarder(
    email: null,
    nickname: null,
    password: null,
  );
  //

  // Focus fields
  FocusNode focusNickname = FocusNode();
  FocusNode focusPassword = FocusNode();
  //

  Future register() async {
    setState(() {
      loading = true;
    });
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      await auth.AuthService().registerChief(
        email: data.email,
        nickName: data.nickname,
        password: data.password,
      );
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
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
                        'Register Forwarder',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) =>
                          val.isEmpty ? 'Prosze podac email' : null,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => focusNickname.requestFocus(),
                      onSaved: (val) {
                        data = Forwarder(
                          email: val,
                          nickname: data.nickname,
                          password: data.password,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Nickname'),
                      validator: (val) =>
                          val.isEmpty ? 'Prosze podac Nickname' : null,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => focusPassword.requestFocus(),
                      focusNode: focusNickname,
                      onSaved: (val) {
                        data = Forwarder(
                            email: data.email,
                            nickname: val,
                            password: data.password);
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) =>
                          val.isEmpty ? 'Prosze podac Password' : null,
                      obscureText: true,
                      onFieldSubmitted: (_) => register(),
                      focusNode: focusPassword,
                      onSaved: (val) {
                        data = Forwarder(
                          email: data.email,
                          nickname: data.nickname,
                          password: val,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CheckboxFormField(
                      validator: (val) {
                        if (val == true) {
                          return null;
                        } else
                          return 'Regulamin musi by zaakceptowany.';
                      },
                      title: Column(
                        children: <Widget>[
                          Text(
                            'Akceptuje regulamin aplikacji.* ',
                            style: TextStyle(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () {
                              // link to Rules
                            },
                            child: Text(
                              'Regulamin',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: loading ? null : register,
                      child: loading
                          ? const FittedBox(
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Register'),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Do you have an account? ',
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
        ],
      ),
    );
  }
}