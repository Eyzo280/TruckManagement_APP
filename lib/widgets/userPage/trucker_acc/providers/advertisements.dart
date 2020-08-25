import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:truckmanagement_app/models/adventisement.dart';

class TruckerAdvertisements with ChangeNotifier {
  CollectionReference _advertisementsCollection =
      FirebaseFirestore.instance.collection('Advetisement');

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
            .where('endDate', isGreaterThan: '')
            .where('type', isEqualTo: 'Trucker')
            .limit(_perPage)
            .get()
            .then((value) {
          for (DocumentSnapshot doc in value.docs) {
            _advertisements.putIfAbsent(
              doc.id,
              () => Advertisement(
                advertisementUid: doc.id,
                companyUid: doc.data()['uidCompany'],
                companyInfo:
                    CompanyInfoAdvertisement.fromMap(doc.data()['companydata()']) ??
                        null,
                title: doc.data()['title'] ?? null,
                description: doc.data()['description'] ?? null,
                requirements: RequirementsAdvertisementTrucker.fromMap(
                    doc.data()['requirements']),
                endDate: doc.data()['endDate'] ?? null,
                type: doc.data()['type'] ?? null,
              ),
            );
          }
          if (value.docs.isNotEmpty) {
            _lastDocument = value.docs[value.docs.length - 1];
          }
        }).whenComplete(
          () => notifyListeners(),
        );
      } else if (_advertisements.isNotEmpty && fetchNew) {
        await _advertisementsCollection
            .orderBy('endDate')
            .where('endDate', isGreaterThan: '')
            .startAfter([_lastDocument.data()['endDate']])
            .where('type', isEqualTo: 'Trucker')
            .limit(_perPage)
            .get()
            .then((value) {
              for (DocumentSnapshot doc in value.docs) {
                _advertisements.putIfAbsent(
                  doc.id,
                  () => Advertisement(
                    advertisementUid: doc.id,
                    companyUid: doc.data()['companyUid'],
                    companyInfo: CompanyInfoAdvertisement.fromMap(
                            doc.data()['companyData']) ??
                        null,
                    title: doc.data()['title'] ?? null,
                    description: doc.data()['description'] ?? null,
                    requirements: RequirementsAdvertisementTrucker.fromMap(
                        doc.data()['requirements']),
                    endDate: doc.data()['endDate'] ?? null,
                    type: doc.data()['type'] ?? null,
                  ),
                );
              }
              if (value.docs.isNotEmpty) {
                _lastDocument = value.docs[value.docs.length - 1];
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
