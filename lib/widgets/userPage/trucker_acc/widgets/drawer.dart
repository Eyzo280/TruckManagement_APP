import 'package:flutter/material.dart';
import '../screens/advertisements.dart';

class DrawerTrucker extends StatelessWidget {
  final String uid;
  final String nickName;

  DrawerTrucker({
    this.uid,
    this.nickName,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FittedBox(
                  child: Text(
                    nickName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                          fit: BoxFit.fill),
                      shape: BoxShape.circle),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text('ID: ${uid}'),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Szukaj Firmy'),
            onTap: () {
              //openSearchCompany(context, user);
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Zaproszenia'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Szukaj Pracy'),
            onTap: () {
              Navigator.popAndPushNamed(context, Advertisements.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat'),
            onTap: () {
              //_openChats(context, user.driverUid);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
