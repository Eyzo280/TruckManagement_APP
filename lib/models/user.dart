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

class DriverTruck {
  final String driverUid; // Uid
  final DateTime dateOfEmplotment; // Data utworzenia konta
  final String drivingLicense; // Prawo jazdy
  final DateTime drivingLicenseFrom; // od kiedy prawojazdy
  final String firstNameDriver; // Imie
  final String knownLanguages; // Jakie zna jezyki
  final String lastNameDriver; // Nazwisko
  final String numberPhone; // Nr tel
  final int totalDistanceTraveled; // Calkowita ilosc przejechanych km
  final String typeUser;

  DriverTruck({
    @required this.driverUid,
    @required this.dateOfEmplotment,
    @required this.firstNameDriver,
    @required this.lastNameDriver,
    @required this.numberPhone,
    @required this.drivingLicense,
    @required this.drivingLicenseFrom,
    @required this.knownLanguages,
    @required this.totalDistanceTraveled,
    @required this.typeUser,
  });
}
