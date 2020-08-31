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
    QuerySnapshot advertisements;

    // pobiera ogloszenia na kierowce i dodaje do _advetisements
    if (_advertisements.isEmpty) {
      advertisements = await _advertisementsCollection
          .orderBy('endDate', descending: true)
          .where('endDate', isGreaterThan: '')
          .where('type', isEqualTo: 'Trucker')
          .limit(_perPage)
          .get();
    } else if (_advertisements.isNotEmpty && fetchNew) {
      advertisements = await _advertisementsCollection
          .orderBy('endDate', descending: true)
          .where('endDate', isGreaterThan: '')
          .startAfter([_lastDocument.data()['endDate']])
          .where('type', isEqualTo: 'Trucker')
          .limit(_perPage)
          .get();
    }
    try {
      for (DocumentSnapshot doc in advertisements.docs) {
        _advertisements.putIfAbsent(
          doc.id,
          () => Advertisement(
            advertisementUid: doc.id,
            companyUid: doc.data()['uidCompany'],
            companyInfo:
                CompanyInfoAdvertisement.fromMap(doc.data()['companyData']) ??
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
      if (advertisements.docs.isNotEmpty) {
        _lastDocument = advertisements.docs[advertisements.docs.length - 1];
      }
      notifyListeners();
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
