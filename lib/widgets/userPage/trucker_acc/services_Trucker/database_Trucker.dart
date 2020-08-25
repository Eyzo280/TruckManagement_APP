import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/trucker.dart';

class DataBase_Trucker {
  final String uid;

  DataBase_Trucker({this.uid});

  List<BaseSearchCompany> _getBaseSearchCompany(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return BaseSearchCompany(
        idCompany: doc.id,
        nameCompany: doc.data()['nameCompany'].toString() ?? 'Brak danych',
        salary: doc.data()['salary'] ?? null,
        kursy: doc.data()['kursy'] ?? 'Brak danych',
      );
    }).toList();
  }

  Stream<List<BaseSearchCompany>> get getBaseSearchCompany {
    final CollectionReference companys =
        FirebaseFirestore.instance.collection('Companys');
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
    String firstName,
    String knownLanguages,
    String lastName,
    String numberPhone,
    int totalDistanceTraveled,
    String type,
  }) async {
    final CollectionReference driver = FirebaseFirestore.instance.collection('Drivers');
    final CollectionReference company =
        FirebaseFirestore.instance.collection('Companys');

    company
        .doc(companyUid)
        .collection('Invitations')
        .doc(uid)
        .set({
      'dateOfEmplotment': dateOfEmplotment,
      'drivingLicense': drivingLicense,
      'drivingLicenseFrom': drivingLicenseFrom,
      'firstName': firstName,
      'knownLanguages': knownLanguages,
      'lastName': lastName,
      'numberPhone': numberPhone,
      'totalDistanceTraveled': totalDistanceTraveled,
      'type': type,
      'dateSentInv': DateTime.now(),
    }).whenComplete((){
      driver.doc(uid).collection('SentInvitations').doc(companyUid).set({
        // Trzeba dodac dane firmy
      });
    });
  }
}
