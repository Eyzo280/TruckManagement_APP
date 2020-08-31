import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/application.dart';

class Applications with ChangeNotifier {
  CollectionReference _applicationCollection =
      FirebaseFirestore.instance.collection('Applications');

  int _perPage = 8; // limit pobieranych jednoczesnie aplikacji

  Map<String, Application> _applications = {};
  DocumentSnapshot _lastDocument;

  // pobieranie danych moich aplikacji na ogloszenia
  List<Application> get fetchApplications {
    List<Application> _listApplications = [];

    _applications.forEach((key, value) {
      _listApplications.add(value);
    });

    return _listApplications;
  }

  Future<void> loadApplications({String userUid}) async {
    try {
      // pobiera moje aplikacje na ogloszenia
      if (_applications.isEmpty) {
        await _applicationCollection
            .orderBy('dateSendApplication', descending: true)
            .where('uidApplicator', isEqualTo: userUid)
            .limit(_perPage)
            .get()
            .then((value) {
          for (DocumentSnapshot doc in value.docs) {
            _applications.putIfAbsent(
              doc.id,
              () => Application(
                applicationID: doc.id,
                infoAdvertisement:
                    Advertisement.fromMap(doc.data()['infoAdvertisement']) ??
                        null,
                userInfo: Trucker.fromMap(doc.data()['userInfo']) ?? null,
                uidAdvertisement: doc.data()['uidAdvertisement'] ?? null,
                uidApplicator: doc.data()['uidApplicator'] ?? null,
                uidCompany: doc.data()['uidCompany'] ?? null,
                additionalInfo: doc.data()['additionalInfo'] ?? null,
                dateSendApplication: doc.data()['dateSendApplication'] ?? null,
                status: doc.data()['status'] ?? null,
              ),
            );
          }
          if (value.docs.isNotEmpty) {
            _lastDocument = value.docs[value.docs.length - 1];
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

  Future<void> sendApplication({
    @required Application application,
    @required Trucker trucker,
  }) async {
    try {
      DocumentReference doc = _applicationCollection.doc();
      await doc.set({
        //'infoCompany': application.companyData,
        'infoAdvertisement': application.infoAdvertisement.toMap(),
        'userInfo': application.userInfo.toMap(),
        'uidAdvertisement': application.uidAdvertisement,
        'uidApplicator': application.uidApplicator,
        'uidCompany': application.uidCompany,
        'additionalInfo': application.additionalInfo,
        'dateSendApplication': application.dateSendApplication,
        'status': application.status,
      }).whenComplete(() {
        _applications.putIfAbsent(
          doc.id,
          () => Application(
            //companyData: application.companyData,
            infoAdvertisement: application.infoAdvertisement,
            userInfo: application.userInfo,
            uidAdvertisement: application.uidAdvertisement,
            uidApplicator: application.uidApplicator,
            uidCompany: application.uidCompany,
            additionalInfo: application.additionalInfo,
            dateSendApplication: application.dateSendApplication,
            status: application.status,
          ),
        );
        notifyListeners();
      });
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> acceptInvite({
    @required String userUid,
    @required String applicationId,
    @required String uidCompany,
  }) async {
    // Najpierw dodaje uidCompany do Danych uzytkownika a pozniej ustawia aplikacje na zakonczona.
    await FirebaseFirestore.instance.collection('Users').doc(userUid).update(
      {
        'uidCompany': uidCompany,
        'applicationId': applicationId,
      },
    );
    try {
      await _applicationCollection.doc(applicationId).update(
        {
          'status': 'Zakonczona',
        },
      );
      _applications[applicationId].status = 'Zakonczona';
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> cancelInvite({@required String applicationId}) async {
    await _applicationCollection.doc(applicationId).update(
      {
        'cancelApplication': false,
        'status': 'Zakonczona',
      },
    );
    try {
      _applications[applicationId].status = 'Zakonczona';
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> refreshApplications({@required String userUid}) async {
    try {
      clear().whenComplete(() => loadApplications(userUid: userUid));
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
