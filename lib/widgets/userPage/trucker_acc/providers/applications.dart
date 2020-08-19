import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/application.dart';

class Applications with ChangeNotifier {
  CollectionReference _applicationCollection =
      Firestore.instance.collection('Applications');

  Map<String, Application> _applications = {};

  Future<void> sendApplication({
    @required Application application,
    @required Trucker trucker,
  }) async {
    try {
      DocumentReference doc = _applicationCollection.document();
      await doc.setData({
        //'infoCompany': application.companyData,
        'infoAdvertisement': application.infoAdvertisement.toMap(),
        'infoUser': application.userInfo.toMap(),
        'uidAdvertisement': application.uidAdvertisement,
        'uidApplicator': application.uidApplicator,
        'uidCompany': application.uidCompany,
        'additionalInfo': application.additionalInfo,
      }).whenComplete(() {
        _applications.putIfAbsent(
          doc.documentID,
          () => Application(
            //companyData: application.companyData,
            infoAdvertisement: application.infoAdvertisement,
            userInfo: application.userInfo,
            uidAdvertisement: application.uidAdvertisement,
            uidApplicator: application.uidApplicator,
            uidCompany: application.uidCompany,
            additionalInfo: application.additionalInfo,
          ),
        );
        notifyListeners();
      });
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
