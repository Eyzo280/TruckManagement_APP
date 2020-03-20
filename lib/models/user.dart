class User {

  final String uid; // uid od logujacego sie uzytkownika
  final String displayName; // name uzytkownika

  User({this.uid, this.displayName});

}

class UserData {
  final String uid; // identyfikator
  final String firstName; // Imie szefa
  final String lastName; // Nazwisko szefa
  final String nameCompany; // NazwaFirmy
  final String typeUser; // Typ konta uzytkownika

  UserData({this.uid, this.firstName, this.lastName, this.nameCompany, this.typeUser});

}