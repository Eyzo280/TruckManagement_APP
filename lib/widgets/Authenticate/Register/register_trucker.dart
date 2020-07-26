import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/checkboxformfield.dart';
import '../../../models/Authenticate.dart';
import '../../../services/auth.dart' as auth;

class RegisterTrucker extends StatefulWidget {
  final Function toggleView;
  final Size deviceSize;

  RegisterTrucker({
    this.toggleView,
    this.deviceSize,
  });

  @override
  _RegisterTruckerState createState() => _RegisterTruckerState();
}

class _RegisterTruckerState extends State<RegisterTrucker> {
  final _formkey = GlobalKey<FormState>();

  bool checkBoxValue = false;
  bool loading = false;

  // Register Data

  Trucker data = Trucker(
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
      await auth.AuthService()
          .registerTrucker(
        email: data.email,
        nickName: data.nickname,
        password: data.password,
      )
          .catchError((onError) {
        setState(() {
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
    return Form(
      key: _formkey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: const Text(
                'Register Trucker',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Email'),
              validator: (val) => val.isEmpty ? 'Prosze podac email' : null,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => focusNickname.requestFocus(),
              onSaved: (val) {
                data = Trucker(
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
              decoration: textInputDecoration.copyWith(hintText: 'Nickname'),
              validator: (val) => val.isEmpty ? 'Prosze podac Nickname' : null,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => focusPassword.requestFocus(),
              focusNode: focusNickname,
              onSaved: (val) {
                data = Trucker(
                    email: data.email, nickname: val, password: data.password);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Password'),
              validator: (val) => val.isEmpty ? 'Prosze podac Password' : null,
              obscureText: true,
              onFieldSubmitted: (_) => register(),
              focusNode: focusPassword,
              onSaved: (val) {
                data = Trucker(
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
                  const Text(
                    'Akceptuje regulamin aplikacji.* ',
                    style: const TextStyle(color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      // link to Rules
                    },
                    child: const Text(
                      'Regulamin',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeIn,
              constraints: BoxConstraints(
                  minWidth: loading == false ? 110 : 30,
                  minHeight: loading == false ? 40 : 20),
              child: RaisedButton(
                onPressed: loading ? null : register,
                child: loading
                    ? const SizedBox(
                        height: 25,
                        width: 25,
                        child: const CircularProgressIndicator(),
                      )
                    : const Text('Register'),
              ),
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
                    onPressed: loading
                        ? null
                        : () {
                            widget.toggleView('SignIn');
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
    );
  }
}
