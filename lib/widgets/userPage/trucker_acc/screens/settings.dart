import 'package:flutter/material.dart';

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
          Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            elevation: 10,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              onTap: () {},
              contentPadding: EdgeInsets.all(15),
              leading: Text('Avatar'),
              title: Text(
                'Stefan',
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 15),
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          )
        ],
      ),
    );
  }
}
