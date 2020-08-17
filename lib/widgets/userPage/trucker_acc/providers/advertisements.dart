import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:truckmanagement_app/models/adventisement.dart';

class TruckerAdvertisements with ChangeNotifier {
  CollectionReference _advertisementsCollection =
      Firestore.instance.collection('Advetisement');

  int _perPage = 6; // limit pobieranych jednoczesnie ogloszen

  Map<String, Advertisement> _advertisements = {};
  DocumentSnapshot _lastDocument;

  // pobieranie danych z mapy _advertisements i zwracanie ich w liscie
  List<Advertisement> get fetchAdvertisements {
    List<Advertisement> _listAdvertisements = [];

    _advertisements.forEach((key, value) {
      _listAdvertisements.add(value);
    });

    return _listAdvertisements;
  }

  Future<void> loadAdvertisements({bool fetchNew}) async {
    try {
      // pobiera ogloszenia na kierowce i dodaje do _advetisements
      if (_advertisements.isEmpty) {
        await _advertisementsCollection
            .orderBy('endDate')
            .where('type', isEqualTo: 'Trucker')
            .limit(_perPage)
            .getDocuments()
            .then((value) {
          for (DocumentSnapshot doc in value.documents) {
            _advertisements.putIfAbsent(
              doc.documentID,
              () => Advertisement(
                advertisementUid: doc.documentID,
                companyUid: doc.data['companyUid'],
                companyInfo:
                    CompanyInfoAdvertisement.fromMap(doc.data['companyData']) ??
                        null,
                title: doc.data['title'] ?? null,
                description: doc.data['description'] ?? null,
                requirements: RequirementsAdvertisementTrucker.fromMap(
                    doc.data['requirements']),
                endDate: doc.data['endDate'] ?? null,
                type: doc.data['type'] ?? null,
              ),
            );
          }
          if (value.documents.isNotEmpty) {
            _lastDocument = value.documents[value.documents.length - 1];
          }
        }).whenComplete(
          () => notifyListeners(),
        );
      } else if (_advertisements.isNotEmpty && fetchNew) {
        await _advertisementsCollection
            .orderBy('endDate')
            .startAfter([_lastDocument.data['endDate']])
            .where('type', isEqualTo: 'Trucker')
            .limit(_perPage)
            .getDocuments()
            .then((value) {
              for (DocumentSnapshot doc in value.documents) {
                _advertisements.putIfAbsent(
                  doc.documentID,
                  () => Advertisement(
                    advertisementUid: doc.documentID,
                    companyUid: doc.data['companyUid'],
                    companyInfo: CompanyInfoAdvertisement.fromMap(
                            doc.data['companyData']) ??
                        null,
                    title: doc.data['title'] ?? null,
                    description: doc.data['description'] ?? null,
                    requirements: RequirementsAdvertisementTrucker.fromMap(
                        doc.data['requirements']),
                    endDate: doc.data['endDate'] ?? null,
                    type: doc.data['type'] ?? null,
                  ),
                );
              }
              if (value.documents.isNotEmpty) {
                _lastDocument = value.documents[value.documents.length - 1];
              }
            })
            .whenComplete(
              () => notifyListeners(),
            );
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> refreshAdvertisements() async {
    try {
      clear().whenComplete(() => loadAdvertisements());
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> clear() async {
    try {
      _advertisements.clear();
      _lastDocument = null;
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
