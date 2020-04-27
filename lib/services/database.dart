import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckmanagement_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  // final CollectionReference user = Firestore.instance.collection('Users');

  // Tworzenie bazy danych resjestrujacych sie Uzytkownikow
  Future updateUserData(
      {String nameCompany,
      String firstName,
      String lastName,
      String type}) async {
    if (type == 'Chief') {
      final chiefData = Firestore.instance.collection('Chiefs').document(uid);
      final companyData =
          Firestore.instance.collection('Companys').document(uid + '_1');
      //                                                           Chief
      return await chiefData.setData({
        'firstName': firstName, // Imie szefa
        'lastName': lastName, // Nazwisko szefa
        'numberPhone': '2131123213', // numer telefonu szefa
        'type': type, // Typ konta uzytkownika
      }).whenComplete(() {
        chiefData.collection('Companys').document(uid + '_1').setData({
          'active': false, // dzien wyplaty
        });
        companyData.setData({
          'advertisement': false,
          'nameCompany': nameCompany, // NazwaFirmy
          'type': 'Company',
          'yearEstablishmentCompany': DateTime.now(), // rok zalozenia firmy
          'employees': 0,
        }).whenComplete(() {
          ////////////////////////////////////////////////////////////// To pozniej mozna usunac ale teraz zeby miec obraz zostawiam
          companyData
              .collection('DriverTrucks')
              .document('testDriver')
              .setData({
            'firstName': 'TestoweImie', // imie
            'lastName': 'TestoweNazwisko', // nazwisko
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
          companyData
              .collection('Forwarders')
              .document('testForwarder')
              .setData({
            'name': 'TestowaNazwaSpedytora',
          });
        }).whenComplete(() {
          //////////////////////////////////////////////////////////////
          companyData
              .collection('SentInvitations')
              .document('testInvitation')
              .setData({
            'name': 'TestowaNazwaZaproszonegoPracownika',
          });
        }).whenComplete(() {
          companyData
              .collection('Invitations')
              .document('testInvitation')
              .setData({
            'idUserInvitation':
                'TestUserInvitations', // id wysylajacego zaproszenie
            'firstName': 'ImieZapraszajacego', // imie wysylajacego zaproszenie
            'lastName':
                'NazwiskoZapraszajacego', // nazwisko wysylajacego zaproszenie
            'totalDistanceTraveled':
                '', // przejechane km wysylajacego zaproszenie
            'drivingLicense': 'C', // jakie prawo jazdy posiada
            'drivingLicenseFrom':
                DateTime.now(), // od kiedy posiada prawo jazdy
            'knownLanguages': 'English, Polish', // jakie zna jezyki
          });
        });
      });
    } else if (type == 'DriverTruck') {
      final userdata = Firestore.instance.collection('Drivers').document(uid);
      //                                                DriverTruck
      return await userdata.setData({
        'firstName': 'TestoweImie', // imie
        'lastName': 'TestoweNazwisko', // nazwisko
        'type': type, // Typ konta uzytkownika
        'salary': 0, // pensja
        'drivingLicense': 'C', // jakie prawo jazdy posiada
        'drivingLicenseFrom': DateTime.now(), // od kiedy posiada prawo jazdy
        'knownLanguages': 'English, Polish', // jakie zna jezyki
        'nameCompany':
            'TestowaNazwaFirmy', // Nazwa Firmy w ktorej pracuje kierowca
        'earned': 0, // Zarobione pieniadze od dnia zaczecia pracy
        'totalDistanceTraveled': 0, // Calkowita ilosc przejechanych kilometrow
        'numberPhone': '42424242', // numer telefonu
        'dateOfEmplotment': DateTime.now(), // Data zatrudnienia
        'payday': DateTime.now(), // dzien wyplaty
      }).whenComplete(() {
        userdata
            .collection('SentInvitations')
            .document('testInvitation')
            .setData({
          'idSentInvitationToCompany' // id do ktorej wyslano zaproszenie
              'firstName': firstName, // Imie szefa
          'lastName': lastName, // Nazwisko szefa
          'salary': 0, // pensja kierowcy w firmie
          'nameCompany': 'NazwaFirmy', // nazwa firmy
          'amountEmployees': 3, // ilosc pracownikow w firmie
          'numberPhone': '321332131', // numer tel do firmy
          'yearEstablishmentCompany': DateTime.now(), // rok zalozenia firmy
        });
      }).whenComplete(() {
        userdata.collection('Invitations').document('testInvitation').setData({
          'name': 'TestowaNazwaZaproszenia',
        });
      });
    }
  }
  // dane uzytkownika ze snapshot

  UserData _userDataFromsnapshot(DocumentSnapshot snapshot) {
    if (snapshot.data['type'] == 'Chief') {
      return UserData(
        uid: uid,
        firstName: snapshot.data['firstName'],
        lastName: snapshot.data['lastName'],
        type: snapshot.data['type'],
      );
    } else if (snapshot.data['type'] == 'DriverTruck') {
      // Trzeba dodac obiekty reszte uzytkownikow Forwarder i DriverTruck
      return UserData(
        uid: uid,
        firstName: snapshot.data['firstName'],
        lastName: snapshot.data['lastName'],
        nameCompany: snapshot.data['nameCompany'],
        type: snapshot.data['type'],
      );
    } else {
      // Trzeba dodac obiekty reszte uzytkownikow Forwarder i DriverTruck
      return null;
    }
  }

  // pobieranie danych uzytkownika takich jak type
  Stream<UserData> get userData async* {
    List listCollectionsUsers = ['Chiefs', 'Drivers', 'Forwarders'];
    var userType = null;
    var complete = false;

    for (var i in listCollectionsUsers) {
      void wlacz() {
        userType = Firestore.instance
            .collection(i.toString())
            .document(uid)
            .snapshots()
            .map(_userDataFromsnapshot);
      }

      final collection = await Firestore.instance
          .collection(i.toString())
          .document(uid)
          .get()
          .then((val) {
        if (val.exists) {
          wlacz();
        }
      });
    }
    if (userType != null && complete == false) {
      yield* userType;
      complete = true;
    }
  }

  // Pobieranie uid Companys

  Stream<List<ChiefUidCompanys>> get getUidCompanys async* {
    var companysStream = Firestore.instance
        .collection('Chiefs')
        .document(uid)
        .collection('Companys')
        // .where('active', isEqualTo: true)
        .snapshots();
    var companys = List<ChiefUidCompanys>();
    await for (var companysSnapshot in companysStream) {
      for (var companyDoc in companysSnapshot.documents) {
        var company;
        if (companyDoc.documentID != null) {
          var companyName = await Firestore.instance
              .collection('Companys')
              .document(companyDoc.documentID)
              .get();
          company = ChiefUidCompanys(
            uidCompanys: companyDoc.documentID ?? null,
            nameCompany: companyName.data['nameCompany'] ?? null,
            active: companyDoc.data['active'] ?? null,
          );
        }
        companys.add(company);
      }
      yield companys;
    }
  }

  /* Stream<List<ChiefUidCompanys>> get getUidCompanys {
  final CollectionReference user = Firestore.instance.collection('Chiefs');
    return (user.document(uid).collection('Companys').where('active', isEqualTo: true).snapshots().map(_getUidCompanys));
  }
  */

  // Pobieranie Danych DriverTruck

  DriverTruck _getDataDriver(DocumentSnapshot snapshot) {
    return DriverTruck(
      driverUid: snapshot.documentID,
      dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['dateOfEmplotment'].seconds * 1000) ?? null,
      drivingLicense: snapshot.data['drivingLicense'] ?? null,
      drivingLicenseFrom: DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['drivingLicenseFrom'].seconds * 1000) ??
          null,
      firstName: snapshot.data['firstName'] ?? null,
      knownLanguages: snapshot.data['knownLanguages'] ?? null,
      lastName: snapshot.data['lastName'] ?? null,
      numberPhone: snapshot.data['numberPhone'] ?? null,
      totalDistanceTraveled: snapshot.data['totalDistanceTraveled'] ?? null,
      type: snapshot.data['type'] ?? null,
    );
  }

  Stream<DriverTruck> get dataDriver {
    final CollectionReference driver = Firestore.instance.collection('Drivers');

    return driver.document(uid).snapshots().map(_getDataDriver);
  }

  //
}
