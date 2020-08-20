import 'package:flutter/cupertino.dart';
import 'package:truckmanagement_app/widgets/userPage/company/providers/advetisement.dart';

enum SelectedAdvertisement {
  Active,
  Finished,
}

class CompanyInfoAdvertisement {
  final String name;
  final String logoUrl;
  final String phone;

  CompanyInfoAdvertisement({
    this.name,
    this.logoUrl,
    this.phone,
  });

  factory CompanyInfoAdvertisement.fromMap(Map<String, dynamic> data) {
    return CompanyInfoAdvertisement(
      name: data['name'],
      logoUrl: data['logoUrl'],
      phone: data['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logoUrl': logoUrl,
      'phone': phone,
    };
  }
}

class RequirementsAdvertisementForwarder {
  final bool doswiadczenie;
  final bool zaswiadczenieoniekaralnosci;
  final bool umiejetnoscianalityczne;

  RequirementsAdvertisementForwarder({
    this.doswiadczenie,
    this.zaswiadczenieoniekaralnosci,
    this.umiejetnoscianalityczne,
  });

  factory RequirementsAdvertisementForwarder.fromMap(
      Map<String, dynamic> data) {
    return RequirementsAdvertisementForwarder(
      doswiadczenie: data['doswiadczenie'] ?? false,
      zaswiadczenieoniekaralnosci: data['zaswiadczenieoniekaralnosci'] ?? false,
      umiejetnoscianalityczne: data['umiejetnoscianalityczne'] ?? false,
    );
  }
}

class RequirementsAdvertisementTrucker {
  final bool kartaKierowcy;
  final bool zaswiadczenieoniekaralnosci;

  RequirementsAdvertisementTrucker({
    this.kartaKierowcy,
    this.zaswiadczenieoniekaralnosci,
  });

  factory RequirementsAdvertisementTrucker.fromMap(Map<String, dynamic> data) {
    return RequirementsAdvertisementTrucker(
      kartaKierowcy: data['kartakierowcy'] ?? false,
      zaswiadczenieoniekaralnosci: data['zaswiadczenieoniekaralnosci'] ?? false,
    );
  }

  Map<String, dynamic> toMap({RequirementsAdvertisementTrucker requirements}) {
    return {
      'kartaKierowcy': requirements.kartaKierowcy,
      'zaswiadczenieoniekaralnosci': requirements.zaswiadczenieoniekaralnosci,
    };
  }
}

class Advertisement {
  final String advertisementUid;
  final String companyUid; // uid firmy do ktorej nalezy ogloszenie
  final CompanyInfoAdvertisement companyInfo;
  final String title;
  final requirements; // mapa z wymaganiami np. {'Karta kierowcy': true}
  final String description;
  final String type; // typ ogloszenia np. 'Trucker'
  String endDate; // kiedy konczy sie ogloszenie

  Advertisement({
    @required this.advertisementUid,
    this.companyUid,
    @required this.companyInfo,
    @required this.title,
    @required this.requirements,
    @required this.description,
    @required this.type,
    @required this.endDate,
  });

  factory Advertisement.fromMap(Map<String, dynamic> data) {
    return Advertisement(
      advertisementUid: data['advertisementUid'] ?? null,
      companyUid: data['companyUid'] ?? null,
      companyInfo:
          CompanyInfoAdvertisement.fromMap(data['companyInfo']) ?? null,
      title: data['title'] ?? null,
      requirements: data['type'] == 'Trucker'
          ? RequirementsAdvertisementTrucker.fromMap(data['requirements']) ??
              null
          : RequirementsAdvertisementForwarder() ?? null,
      description: data['description'] ?? null,
      type: data['type'] ?? null,
      endDate: data['endDate'] ?? null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'advertisementUid': advertisementUid,
      'companyUid': companyUid,
      'companyInfo': companyInfo.toMap(),
      'title': title,
      'requirements': type == 'Trucker'
          ? RequirementsAdvertisementTrucker()
                  .toMap(requirements: requirements) ??
              null
          : RequirementsAdvertisementForwarder() ?? null,
      'description': description,
      'type': type,
      'endDate': endDate,
    };
  }
}
