import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/settings/user.dart';

class Settings extends StatelessWidget {
  static const routeName = '/Settings/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ustawienie'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SettingsUser(),
        ],
      ),
    );
  }
}
