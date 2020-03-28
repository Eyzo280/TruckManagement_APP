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
      String typeUser}) async {
    if (typeUser == 'Chief') {
      final chiefData = Firestore.instance.collection('Chiefs').document(uid);
      final companyData =
          Firestore.instance.collection('Companys').document(uid + '_1');
      //                                                           Chief
      return await chiefData.setData({
        'firstname': firstName, // Imie szefa
        'lastName': lastName, // Nazwisko szefa
        'numberPhone': '2131123213', // numer telefonu szefa
        'typeUser': typeUser, // Typ konta uzytkownika
        'employees': 1,
        'maxEmployees': 10,
      }).whenComplete(() {
        chiefData.collection('Companys').document(uid + '_1').setData({
          'active': false, // dzien wyplaty
        });
        companyData.setData({
          'advertisement': false,
          'nameCompany': nameCompany, // NazwaFirmy
          'yearEstablishmentCompany': DateTime.now(), // rok zalozenia firmy
          'employees': 0,
        }).whenComplete(() {
          ////////////////////////////////////////////////////////////// To pozniej mozna usunac ale teraz zeby miec obraz zostawiam
          companyData
              .collection('DriverTrucks')
              .document('testDriver')
              .setData({
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
    } else if (typeUser == 'DriverTruck') {
      final userdata = Firestore.instance.collection('Drivers').document(uid);
      //                                                DriverTruck
      return await userdata.setData({
        'firstNameDriver': 'TestoweImie', // imie
        'lastNameDriver': 'TestoweNazwisko', // nazwisko
        'typeUser': typeUser, // Typ konta uzytkownika
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
              'firstname': firstName, // Imie szefa
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
    if (snapshot.data['typeUser'] == 'Chief') {
      return UserData(
        uid: uid,
        firstName: snapshot.data['firstName'],
        lastName: snapshot.data['lastName'],
        typeUser: snapshot.data['typeUser'],
      );
    } else if (snapshot.data['typeUser'] == 'DriverTruck') {
      // Trzeba dodac obiekty reszte uzytkownikow Forwarder i DriverTruck
      return UserData(
        uid: uid,
        firstName: snapshot.data['firstNameDriver'],
        lastName: snapshot.data['lastNameDriver'],
        nameCompany: snapshot.data['nameCompany'],
        typeUser: snapshot.data['typeUser'],
      );
    } else {
      // Trzeba dodac obiekty reszte uzytkownikow Forwarder i DriverTruck
      return null;
    }
  }

  // pobieranie danych uzytkownika
  Stream<UserData> get userData {
    final CollectionReference user = Firestore.instance.collection(
        'Chiefs'); // Trzeba zrobic zeby przy logowaniu dalo sie wybierac czy chcemy zalogowac sie na szefa, spedtyora czy kierowce
    return user.document(uid).snapshots().map(_userDataFromsnapshot);
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
            uidCompanys: companyDoc.documentID,
            nameCompany: companyName.data['nameCompany'],
            active: companyDoc.data['active'],
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
}
