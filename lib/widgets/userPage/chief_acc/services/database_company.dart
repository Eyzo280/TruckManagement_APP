import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';

class Database_CompanyEmployees {
  final String uid;
  final String companyUid;

  Database_CompanyEmployees({
    this.uid,
    this.companyUid,
  });

  final CollectionReference company = Firestore.instance.collection('Companys');

  // Dane ChiefEmployees
  FullTruckDriverData _getFullDataChiefEmoloyees(DocumentSnapshot doc) {
    return FullTruckDriverData(
      firstNameDriver: doc.data['firstNameDriver'] ?? null,
      lastNameDriver: doc.data['lastNameDriver'] ?? null,
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
        firstNameDriver: doc.data['firstNameDriver'] ?? null,
        lastNameDriver: doc.data['lastNameDriver'] ?? null,
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
    return CompanyData(
      uidCompany: doc.documentID,
      advertisement: doc.data['advertisement'] ?? '',
      nameCompany: doc.data['nameCompany'] ?? '',
      employees: doc.data['employees'] ?? 0,
      yearEstablishmentCompany: DateTime.fromMillisecondsSinceEpoch(
              doc.data['yearEstablishmentCompany'].seconds * 1000) ??
          DateTime.now(),
    );
  }

  Stream<CompanyData> get getCompanyData {
    return company.document(uid).snapshots().map(_getCompanyData);
  }

  // Podstawowe informacje zaproszen

  List<InvBaseData> _getInvBaseData(
      QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return InvBaseData(
        invUid: doc.documentID,
        dateSentInv: DateTime.fromMillisecondsSinceEpoch(
              doc.data['dateSentInv'].seconds * 1000) ?? null,
        firstNameDriver: doc.data['firstNameDriver'] ?? null,
        knownLanguages: doc.data['knownLanguages'] ?? null,
        lastNameDriver: doc.data['lastNameDriver'] ?? null,
        numberPhone: doc.data['numberPhone'] ?? null,
        totalDistanceTraveled: doc.data['totalDistanceTraveled'] ?? null,
      );
    }).toList();
  }

  Stream<List<InvBaseData>> get getInvBaseData {
    return company
        .document('pJxRVVMPOJZobvwa38cJMjTC2y82_1')
        .collection('Invitations')
        .snapshots()
        .map(_getInvBaseData);
  }

  // Akceptowanie zaproszenia

  Future acceptInv({
    String driverUid,
    String firstNameDriver,
    String lastNameDriver,
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
      'firstNameDriver': firstNameDriver,
      'lastNameDriver': lastNameDriver,
      'numberPhone': numberPhone,
      'paid': 0,
      'payday': DateTime.now(), // trzeba dodac ustawienie z tym kiedy prawcownicy dostaja wyplaty
      'salary': 7500, // trzeba dodawc ustawienie wyplaty kierowcow
      'statusDriver': false, // trzeba dodawc ustawienie zmiany statusu kierowcy
    }).whenComplete((){
      company.document(companyUid).collection('Invitations').document(driverUid).delete();
    });
  }
}
