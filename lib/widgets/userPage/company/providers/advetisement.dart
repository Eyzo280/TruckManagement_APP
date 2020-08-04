import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/adventisement.dart';

class CompanyAdvertisements with ChangeNotifier {
  CollectionReference advertisements =
      Firestore.instance.collection('Advetisement');

  // Advertisement Settings

  int _perPage = 8;

  //

  List<Advertisement> activeAdvertisement = [];
  DocumentSnapshot _lastDocumentActiveAdver;

  List<Advertisement> finishedAdvertisement = [];
  DocumentSnapshot _lastDocumentFinishedAdver;

  Future<void> addNew() async {
    // Dodać funkcje z dodawniem
    try {} catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> viewCompanyAdvertisement({
    @required String uidCompany,
    bool fetch = false,
  }) async {
    var activeAdv;
    if (activeAdvertisement.isEmpty) {
      activeAdv = await advertisements
          .where('uidCompany', isEqualTo: uidCompany)
          .limit(_perPage)
          .getDocuments();
      _lastDocumentActiveAdver =
          activeAdv.documents[activeAdv.documents.length - 1];
    } else if (fetch) {
      activeAdv = await advertisements
          .orderBy('endDate')
          .startAfter([_lastDocumentActiveAdver.data['endDate']])
          .where('uidCompany', isEqualTo: uidCompany)
          .limit(_perPage)
          .getDocuments();
      _lastDocumentActiveAdver =
          activeAdv.documents[activeAdv.documents.length - 1];
    } else {
      return;
    }
    try {
      for (var doc in activeAdv.documents) {
        activeAdvertisement.add(
          Advertisement(
            companyUid: doc.data['companyUid'],
            companyInfo:
                CompanyInfoAdvertisement.fromMap(doc.data['companyData']) ??
                    null,
            title: doc.data['title'] ?? null,
            description: doc.data['description'] ?? null,
            requirements: doc.data['type'] == 'Trucker'
                ? RequirementsAdvertisementTrucker.fromMap(
                    doc.data['requirements'])
                : RequirementsAdvertisementForwarder.fromMap(
                        doc.data['requirements']) ??
                    null,
            endDate: doc.data['endDate'] ?? null,
            type: doc.data['type'] ?? null,
          ),
        );
      }

      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> refreshAdvertisement({
    String uidCompany,
    SelectedAdvertisement selectedAdvertisement,
  }) async {
    clear(selectedAdvertisement).whenComplete(
      () => viewCompanyAdvertisement(uidCompany: uidCompany),
    );
  }

  Future<void> clear(SelectedAdvertisement selectedAdvertisement) async {
    if (selectedAdvertisement == SelectedAdvertisement.Active) {
      activeAdvertisement.clear();
      _lastDocumentActiveAdver = null;
    } else {
      finishedAdvertisement.clear();
      _lastDocumentFinishedAdver = null;
    }
    notifyListeners();
  }
/*
  Future<void> viewTrucker() async {
    var advTruckers =
        await advertisements.where('type', isEqualTo: 'Trucker').getDocuments();
    try {
      for (var doc in advTruckers.documents) {
        truckers.add(
          Advertisement(
            companyUid: doc.data['companyUid'],
            companyInfo:
                CompanyInfoAdvertisement.fromMap(doc.data['companyData']),
            title: doc.data['title'],
            description: doc.data['description'],
            requirements: RequirementsAdvertisementTrucker.fromMap(
                doc.data['requirements']),
            status: doc.data['status'],
            type: doc.data['type'],
          ),
        );
      }

      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }
  */
}
