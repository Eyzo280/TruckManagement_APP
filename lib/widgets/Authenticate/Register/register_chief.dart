import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/constants.dart';
import '../../../models/register.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: widget.deviceSize.height,
          decoration: const BoxDecoration(
            image: const DecorationImage(
                image: const AssetImage("images/Background-Image.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Nickname'),
                          validator: (val) =>
                              val.isEmpty ? 'Prosze podac Nickname' : null,
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
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          validator: (val) =>
                              val.isEmpty ? 'Prosze podac Password' : null,
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
          ),
        ),
      ),
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
