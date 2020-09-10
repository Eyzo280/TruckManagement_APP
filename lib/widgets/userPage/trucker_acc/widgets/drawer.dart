import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/screens/myAppliactions.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/screens/settings.dart';
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
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                stops: [0.001, 1],
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).canvasColor,
                ],
              ),
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
                  /*decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              NetworkImage('https://i.imgur.com/BoN9kdC.png'),
                          fit: BoxFit.fill),
                      shape: BoxShape.circle),*/
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Szukaj Firmy'),
            onTap:
                null /* () {
              //openSearchCompany(context, user);
            }*/
            ,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Zaproszenia'),
            onTap: null /* () {}*/,
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Szukaj Pracy'),
            onTap: () {
              Navigator.popAndPushNamed(context, Advertisements.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Moje Aplikacje'),
            onTap: () {
              Navigator.of(context).pushNamed(MyApplications.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat'),
            onTap:
                null /* () {
              //_openChats(context, user.driverUid);
            }*/
            ,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(Settings.routeName);
            },
          ),
        ],
      ),
    );
  }
}
