import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import '../../../models/Authenticate.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) =>
                        val.isEmpty ? 'Prosze podac email' : null,
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
                    title: Column(
                      children: <Widget>[
                        Text(
                          'Akceptuje regulamin aplikacji. ',
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
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _formkey.currentState.save();
                        // Function Register
                      }
                    },
                    child: const Text('Register'),
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
    );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget title,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<bool> state) {
            return CheckboxListTile(
              dense: state.hasError,
              title: title,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
