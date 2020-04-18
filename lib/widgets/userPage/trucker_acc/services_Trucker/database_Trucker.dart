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
    DateTime dateOfEmplotment,
    String drivingLicense,
    DateTime drivingLicenseFrom,
    String firstNameDriver,
    String knownLanguages,
    String lastNameDriver,
    String numberPhone,
    int totalDistanceTraveled,
    String typeUser,
  }) async {
    final CollectionReference driver = Firestore.instance.collection('Drivers');
    final CollectionReference company =
        Firestore.instance.collection('Companys');

    company
        .document(companyUid)
        .collection('Invitations')
        .document(uid)
        .setData({
      'dateOfEmplotment': dateOfEmplotment,
      'drivingLicense': drivingLicense,
      'drivingLicenseFrom': drivingLicenseFrom,
      'firstNameDriver': firstNameDriver,
      'knownLanguages': knownLanguages,
      'lastNameDriver': lastNameDriver,
      'numberPhone': numberPhone,
      'totalDistanceTraveled': totalDistanceTraveled,
      'typeUser': typeUser,
      'dateSentInv': DateTime.now(),
    }).whenComplete((){
      driver.document(uid).collection('SentInvitations').document(companyUid).setData({
        // Trzeba dodac dane firmy
      });
    });
  }
}
