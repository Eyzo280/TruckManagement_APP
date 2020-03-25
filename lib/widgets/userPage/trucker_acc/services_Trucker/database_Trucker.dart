import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/trucker.dart';

class DataBase_Trucker {
  final String uid;

  DataBase_Trucker({@required this.uid});

  List<BaseSearchCompany> _getBaseSearchCompany(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {

        return BaseSearchCompany(
          idCompany: doc.documentID,
          nameCompany: doc.data['employees'].toString() ?? 'Brak danych',
          salary: doc.data['salary'] ?? null,
          kursy: doc.data['kursy'] ?? 'Brak danych',);

    }).toList();
  }

  Stream<List<BaseSearchCompany>> get getBaseSearchCompany {
    final CollectionReference companys =
        Firestore.instance.collection('Chiefs');
    return companys.where("employees", isLessThanOrEqualTo: 5).snapshots().map(_getBaseSearchCompany);
  }
}
