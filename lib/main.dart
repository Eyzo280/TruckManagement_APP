import 'package:flutter/material.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/Authenticate/authenticate.dart';
import 'package:truckmanagement_app/widgets/shared/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/select_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: basicTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<LoginUser>.value(
          value: AuthService().user,
        ),
      ],
      child: Consumer<LoginUser>(
        builder: (context, loginUser, _) {
          return loginUser == null
              ? Loading()
              : loginUser.uid == null
                  ? MaterialApp(
                      home: Authenticate(),
                    )
                  : StreamProvider<UserData>.value(
                      value: DatabaseService(uid: loginUser.uid).userData,
                      child: MaterialApp(
                        home: SelectUser(),
                      ),
                    );
        },
      ),
    );
  }
}
