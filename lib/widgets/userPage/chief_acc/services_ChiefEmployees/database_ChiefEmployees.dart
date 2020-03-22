import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief_Employees.dart';

class Database_ChiefEmployees {
  final String uid;

  Database_ChiefEmployees({
    @required this.uid});

  final CollectionReference user = Firestore.instance.collection('Chiefs');

  // Dane ChiefEmployees
  List<FullTruckDriverData> _getFullDataChiefEmoloyees(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      
      return FullTruckDriverData(
        firstNameDriver: doc.data['firstNameDriver'] ?? null,
        lastNameDriver: doc.data['lastNameDriver'] ?? null,
        salary: doc.data['salary'] ?? null,
        earned: doc.data['earned'] ?? null,
        paid: doc.data['paid'] ?? null,
        distanceTraveled: double.parse(doc.data['distanceTraveled'].toString()) ?? null,
        statusDriver: doc.data['statusDriver'] ?? null,
        costDriver: double.parse(doc.data['costDriver'].toString()) ?? null,
        numberPhone: doc.data['numberPhone'] ?? null,
        dateOfEmplotment: DateTime.fromMillisecondsSinceEpoch(doc.data['dateOfEmplotment'].seconds * 1000),
        payday: DateTime.fromMillisecondsSinceEpoch(doc.data['payday'].seconds * 1000) ?? null,

      );
      }).toList();
  }

  Stream<List<FullTruckDriverData>> get getFullDataEmployees {

    return user.document(uid).collection('DriverTrucks').snapshots().map(_getFullDataChiefEmoloyees);
  }

  // Dane ChiefEmployees
  List<BaseTruckDriverData> _getBaseDataChiefEmoloyees(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      
      return BaseTruckDriverData(
        firstNameDriver: doc.data['firstNameDriver'] ?? null,
        lastNameDriver: doc.data['lastNameDriver'] ?? null,
        salary: doc.data['salary'] ?? null,
        earned: doc.data['earned'] ?? null,
        paid: doc.data['paid'] ?? null,
        distanceTraveled: double.parse(doc.data['distanceTraveled'].toString()) ?? null,
        statusDriver: doc.data['statusDriver'] ?? null,

      );
      }).toList();
  }

  Stream<List<BaseTruckDriverData>> get getBaseDataEmployees {

    return user.document(uid).collection('DriverTrucks').snapshots().map(_getBaseDataChiefEmoloyees);
  }
}