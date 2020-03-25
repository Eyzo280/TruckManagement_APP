import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/services/auth.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/services/database.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/chief_select_page.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/main_company_look_trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/services_company/database_company.dart';

class CompanyMain extends StatelessWidget {
  final AuthService _auth = AuthService();

  void openChiefLookTrucker(BuildContext ctx, user) {
    Navigator.of(ctx).push(
      MaterialPageRoute(builder: (_) {
        return StreamProvider<List<BaseTruckDriverData>>.value(
            value:
                Database_CompanyEmployees(uid: user.uid).getBaseDataEmployees,
            child:
                MainCompanyLookTrucker()); // wysyla liste listDriversTrucks i otwiera ChiefLookTrucker
      }),
    );
  }

  void openSelectPage(BuildContext ctx, companyUid) {
    Navigator.pushReplacement(ctx, MaterialPageRoute(
      builder: (ctx) {
        String method(String str) {
          return str.substring(0, str.length - 2);
        } // Teraz problemem jest ze gdyby ktos mial ponad 9 firm to bedzie odejmowac tylko dwie koncowe litery i bedzie blad

        return StreamProvider<List<ChiefUidCompanys>>.value(
          value: DatabaseService(uid: method(companyUid)).getUidCompanys,
          child: ChiefSelectPage(),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final companyData = Provider.of<CompanyData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Panel Firmy - ${companyData.nameCompany}'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 30),
            child: IconButton(
              icon: Icon(Icons.lock_outline),
              onPressed: () async {
                return await _auth.signOut();
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
              child: Text(
                'Zarzadzanie',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.chrome_reader_mode),
              title: Text('Zmien Zarzadzanie'),
              onTap: () {
                openSelectPage(context, companyData.uidCompany);
                print('Zmien Zarzadzanie');
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Zaproszenia'),
              onTap: () {
                print('Zaproszenia');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                print('Settings');
              },
            ),
          ],
        ),
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
              height: 100,
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.blue),
                            child: Center(child: Text('Kierowcy')),
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    openChiefLookTrucker(
                                        context, companyData.uidCompany);
                                    print('Podglad Kierowcow Firmy');
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: FittedBox(
                                        child: Text(
                                          'Podglad',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    // Trzeba zrobic nowe okno z zapraszaniem nowych kierowcow
                                    print('Szukaj nowych kierowcow');
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            child: Text(
                                              'Szukaj',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              'Nowych',
                                              textAlign: TextAlign.center,
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
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.blue),
                            child: Center(child: Text('Spedytorzy')),
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    print('Podglad Spedytorow Firmy');
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: FittedBox(
                                        child: Text(
                                          'Podglad',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    // Trzeba zrobic nowe okno z zapraszaniem nowych kierowcow
                                    print('Szukaj nowych Spedytorow');
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            child: Text(
                                              'Szukaj',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              'Nowych',
                                              textAlign: TextAlign.center,
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
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.blue),
                            child: Center(child: Text('Ciezarowki')),
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    print('Podglad Ciezarowek');
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: FittedBox(
                                        child: Text(
                                          'Podglad',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    // Trzeba zrobic nowe okno z zapraszaniem nowych kierowcow
                                    print('Dodaj nowa Ciezarowke');
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            child: Text(
                                              'Dodaj',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              'Nowa',
                                              textAlign: TextAlign.center,
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
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5)),
                                color: Colors.blue),
                            child: Center(child: Text('Kursy')),
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    print('Podglad Kursow');
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: FittedBox(
                                        child: Text(
                                          'Podglad',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: FlatButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    // Trzeba zrobic nowe okno z zapraszaniem nowych kierowcow
                                    print('Dodaj Nowy Kurs');
                                  },
                                  child: Container(
                                    height: 60,
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FittedBox(
                                            child: Text(
                                              'Dodaj',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              'Nowy',
                                              textAlign: TextAlign.center,
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
                        ],
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
