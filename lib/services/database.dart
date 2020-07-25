import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckmanagement_app/models/chief.dart';
import 'package:truckmanagement_app/models/forwarder.dart';
import 'package:truckmanagement_app/models/trucker.dart';
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
      final List<Map<String, Object>> companyMap = [
        {companyUid: nameCompany}
      ];
      await Firestore.instance.collection('Users').document(uid).setData(
        {
          'nickName': nickName,
          'createDate': createdDate,
          'type': 'Chief',
          'companys': companyMap,
        },
      ).whenComplete(
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

  // Pobieranie danych uzytkownika

  Chief _chiefDataFromsnapshot(DocumentSnapshot snapshot) {
    List<Map<String, Object>> companys = [];

    for (var data in snapshot.data['companys']) {
      companys.add(data);
    }

    return Chief(
      uid: uid,
      nickName: snapshot.data['nickName'] ?? null,
      createDate: snapshot.data['createDate'] ?? null,
      companys: companys ?? null,
      type: snapshot.data['type'] ?? null,
    );
  }

  Forwarder _forwarderDataFromsnapshot(DocumentSnapshot snapshot) {
    // pobieranie firm trzeba dodac
    return Forwarder(
      uid: uid,
      nickName: snapshot.data['nickName'] ?? null,
      createDate: snapshot.data['createDate'] ?? null,
      type: snapshot.data['type'] ?? null,
    );
  }

  Trucker _truckerDataFromsnapshot(DocumentSnapshot snapshot) {
    return Trucker(
      uid: uid,
      nickName: snapshot.data['nickName'] ?? null,
      createDate: snapshot.data['createDate'] ?? null,
      type: snapshot.data['type'] ?? null,
    );
  }

  Stream<UserData> get userData {
    return Firestore.instance.collection('Users').document(uid).snapshots().map(
      (snap) {
        if (snap.data['type'] == 'Chief') {
          return UserData(
            // Potrzebne bylo poniewaz nie moglem uzyc StreamProvider<dynamic>
            data: _chiefDataFromsnapshot(snap),
          );
        } else if (snap.data['type'] == 'Forwarder') {
          return UserData(
            data: _forwarderDataFromsnapshot(snap),
          );
        } else if (snap.data['type'] == 'Trucker') {
          return UserData(
            data: _truckerDataFromsnapshot(snap),
          );
        } else
          return UserData(
            data: null,
          );
      },
    );
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
  /*
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
  */
  //
}
