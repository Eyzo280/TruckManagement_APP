import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckmanagement_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference    Szefa firmy
  final CollectionReference user = Firestore.instance.collection('Users');

  // Tworzenie bazy danych resjestrujacych sie Uzytkownikow
  Future updateUserData(
      {String nameCompany, String firstName, String lastName, String typeUser}) async {
    final userdata = user.document(uid);
    if (typeUser == 'Chief') {
      //                                                           Chief
      return await userdata.setData({
        'firstname': firstName, // Imie szefa
        'lastName': lastName, // Nazwisko szefa
        'nameCompany': nameCompany, // NazwaFirmy
        'typeUser': typeUser, // Typ konta uzytkownika
      }).whenComplete(() {
        userdata.collection('DriverTrucks').document('testDriver').setData({
          'firstNameDriver': 'TestoweImie', // imie
          'lastNameDriver': 'TestoweNazwisko', // nazwisko
          'salary': 0, // pensja
          'earned': 0, // Zarobione pieniadze od dnia zaczecia pracy
          'paid': 0, // Zaplacone pieniadze
          'distanceTraveled': 0, // Przejechane kilometry w firmie
          'statusDriver':
              true, // status okresla czy kierowca jest w trasie czy nie
          'costDriver': 0, // koszty utrzymania kierowcy
          'numberPhone': '42424242', // numer telefonu
          'dateOfEmplotment': DateTime.now(), // Data zatrudnienia
          'payday': DateTime.now(), // dzien wyplaty
        });
      }).whenComplete(() {
        userdata.collection('Forwarders').document('testForwarder').setData({
          'name': 'TestowaNazwaSpedytora',
        });
      }).whenComplete(() {
        userdata
          ..collection('SentInvitations').document('testInvitation').setData({
            'name': 'TestowaNazwaZaproszonegoPracownika',
          });
      });
    } else if (typeUser == 'DriverTruck') {
      //                                                DriverTruck
      return await userdata.setData({
        'firstNameDriver': 'TestoweImie', // imie
        'lastNameDriver': 'TestoweNazwisko', // nazwisko
        'typeUser': typeUser, // Typ konta uzytkownika
        'salary': 0, // pensja
        'nameCompany':
            'TestowaNazwaFirmy', // Nazwa Firmy w ktorej pracuje kierowca
        'earned': 0, // Zarobione pieniadze od dnia zaczecia pracy
        'totalDistanceTraveled': 0, // Calkowita ilosc przejechanych kilometrow
        'numberPhone': '42424242', // numer telefonu
        'dateOfEmplotment': DateTime.now(), // Data zatrudnienia
        'payday': DateTime.now(), // dzien wyplaty
      }).whenComplete(() {
        userdata.collection('Invitations').document('testInvitation').setData({
          'name': 'TestowaNazwaZaproszenia',
        });
      });
    }
  }
  // dane uzytkownika ze snapshot

  UserData _userDataFromsnapshot(DocumentSnapshot snapshot){
    if (snapshot.data['typeUser'] == 'Chief') {
      return UserData(
      uid: uid,
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
      nameCompany: snapshot.data['nameCompany'],
      typeUser: snapshot.data['typeUser'],

    );
    }else { // Trzeba dodac obiekty reszte uzytkownikow Forwarder i DriverTruck
      return null;
    }
    
  }

  // pobieranie danych uzytkownika
  Stream<UserData> get userData {
    return user.document(uid).snapshots().map(_userDataFromsnapshot);
  }

}
