import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';

class Database_Company {
  final String uid;
  final String companyUid;

  // Filtr
  final List searchSettings;

  Database_Company({
    this.uid,
    this.companyUid,
    this.searchSettings,
  });

  final CollectionReference company = Firestore.instance.collection('Companys');

  // Dane ChiefEmployees
  FullTruckDriverData _getFullDataChiefEmoloyees(DocumentSnapshot doc) {
    return FullTruckDriverData(
      firstName: doc.data['firstName'] ?? null,
      lastName: doc.data['lastName'] ?? null,
      salary: doc.data['salary'] ?? null,
      earned: doc.data['earned'] ?? null,
      paid: doc.data['paid'] ?? null,
      distanceTraveled:
          double.parse(doc.data['distanceTraveled'].toString()) ?? null,
      statusDriver: doc.data['statusDriver'] ?? null,
      costDriver: double.parse(doc.data['costDriver'].toString()) ?? null,
      numberPhone: doc.data['numberPhone'] ?? null,
      dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(
          doc.data['dateOfEmplotment'].seconds * 1000),
      payday: DateTime.fromMillisecondsSinceEpoch(
              doc.data['payday'].seconds * 1000) ??
          null,
    );
  }

  Stream<FullTruckDriverData> get getFullDataEmployees {
    return company
        .document(companyUid)
        .collection('DriverTrucks')
        .document(uid)
        .snapshots()
        .map(_getFullDataChiefEmoloyees);
  }

  // Dane ChiefEmployees
  List<BaseTruckDriverData> _getBaseDataCompanyEmoloyees(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return BaseTruckDriverData(
        uidDriver: doc.documentID,
        firstName: doc.data['firstName'] ?? null,
        lastName: doc.data['lastName'] ?? null,
        salary: doc.data['salary'] ?? null,
        earned: doc.data['earned'] ?? null,
        paid: doc.data['paid'] ?? null,
        distanceTraveled:
            double.parse(doc.data['distanceTraveled'].toString()) ?? null,
        statusDriver: doc.data['statusDriver'] ?? null,
      );
    }).toList();
  }

  Stream<List<BaseTruckDriverData>> get getBaseDataEmployees {
    return company
        .document(uid)
        .collection('DriverTrucks')
        .snapshots()
        .map(_getBaseDataCompanyEmoloyees);
  }

  // Pobieranie danych o firmie

  CompanyData _getCompanyData(DocumentSnapshot doc) {
    print(doc.data['status']);
    return CompanyData(
      uid: doc.documentID,
      logoUrl: doc.data['logoUrl'] ?? null,
      forwardersFromCompany: doc.data['forwardersFromCompany'] ?? [],
      truckersFromCompany: doc.data['truckersFromCompany'] ?? [],
      nameCompany: doc.data['nameCompany'] ?? [],
      createDate: doc.data['createDate'] ?? '',
      status: doc.data['status'] ?? false,
    );
  }

  Stream<CompanyData> get getCompanyData {
    return company.document(uid).snapshots().map(_getCompanyData);
  }

  // Podstawowe informacje zaproszen
