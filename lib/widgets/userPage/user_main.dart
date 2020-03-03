import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/truckDriver.dart';

class UserMain extends StatefulWidget {
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
      nameDriver: 'Stasiek',
      salary: 5000.00,
      costDriver: 1500.00,
      numberPhone: '52341413',
      dateOfEmplotment: DateTime.now(),
      payday: DateTime.now(),
    ),
    TruckDriver(
      id: '2',
      nameDriver: 'Waldek',
      salary: 5000.00,
      costDriver: 1500.00,
      numberPhone: '52341413',
      dateOfEmplotment: DateTime.now(),
      payday: DateTime.now(),
    ),
  ];

  UserMain({this.userLogout, this.userLogin, this.userPassword});

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glowny Panel ${widget.nameThief}'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.lock_outline),
            onPressed: () {
              userLogoutAndClear();
            },
          ),
        ],
      ),
      body: Container(
        child: Text('data'),
      ),
    );
  }
}
