import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckmanagement_app/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  // final CollectionReference user = Firestore.instance.collection('Users');

  // Tworzenie bazy danych resjestrujacych sie Uzytkownikow

  Future registerChiefDatabase({
    String nameCompany,
    String nickName,
    String createdDate,
  }) async {
    try {
      final companyUid =
          Firestore.instance.collection('Companys').document().documentID;
      await Firestore.instance
          .collection('Users')
          .document(uid)
          .setData(
            {
              'nickName': nickName,
              'createDate': createdDate,
              'type': 'Chief',
            },
          )
          .whenComplete(
            () => Firestore.instance
                .collection('Users')
                .document(uid)
                .collection('Companys')
                .document(companyUid)
                .setData(
              {
                'nameCompany': nameCompany,
              },
            ),
          )
          .whenComplete(
            () => Firestore.instance
                .collection('Companys')
                .document(companyUid)
                .setData(
              {
                'chief': uid,
                'nameCompany': nameCompany,
                'createDate': createdDate,
                'status': false, // Nieaktywna
              },
            ),
          );
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future registerForwarderDatabase({
    String nickName,
    String createdDate,
  }) async {
    try {
      await Firestore.instance.collection('Users').document(uid).setData(
        {
          'nickName': nickName,
          'createDate': createdDate,
          'type': 'Forwarder',
        },
      );
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future registerTruckerDatabase({
    String nickName,
    String createdDate,
  }) async {
    try {
      await Firestore.instance.collection('Users').document(uid).setData(
        {
          'nickName': nickName,
          'createDate': createdDate,
          'type': 'Trucker',
        },
      );
    } catch (err) {
      print(err);
      throw err;
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
              snapshot.data['dateOfEmplotment'].seconds * 1000) ??
          null,
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
