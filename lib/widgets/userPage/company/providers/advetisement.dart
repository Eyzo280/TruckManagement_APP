import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/adventisement.dart';

class CompanyAdvertisements with ChangeNotifier {
  CollectionReference advertisementsCollection =
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
    @required SelectedAdvertisement selectedAdvertisement,
  }) async {
    var advertisements;

    if (selectedAdvertisement == SelectedAdvertisement.Active) {
      if (activeAdvertisement.isEmpty) {
        advertisements = await advertisementsCollection
            .where('uidCompany', isEqualTo: uidCompany)
            .where('status', isEqualTo: true)
            .limit(_perPage)
            .getDocuments();
        _lastDocumentActiveAdver =
            advertisements.documents[advertisements.documents.length - 1];
      } else if (fetch) {
        advertisements = await advertisementsCollection
            .orderBy('endDate')
            .startAfter([_lastDocumentActiveAdver.data['endDate']])
            .where('uidCompany', isEqualTo: uidCompany)
            .where('endDate', isEqualTo: true)
            .limit(_perPage)
            .getDocuments();
        _lastDocumentActiveAdver =
            advertisements.documents[advertisements.documents.length - 1];
      } else {
        return;
      }
    } else {
      if (finishedAdvertisement.isEmpty) {
        advertisements = await advertisementsCollection
            .where('uidCompany', isEqualTo: uidCompany)
            .where('endDate', isEqualTo: '')
            .limit(_perPage)
            .getDocuments();
        _lastDocumentFinishedAdver =
            advertisements.documents[advertisements.documents.length - 1];
      } else if (fetch) {
        advertisements = await advertisementsCollection
            .orderBy('endDate')
            .startAfter([_lastDocumentFinishedAdver.data['endDate']])
            .where('uidCompany', isEqualTo: uidCompany)
            .where('endDate', isEqualTo: false)
            .limit(_perPage)
            .getDocuments();
        _lastDocumentFinishedAdver =
            advertisements.documents[advertisements.documents.length - 1];
      } else {
        return;
      }
    }
    try {
      for (var doc in advertisements.documents) {
        if (selectedAdvertisement == SelectedAdvertisement.Active) {
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
        } else {
          finishedAdvertisement.add(
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
      () => viewCompanyAdvertisement(
        uidCompany: uidCompany,
        selectedAdvertisement: selectedAdvertisement,
      ),
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
