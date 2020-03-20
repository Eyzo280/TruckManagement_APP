/*
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/truckDriver.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/chiefLookTrucker/main_chief_look_trucker.dart';

class ChiefMain extends StatefulWidget {
  final Function userLogout;
  final String userLogin;
  final String userPassword;

  // po zalogowaniu powinno pobierac dane o uzytkowniku
  // Tymczasowo dane beda na sztywno

  String nameThief = 'Zdzislaw';
  double balancebusiness;
  List<TruckDriver> listDriversTrucks = [
    TruckDriver(
      id: '1',
      firstNameDriver: 'Stasiek',
      lastNameDriver: 'W',
      salary: 5000.00,
      earned: 3000,
      paid: 2500,
      distanceTraveled: 12000,
      statusDriver: false,
      costDriver: 1500.00,
      numberPhone: '52341413',
      dateOfEmplotment: DateTime.now(),
      payday: DateTime.now(),
    ),
    TruckDriver(
      id: '2',
      firstNameDriver: 'Waldek',
      lastNameDriver: 'S',
      salary: 7500.00,
      earned: 12000,
      paid: 9300,
      distanceTraveled: 300000,
      statusDriver: true,
      costDriver: 1500.00,
      numberPhone: '52341413',
      dateOfEmplotment: DateTime.now(),
      payday: DateTime.now(),
    ),
  ];

  ChiefMain({this.userLogout, this.userLogin, this.userPassword});

  @override
  _ChiefMainState createState() => _ChiefMainState();
}

class _ChiefMainState extends State<ChiefMain> {
  //----------------------------- Usuwanie ze zmiennych danych uzytkownika oraz rozpoczecie wylogowania
  void userLogoutAndClear() {
    // Trzeba wstawic wszystkie zmienne, ktore nalezy wyczyscic
    widget.nameThief = '';
    widget.listDriversTrucks = [];
    if (widget.nameThief == '' && widget.listDriversTrucks.isEmpty) {
      // aby sprawdzilo czy napewno usunely sie dane uzytkownika
      print('Wylogowano poprawnie (1/2)');
      widget.userLogout();
      return;
    } else {
      widget.nameThief = '';
      widget.listDriversTrucks = [];
      print('Wylogowano poprawnie (1/2)');
      widget.userLogout();
    }
  }
  //-----------------------------

  //----------------------------- Przycisk Open ChiefLookTrucker
  void openChiefLookTrucker(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return MainChiefLookTrucker(listDriversTrucks: widget.listDriversTrucks,); // wysyla liste listDriversTrucks i otwiera ChiefLookTrucker
      }),
    );
  }
  //-----------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glowny Panel - ${widget.nameThief}'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(Icons.lock_outline),
              onPressed: () {
                userLogoutAndClear();
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 70,
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 2.0, color: Color(0xFFFF000000)),
                          right: BorderSide(
                              width: 2.0, color: Color(0xFFFF000000)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Kierowcy: Koszty Utrzymania: 000k',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 2.0, color: Color(0xFFFF000000)),
                          right: BorderSide(
                              width: 2.0, color: Color(0xFFFF000000)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Spedytorzy: Koszty Utrzymania: 000k',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 2.0, color: Color(0xFFFF000000)),
                          right: BorderSide(
                              width: 2.0, color: Color(0xFFFF000000)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Ciezarowki: Koszty Utrzymania: 000k',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 2.0, color: Color(0xFFFF000000)),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Kursy: Przychody: 000k',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ), ///////////////////////////////////////////////////////////////// Wykres
            Container(
              width: double.infinity,
              height: 70,
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        openChiefLookTrucker(context);
                        print('Kierowcy');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                            bottom: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                            right: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Kierowcy',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        print('Spedytorzy');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                            bottom: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                            right: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Spedytorzy',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        print('Ciezarowki');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                            bottom: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                            right: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Ciezarowki',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        print('Kursy');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                            bottom: BorderSide(
                                width: 2.0, color: Color(0xFFFF000000)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Kursy',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/