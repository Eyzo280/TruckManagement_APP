import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/adventisement.dart';

class CompanyAdvertisements with ChangeNotifier {
  CollectionReference _advertisementsCollection =
      Firestore.instance.collection('Advetisement');

  // Advertisement Settings

  int _perPage = 5;

  //

  Map<String, Advertisement> _activeAdvertisement = {};
  DocumentSnapshot _lastDocumentActiveAdver;

  Map<String, Advertisement> _finishedAdvertisement = {};
  DocumentSnapshot _lastDocumentFinishedAdver;

  Future<void> addNew() async {
    // Dodać funkcje z dodawniem
    try {} catch (err) {
      print(err);
      throw err;
    }
  }

  List<Advertisement> get fetchActiveAdvertisement {
    List<Advertisement> _listAdvertisements = [];

    _activeAdvertisement.forEach((key, value) {
      _listAdvertisements.add(value);
    });

    return _listAdvertisements;
  }

  List<Advertisement> get fetchFinishedAdvertisement {
    List<Advertisement> _listAdvertisements = [];

    _finishedAdvertisement.forEach((key, value) {
      _listAdvertisements.add(value);
    });

    return _listAdvertisements;
  }

  Future<void> viewCompanyAdvertisement({
    @required String uidCompany,
    bool fetch = false,
    @required SelectedAdvertisement selectedAdvertisement,
  }) async {
    var advertisements;

    // Sprawdzenie wybranego okna na stronie
    if (selectedAdvertisement == SelectedAdvertisement.Active) {
      if (_activeAdvertisement.isEmpty) {
        // Pobiera dokumenty z bazy danych
        advertisements = await _advertisementsCollection
            .orderBy('endDate')
            .where('uidCompany', isEqualTo: uidCompany)
            .limit(_perPage)
            .getDocuments();
        if (advertisements.documents.isNotEmpty) {
          _lastDocumentActiveAdver =
              advertisements.documents[advertisements.documents.length - 1];
        }
      } else if (fetch) {
        advertisements = await _advertisementsCollection
            .orderBy('endDate')
            .startAfter([_lastDocumentActiveAdver.data['endDate']])
            .where('uidCompany', isEqualTo: uidCompany)
            .limit(_perPage)
            .getDocuments();
        if (advertisements.documents.isNotEmpty) {
          _lastDocumentActiveAdver =
              advertisements.documents[advertisements.documents.length - 1];
        }
      } else {
        return;
      }
    } else {
      if (_finishedAdvertisement.isEmpty) {
        advertisements = await _advertisementsCollection
            .where('uidCompany', isEqualTo: uidCompany)
            .where('endDate', isEqualTo: '')
            .limit(_perPage)
            .getDocuments();
        if (advertisements.documents.isNotEmpty) {
          _lastDocumentActiveAdver =
              advertisements.documents[advertisements.documents.length - 1];
        }
      } else if (fetch) {
        advertisements = await _advertisementsCollection
            .orderBy('endDate')
            .startAfter([_lastDocumentFinishedAdver.data['endDate']])
            .where('uidCompany', isEqualTo: uidCompany)
            .limit(_perPage)
            .getDocuments();
        if (advertisements.documents.isNotEmpty) {
          _lastDocumentActiveAdver =
              advertisements.documents[advertisements.documents.length - 1];
        }
      } else {
        return;
      }
    }
    try {
      // Pobrane wczesniej dokumenty do advertisements sa dodawane do providera zaleznie od tego jakie wybrane jest okno 'SelectedAdvertisement.Active/Finished'
      for (DocumentSnapshot doc in advertisements.documents) {
        if (selectedAdvertisement == SelectedAdvertisement.Active) {
          _activeAdvertisement.putIfAbsent(
            doc.documentID,
            () => Advertisement(
              advertisementUid: doc.documentID,
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
          _finishedAdvertisement.putIfAbsent(
            doc.documentID,
            () => Advertisement(
              advertisementUid: doc.documentID,
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

  Future<void> addAdvertisement({
    @required String companyUid,
    @required CompanyInfoAdvertisement companyInfo,
    @required String description,
    // endDate -- Obecnie bedzie ustawiony na stale, ze przy dodawaniu jest aktywne przez nastepnych 7 dni
    @required requirements,
    @required String title,
    @required String type,
  }) async {
    try {
      DocumentReference doc = _advertisementsCollection.document();
      String endDate = DateTime.now().add(Duration(days: 7)).toIso8601String();
      // Sprawdza typ nowego ogloszenia i dodaje jego dane do bazy danych oraz do providera.
      if (type == 'Trucker') {
        await doc.setData({
          'uidCompany': companyUid,
          'companyData': {
            'logoUrl': companyInfo.logoUrl,
            'name': companyInfo.name,
            'phone': companyInfo.phone,
          },
          'description': description,
          'endDate': endDate,
          'requirements': {
            'kartakierowcy': requirements.kartaKierowcy,
            'zaswiadczenieoniekaralnosci':
                requirements.zaswiadczenieoniekaralnosci,
          },
          'status': true,
          'title': title,
          'type': type,
        });
        _activeAdvertisement.putIfAbsent(
            doc.documentID,
            () => Advertisement(
                  advertisementUid: doc.documentID,
                  companyUid: companyUid,
                  companyInfo: companyInfo,
                  title: title,
                  requirements: requirements,
                  description: description,
                  type: type,
                  endDate: endDate,
                ));
        notifyListeners();
      } else if (type == 'Forwarder') {
        await doc.setData({
          'uidCompany': companyUid,
          'companyData': {
            'logoUrl': companyInfo.logoUrl,
            'name': companyInfo.name,
            'phone': companyInfo.phone,
          },
          'description': description,
          'endDate': endDate,
          'requirements': {
            'doswiadczenie': requirements.doswiadczenie,
            'zaswiadczenieoniekaralnosci':
                requirements.zaswiadczenieoniekaralnosci,
            'umiejetnoscianalityczne': requirements.umiejetnoscianalityczne,
          },
          'status': true,
          'title': title,
          'type': type,
        });
        _activeAdvertisement.putIfAbsent(
            doc.documentID,
            () => Advertisement(
                  advertisementUid: doc.documentID,
                  companyUid: companyUid,
                  companyInfo: companyInfo,
                  title: title,
                  requirements: requirements,
                  description: description,
                  type: type,
                  endDate: endDate,
                ));
        notifyListeners();
      } else {
        print(
            'Problem from adding new Advertisement.  -- company/providers/adverisement.dart');
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  // Odswiezenie ogloszen.
  Future<void> refreshAdvertisement({
    String uidCompany,
    SelectedAdvertisement selectedAdvertisement,
  }) async {
    // Czysci ogloszenia i pobiera na nowo z bazy danych.

    clear(selectedAdvertisement).whenComplete(
      () => viewCompanyAdvertisement(
        uidCompany: uidCompany,
        selectedAdvertisement: selectedAdvertisement,
      ),
    );
  }

  // Odnowienie ogloszenia
  Future reconditioningAdvertisement({
    String advUid,
    String type,
    SelectedAdvertisement selectedAdvertisement,
  }) async {
    try {
      String time = DateTime.now().add(Duration(days: 7)).toIso8601String();

      if (selectedAdvertisement == SelectedAdvertisement.Active) {
        _advertisementsCollection.document(advUid).updateData({
          'endDate': time,
        });
        _activeAdvertisement.update(advUid, (value) {
          value.endDate = time;
          return value;
        });

        //selectedAdv.endDate = time;
      } else {
        _advertisementsCollection.document(advUid).updateData({
          'endDate': time,
        });
        _finishedAdvertisement[advUid].endDate = time;
        // Usuwanie z listy zakonczonych ogloszen do aktywnych

        _activeAdvertisement.putIfAbsent(
            advUid, () => _finishedAdvertisement[advUid]);
        _finishedAdvertisement.removeWhere((key, value) => key == advUid);
      }
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> editAdversitsement({
    SelectedAdvertisement selectedAdvertisement,
    @required String advUid,
    @required CompanyInfoAdvertisement companyInfo,
    @required String description,
    // endDate -- Obecnie bedzie ustawiony na stale, ze przy dodawaniu jest aktywne przez nastepnych 7 dni
    @required requirements,
    @required String title,
    @required String type,
  }) async {
    String endDate = DateTime.now().add(Duration(days: 7)).toIso8601String();
    try {
      _advertisementsCollection.document(advUid).updateData({
        'companyData': {
          'logoUrl': companyInfo.logoUrl,
          'name': companyInfo.name,
          'phone': companyInfo.phone,
        },
        'description': description,
        'endDate': endDate,
        'requirements': type == 'Trucker'
            ? {
                'kartakierowcy': requirements.kartaKierowcy,
                'zaswiadczenieoniekaralnosci':
                    requirements.zaswiadczenieoniekaralnosci,
              }
            : {
                'doswiadczenie': requirements.doswiadczenie,
                'zaswiadczenieoniekaralnosci':
                    requirements.zaswiadczenieoniekaralnosci,
                'umiejetnoscianalityczne': requirements.umiejetnoscianalityczne,
              },
        'status': true,
        'title': title,
        'type': type,
      });
      _activeAdvertisement.update(
        advUid,
        (value) => Advertisement(
          advertisementUid: value.advertisementUid,
          companyUid: value.companyUid,
          companyInfo: companyInfo,
          title: title,
          requirements: requirements,
          description: description,
          type: type,
          endDate: endDate,
        ),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> deleteAdversitsement({
    SelectedAdvertisement selectedAdvertisement,
    String uidAdvertisement,
  }) async {
    try {
      if (selectedAdvertisement == SelectedAdvertisement.Active) {
        _advertisementsCollection
            .document(uidAdvertisement)
            .delete()
            .whenComplete(() {
          _activeAdvertisement
              .removeWhere((key, value) => key == uidAdvertisement);
          notifyListeners();
        });
      } else {
        _advertisementsCollection
            .document(uidAdvertisement)
            .delete()
            .whenComplete(() {
          _finishedAdvertisement
              .removeWhere((key, value) => key == uidAdvertisement);
          notifyListeners();
        });
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  // Czysci ogloszenia zalezne od selectedAdvertisement
  Future<void> clear(SelectedAdvertisement selectedAdvertisement) async {
    if (selectedAdvertisement == SelectedAdvertisement.Active) {
      _activeAdvertisement.clear();
      _lastDocumentActiveAdver = null;
    } else {
      _finishedAdvertisement.clear();
      _lastDocumentFinishedAdver = null;
    }
    notifyListeners();
  }
}
