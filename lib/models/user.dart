import 'package:flutter/cupertino.dart';

class LoginUser {
  final String uid; // uid od logujacego sie uzytkownika

  LoginUser({this.uid});
}

class UserData {
  final data;

  UserData({
    @required this.data,
  });
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
  final String firstName; // Imie
  final String knownLanguages; // Jakie zna jezyki
  final String lastName; // Nazwisko
  final String numberPhone; // Nr tel
  final int totalDistanceTraveled; // Calkowita ilosc przejechanych km
  final String type;

  DriverTruck({
    @required this.driverUid,
    @required this.dateOfEmplotment,
    @required this.firstName,
    @required this.lastName,
    @required this.numberPhone,
    @required this.drivingLicense,
    @required this.drivingLicenseFrom,
    @required this.knownLanguages,
    @required this.totalDistanceTraveled,
    @required this.type,
  });
}

class PeerChat {
  final String uid;
  final bool conversation;
  final String firstName;
  final String lastName;
  final String type;

  PeerChat(
      {this.uid, this.conversation, this.firstName, this.lastName, this.type});
}
