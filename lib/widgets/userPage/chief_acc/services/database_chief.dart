import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/models/chief.dart';

class DataBase_Chief {
  final String uid;

  DataBase_Chief({this.uid});

  Future changeActiveCompany({String chiefUid, bool active}) async {
    final company = FirebaseFirestore.instance
        .collection('Chiefs')
        .doc(chiefUid)
        .collection('Companys');
    return await company.doc(uid).update({
      'active': !active,
    });
  }

  FutureOr<List<BaseCompanyData>> _getdata(QuerySnapshot companysStream) async {
    var companys = List<BaseCompanyData>();

    for (var companyDoc in companysStream.docs) {
      var company;
      if (companyDoc.id != null) {
        var companyName = await FirebaseFirestore.instance
            .collection('Companys')
            .doc(companyDoc.id)
            .get();
        var companyAmountEmployees = await FirebaseFirestore.instance
            .collection('Companys')
            .doc(companyDoc.id)
            .collection('DriverTrucks')
            .get()
            .then((snapshot) {
          return snapshot.docs.length;
        });
        var companyEmployees = await FirebaseFirestore.instance
            .collection('Companys')
            .doc(companyDoc.id)
            .collection('DriverTrucks')
            .orderBy('distanceTraveled', descending: true)
            .limit(1)
            .get();
        var companyTopEmployees;
        for (var companyDoc in companyEmployees.docs) {
          companyTopEmployees = companyDoc.data()['firstName'] +
              ' ' +
              companyDoc.data()['lastName'].toString().substring(0, 1);
        }

        company = BaseCompanyData(
          idCompany: companyName.id,
          nameCompany: companyName.data()['nameCompany'] ?? null,
          status: companyDoc.data()['active'] ?? null,
          employees: companyAmountEmployees ?? null,
          topEmployees: companyTopEmployees ?? null,
        );
      }
      companys.add(company);
    }
    return companys;
  }

  Stream<List<BaseCompanyData>> get getBaseCompanyData {
    return FirebaseFirestore.instance
        .collection('Chiefs')
        .doc(uid)
        .collection('Companys')
        .snapshots()
        .asyncMap((QuerySnapshot companysStream) => _getdata(companysStream));
  }

  // Dodawanie Firmy

  Future addedNewCompany(
      {@required String nameCompany,
      @required String phoneNumber,
      @required bool advertisement,
      @required bool active,
      @required String pakiet,
      @required DateTime yearEstablishmentCompany}) async {
    try {
      final user = FirebaseFirestore.instance.collection('Chiefs');
      final company = FirebaseFirestore.instance.collection('Companys');
      int companyCount = await user
          .doc(uid)
          .collection('Companys')
          .get()
          .then((val) {
        return val.docs.length + 1;
      });
      String companyUid = uid + '_' + companyCount.toString();

      await user
          .doc(uid)
          .collection('Companys')
          .doc(companyUid)
          .set({
        'active': active,
      }).whenComplete(() {
        company.doc(companyUid).set({
          'advertisement': advertisement,
          'pakiet': pakiet,
          'nameCompany': nameCompany,
          'type': 'Company',
          'yearEstablishmentCompany': yearEstablishmentCompany,
          'phoneNumber': phoneNumber,
        });
      });
      return user;
    } catch (err) {
      print(err);
    }
  }
}
