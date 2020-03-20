import 'package:flutter/material.dart';
import 'package:truckmanagement_app/services/auth.dart';

class LoggingPage extends StatefulWidget {
  final String _dropDownValueLanguage;
  final Function _change_Language_function;
  final Function _start_logging;

  LoggingPage(this._dropDownValueLanguage, this._change_Language_function,
      this._start_logging);

  @override
  _LoggingPageState createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  final _value_login = TextEditingController();

  final _value_password = TextEditingController();

  // System Logowania

  final AuthService _auth = AuthService();

  //

  Widget _loginAndPasswordFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 35,
        ),
        Text('Login:'),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 250,
          color: Colors.grey[300],
          child: TextField(
            controller: _value_login,
            onSubmitted: (_) {
              widget._start_logging(_value_login, _value_password);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15),
              prefixIcon: Icon(Icons.account_circle),
              hintText: 'Podaj Login',
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text('Password:'),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 250,
          color: Colors.grey[300],
          child: TextField(
            controller: _value_password,
            onSubmitted: (_) {
              widget._start_logging(_value_login, _value_password);
            },
            style: TextStyle(
              color: Colors.white,
            ),
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 15),
              prefixIcon: Icon(Icons.account_circle),
              hintText: 'Podaj Haslo',
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return Container(
      width: 250,
      child: RaisedButton(
        onPressed: () async {
         // widget._start_logging(_value_login, _value_password);
          dynamic result = await _auth.signInAnon();

          if (result == null) {
            print('Problem z logowaniem');
          }else {
            print('Zalogowano poprawnie');
            print(result.uid);
          }

        },
        child: Text('Zaloguj'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TruckerManagement'),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    DropdownButton<String>(
                      // przyklad ze strony fluttera
                      value: widget._dropDownValueLanguage,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.grey),
                      underline: Container(
                        height: 2,
                        color: Colors.greenAccent,
                      ),
                      onChanged: (String newValue) {
                        widget._change_Language_function(newValue);
                      },
                      items: <String>['PL', 'EN']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
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
                  Column(
                    // to trzeba zawinac w container
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _loginAndPasswordFields(),
                      FlatButton(
                        padding: EdgeInsets.only(right: 0.0),
                        onPressed: () {
                          print('Forgot Password?');
                        },
                        child: Text('Forgot Password?'),
                      ),
                      _loginButton(),
                      Text(''),
                    ],
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
