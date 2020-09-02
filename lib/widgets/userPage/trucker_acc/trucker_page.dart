import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/widgets/chat/chats.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/trucker_search_company.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/truckerPage/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/truckerPage/unloading.dart';
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

  Widget termAndInfo(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).canvasColor,
                child: Center(
                  child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Terminy:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Załadunek: 02.09.2020',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Rozładunek: 05.09.2020',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).canvasColor,
                child: Center(
                  child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Pozostałe info:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          children: [
                            Text(
                              'Waga: 23.5 t',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Ładunek: Kawa',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Trucker user = Provider.of<UserData>(context).data ?? null;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Panel Główny',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 30),
            child: IconButton(
              icon: const Icon(Icons.lock_outline),
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
      // backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Card(
                  elevation: 15,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  margin: EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Theme.of(context).canvasColor,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Obecny Kurs: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    'Dortmund / Warszawa',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 4,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: Row(
                                    children: [
                                      // Punkty Zaladunek oraz Rozładunek
                                      Loading(),
                                      Unloading(),
                                    ],
                                  ),
                                ),
                                termAndInfo(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Map
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              margin: EdgeInsets.only(top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.asset('images/maps.JPG'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
