import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/company_Employees.dart';

class Database_CompanyEmployees {
  final String uid;
  final String uidCompany;

  Database_CompanyEmployees({
    @required this.uid,
    this.uidCompany,
  });

  final CollectionReference user = Firestore.instance.collection('Companys');

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
    return user
        .document(uidCompany)
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
    return user
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
    return user.document(uid).snapshots().map(_getCompanyData);
  }
}