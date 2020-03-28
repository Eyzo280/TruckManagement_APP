import 'package:flutter/cupertino.dart';

class User {
  final String uid; // uid od logujacego sie uzytkownika
  final String displayName; // name uzytkownika

  User({this.uid, this.displayName});
}

class UserData {
  final String uid; // identyfikator
  final String firstName; // Imie Uzytkownika
  final String lastName; // Nazwisko Uzytkownika
  final String nameCompany; // NazwaFirmy
  final String typeUser; // Typ konta uzytkownika

  UserData(
      {@required this.uid,
      @required this.firstName,
      @required this.lastName,
      this.nameCompany,
      @required this.typeUser});
}

class ChiefUidCompanys {
  final String uidCompanys; // identyfikatory firm
  final String nameCompany; // nazwa firm
  final bool active; // jezeli true to aktywna

  ChiefUidCompanys({
    @required this.uidCompanys,
    @required this.nameCompany,
    @required this.active,
  });
}