/*
  List<InvBaseData> _getInvBaseData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return InvBaseData(
        invUid: doc.documentID,
        dateSentInv: DateTime.fromMillisecondsSinceEpoch(
                doc.data['dateSentInv'].seconds * 1000) ??
            null,
        firstName: doc.data['firstName'] ?? null,
        knownLanguages: doc.data['knownLanguages'] ?? null,
        lastName: doc.data['lastName'] ?? null,
        numberPhone: doc.data['numberPhone'] ?? null,
        totalDistanceTraveled: doc.data['totalDistanceTraveled'] ?? null,
      );
    }).toList();
  }

  Stream<List<InvBaseData>> get getInvBaseData {
    return company
        .document(companyUid)
        .collection('Invitations')
        .snapshots()
        .map(_getInvBaseData);
  }
*/
  // Akceptowanie zaproszenia

  Future acceptInv({
    String driverUid,
    String firstName,
    String lastName,
    String numberPhone,
  }) async {
    company
        .document(companyUid)
        .collection('DriverTrucks')
        .document(driverUid)
        .setData({
      'costDriver': 0,
      'dateOfEmplotment': DateTime.now(),
      'distanceTraveled': 0,
      'earned': 0,
      'firstName': firstName,
      'lastName': lastName,
      'numberPhone': numberPhone,
      'paid': 0,
      'payday': DateTime
          .now(), // trzeba dodac ustawienie z tym kiedy prawcownicy dostaja wyplaty
      'salary': 7500, // trzeba dodawc ustawienie wyplaty kierowcow
      'statusDriver': false, // trzeba dodawc ustawienie zmiany statusu kierowcy
    }).whenComplete(() {
      Firestore.instance.collection('Drivers').document(driverUid).updateData({
        'nameCompany':
            companyUid, // trzeba bedzie chyba przerobic zeby byla odzielna kolekcja z firma, a w danych uzytkownika bedzie tylko, ze jest zatrudniony
      });
    }).whenComplete(() {
      company
          .document(companyUid)
          .collection('Invitations')
          .document(driverUid)
          .delete();
    });
  }

  // Funkcja do Wysylania Zaproszenia

  Future sendInvite({
    companyData,
    driverData,
  }) async {
    final CollectionReference driver = Firestore.instance.collection('Drivers');

    driver
        .document(driverData.driverUid)
        .collection('Invitations')
        .document(companyData.uidCompany)
        .setData({
      'nameCompany': companyData.nameCompany,
      'yearEstablishmentCompany': companyData.yearEstablishmentCompany,
      'dateSentInv': DateTime.now(),
    });

    final CollectionReference company =
        Firestore.instance.collection('Companys');

    company
        .document(companyData.uidCompany)
        .collection('SentInvitations')
        .document(driverData.driverUid)
        .setData({
      'firstName': driverData.firstName,
      'lastName': driverData.lastName,
      'drivingLicenseFrom': driverData.drivingLicenseFrom,
      'drivingLicense': driverData.drivingLicense,
      'knownLanguages': driverData.knownLanguages,
      'totalDistanceTraveled': driverData.totalDistanceTraveled,
      'type': driverData.type,
      'dateSentInv': DateTime.now(),
    });
  }

  // Dodawanie nowego kursu

  Future addNewTrack(
      {String dodatkoweInfo,
      int fracht,
      String from,
      DateTime termin,
      String to,
      GeoPoint wspolrzedneDostawy,
      String driver}) async {
    try {
      company.document(companyUid).collection('Tracks').document().setData({
        'DodatkoweInfo': dodatkoweInfo,
        'Fracht': fracht,
        'From': from,
        'Status': true,
        'Termin': termin,
        'To': to,
        'WspolrzedneDostawy': wspolrzedneDostawy,
        'Driver': driver,
      });
    } catch (err) {
      print(err);
    }
  }

  // Pobieranie Akctive Tracks

  List<Track> getActiveTracks(QuerySnapshot snap) {
    try {
      return snap.documents.map((doc) {
        return Track(
          dodatkoweInfo: doc.data['DodatkoweInfo'] ?? null,
          fracht: doc.data['Fracht'] ?? null,
          from: doc.data['From'] ?? null,
          status: doc.data['Status'] ?? null,
          termin: DateTime.fromMillisecondsSinceEpoch(
                  doc.data['Termin'].seconds * 1000) ??
              null,
          to: doc.data['To'] ?? null,
          wspolrzedneDostawy: doc.data['WspolrzedneDostawy'] ?? null,
        );
      }).toList();
    } catch (err) {
      print('Blad w getActiveTracks().');
    }
  }

  Stream<List<Track>> get streamActiveTracks {
    return Firestore.instance
        .collection('Companys')
        .document(companyUid)
        .collection('Tracks')
        .where('Status', isEqualTo: true)
        .snapshots()
        .map(getActiveTracks);
  }

  //                                                                                          SEARCH DRIVER                                                                               //

}
