

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief.dart';

class DataBase_Chief {
  final String uid;

  DataBase_Chief({this.uid});

  Future changeActiveCompany({String chiefUid, bool active}) async {
    final company = Firestore.instance.collection('Chiefs').document(chiefUid).collection('Companys');
    return await company.document(uid).updateData({
      'active': !active,
    });
  }

  FutureOr <List<BaseCompanyData>> _getdata(QuerySnapshot companysStream) async {
    var companys = List<BaseCompanyData>();

      for (var companyDoc in companysStream.documents) {
        var company;
        if (companyDoc.documentID != null) {
          var companyName = await Firestore.instance
              .collection('Companys')
              .document(companyDoc.documentID)
              .get();
          var companyAmountEmployees = await Firestore.instance
              .collection('Companys').document(companyDoc.documentID).collection('DriverTrucks').getDocuments().then((snapshot){
                return snapshot.documents.length;
              });
          var companyEmployees = await Firestore.instance
              .collection('Companys').document(companyDoc.documentID).collection('DriverTrucks').orderBy('distanceTraveled', descending: true).limit(1).getDocuments();
          var companyTopEmployees;
            for (var companyDoc in companyEmployees.documents) {
              companyTopEmployees = companyDoc.data['firstNameDriver'] + ' ' + companyDoc.data['lastNameDriver'].toString().substring(0, 1);
            }

          company = BaseCompanyData(
            idCompany: companyName.documentID,
            nameCompany: companyName.data['nameCompany'] ?? null,
            status: companyDoc.data['active'] ?? null,
            employees: companyAmountEmployees ?? null,
            topEmployees: companyTopEmployees ?? null,
          );
        }
        companys.add(company);
      }
      return companys;
    
  }

  Stream<List<BaseCompanyData>> get getBaseCompanyData {
    return Firestore.instance
        .collection('Chiefs')
        .document(uid)
        .collection('Companys')
        .snapshots().asyncMap((QuerySnapshot companysStream) => _getdata(companysStream));
  }

}