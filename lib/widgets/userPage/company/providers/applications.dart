import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/application.dart';

class Applications with ChangeNotifier {
  CollectionReference _applicationCollection =
      Firestore.instance.collection('Applications');

  int _perPage = 8; // limit pobieranych jednoczesnie aplikacji

  Map<String, Application> _applications = {};
  DocumentSnapshot _lastDocument;

  // pobieranie aplikacji
  List<Application> get fetchApplications {
    List<Application> _listApplications = [];

    _applications.forEach((key, value) {
      _listApplications.add(value);
    });

    return _listApplications;
  }

  Future<void> loadApplications({String uidCompany}) async {
    try {
      // pobiera moje aplikacje na ogloszenia
      if (_applications.isEmpty) {
        await _applicationCollection
            .orderBy('dateSendApplication')
            .where('uidCompany', isEqualTo: uidCompany)
            .limit(_perPage)
            .getDocuments()
            .then((value) {
          for (DocumentSnapshot doc in value.documents) {
            _applications.putIfAbsent(
              doc.documentID,
              () => Application(
                infoAdvertisement:
                    Advertisement.fromMap(doc.data['infoAdvertisement']) ??
                        null,
                userInfo: Trucker.fromMap(doc.data['userInfo']) ?? null,
                uidAdvertisement: doc.data['uidAdvertisement'] ?? null,
                uidApplicator: doc.data['uidApplicator'] ?? null,
                uidCompany: doc.data['uidCompany'] ?? null,
                additionalInfo: doc.data['additionalInfo'] ?? null,
                dateSendApplication: doc.data['dateSendApplication'] ?? null,
                status: doc.data['status'] ?? null,
              ),
            );
          }
          if (value.documents.isNotEmpty) {
            _lastDocument = value.documents[value.documents.length - 1];
          }
        }).whenComplete(
          () => notifyListeners(),
        );
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> refreshApplications({@required String uidCompany}) async {
    try {
      clear().whenComplete(() => loadApplications(uidCompany: uidCompany));
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> clear() async {
    try {
      _applications.clear();
      _lastDocument = null;
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
