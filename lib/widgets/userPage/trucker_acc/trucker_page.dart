import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_search_company.dart';
import 'widgets/drawer.dart';

class TruckerPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  void openSearchCompany(BuildContext ctx, DriverTruck user) {
    Navigator.of(ctx).pushNamed(
      TruckerSearchCompany.routeName,
      arguments: {
        'userData': user,
      },
    );
  }

  void _openChats(BuildContext ctx, String driverUid) {
    Navigator.of(ctx).pushNamed(Chats.routeName, arguments: {
      'userUid': driverUid,
    });
  }

  @override
  Widget build(BuildContext context) {
    final Trucker user = Provider.of<UserData>(context).data ?? null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kierowca - ${user.nickName}',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(Icons.lock_outline),
              onPressed: () async {
                return await _auth.signOut(context);
              },
            ),
          ),
        ],
      ),
      drawer: DrawerTrucker(
        uid: user.uid,
        nickName: user.nickName,
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 5,
            child: Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      user != null
                          ? Text('Nickname: ${user.nickName}')
                          : CircularProgressIndicator(),
                      user != null
                          ? Text('Prawo jazdy: -')
                          : CircularProgressIndicator(),
                      user != null
                          ? Text('Przejechane km: 0')
                          : CircularProgressIndicator(),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Center(child: Text('Img')),
                ),
                /*Image(
                    
                  ),
                  */
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Obecna Firma:'),
                      Text('Imie Szefa:'),
                      Text('Przejechane km:'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(20)),
                          child: Container(
                            color: Colors.blue,
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              'Obecny Kurs',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Opacity(opacity: 0.0),
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )),
                  margin: EdgeInsets.only(top: 0),
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              Text('Obecny Kurs:'),
                              Text('Data Dostawy:'),
                              Text('Ciezarowka:'),
                              Text('Data Dostawy:'),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              child: Text('Kontakt ze spedytorem'),
                              onPressed: () {},
                            ),
                            RaisedButton(
                              child: Text('Zaznacz punkt dostawy'),
                              onPressed: () {},
                            ),
                            RaisedButton(
                              child: Text('Kontakt z Szefem'),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 5,
            child: Container(
              height: 200,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
