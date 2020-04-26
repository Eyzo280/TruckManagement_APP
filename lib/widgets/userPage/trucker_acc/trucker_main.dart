import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/chat.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/services_Trucker/database_Trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_search_company.dart';

class TruckerMain extends StatelessWidget {
  final AuthService _auth = AuthService();

  void openSearchCompany(BuildContext ctx, user) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return StreamProvider<List<BaseSearchCompany>>.value(
        value: DataBase_Trucker().getBaseSearchCompany,
        child: TruckerSearchCompany(user)); // trzeba dac wysylanie id kierowcy
    }));
  }

  void _openChats(ctx, companyUid) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return StreamProvider<List<PeerChat>>.value(
        value: Chat(mainUid: companyUid, peopleUid: null).getUserChats(),
        child: Chats(companyUid: companyUid),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DriverTruck>(context) ?? null;
    return Scaffold(
      appBar: AppBar(
        title: Text('Kierowca - Nazwa'),
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
      drawer: Drawer(
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
                      user.firstNameDriver + ' ' + user.lastNameDriver,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(width: MediaQuery.of(context).size.height * 0.1, height: MediaQuery.of(context).size.height * 0.1, decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('https://i.imgur.com/BoN9kdC.png'), fit: BoxFit.fill), shape: BoxShape.circle),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text('ID: ${user.driverUid}'),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('Szukaj Firmy'),
              onTap: () {
                openSearchCompany(context, user);
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Zaproszenia'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat'),
              onTap: () {
                _openChats(context, user.driverUid);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
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
                      user != null ? Text('Imie: ${user.firstNameDriver}') : CircularProgressIndicator(),
                      user != null ? Text('Nazwisko: ${user.lastNameDriver}') : CircularProgressIndicator(),
                      user != null ? Text('Prawo jazdy: ${user.drivingLicense}') : CircularProgressIndicator(),
                      user != null ? Text('Przejechane km: ${user.totalDistanceTraveled}') : CircularProgressIndicator(),
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
