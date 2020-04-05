import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/trucker.dart';

class DataBase_Trucker {
  final String uid;

  DataBase_Trucker({this.uid});

  List<BaseSearchCompany> _getBaseSearchCompany(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return BaseSearchCompany(
        idCompany: doc.documentID,
        nameCompany: doc.data['nameCompany'].toString() ?? 'Brak danych',
        salary: doc.data['salary'] ?? null,
        kursy: doc.data['kursy'] ?? 'Brak danych',
      );
    }).toList();
  }

  Stream<List<BaseSearchCompany>> get getBaseSearchCompany {
    final CollectionReference companys =
        Firestore.instance.collection('Companys');
    return companys
        .where("advertisement", isEqualTo: true)
        .snapshots()
        .map(_getBaseSearchCompany);
  }

  // Send Invite

  Future sendInvite({
    String companyUid,
    String firstNameDriver,
    String lastNameDriver,
    String numberPhone,
    String knownLanguages,
    int totalDistanceTraveled,
  }) async {
    final CollectionReference company =
        Firestore.instance.collection('Companys');

    company
        .document(companyUid)
        .collection('Invitations')
        .document(uid)
        .setData({
      'firstNameDriver': firstNameDriver,
      'lastNameDriver': lastNameDriver,
      'numberPhone': numberPhone,
      'knownLanguages': knownLanguages,
      'totalDistanceTraveled': totalDistanceTraveled,
      'dateSentInv': DateTime.now(),
    });
  }
}
