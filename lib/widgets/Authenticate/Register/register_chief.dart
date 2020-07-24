import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/checkboxformfield.dart';
import '../../../models/Authenticate.dart';
import '../../../services/auth.dart' as auth;

class RegisterChief extends StatefulWidget {
  final Function toggleView;
  final Size deviceSize;

  RegisterChief({
    this.toggleView,
    this.deviceSize,
  });

  @override
  _RegisterChiefState createState() => _RegisterChiefState();
}

class _RegisterChiefState extends State<RegisterChief> {
  final _formkey = GlobalKey<FormState>();

  bool checkBoxValue = false;
  bool loading = false;

  // Register Data
  Chief data = Chief(
    email: null,
    nameCompany: null,
    nickname: null,
    password: null,
  );
  //

  // Focus fields
  FocusNode focusNameComapny = FocusNode();
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
        nameCompany: data.nameCompany,
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
                        'Register Chief',
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
                      onFieldSubmitted: (_) => focusNameComapny.requestFocus(),
                      onSaved: (val) {
                        data = Chief(
                          email: val,
                          nameCompany: data.nameCompany,
                          nickname: data.nickname,
                          password: data.password,
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Name Comapany'),
                      validator: (val) =>
                          val.isEmpty ? 'Prosze podac Name Comapany' : null,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => focusNickname.requestFocus(),
                      focusNode: focusNameComapny,
                      onSaved: (val) {
                        data = Chief(
                          email: data.email,
                          nameCompany: val,
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
                        data = Chief(
                            email: data.email,
                            nameCompany: data.nameCompany,
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
                      onFieldSubmitted: (_) => register(),
                      focusNode: focusPassword,
                      obscureText: true,
                      onSaved: (val) {
                        data = Chief(
                          email: data.email,
                          nameCompany: data.nameCompany,
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
                      margin: const EdgeInsets.symmetric(vertical: 10),
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
