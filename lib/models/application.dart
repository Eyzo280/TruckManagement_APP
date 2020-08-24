import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';

class Application {
  final String applicationID;
  final Advertisement infoAdvertisement; // Dane ogloszenia
  //final CompanyInfoAdvertisement companyData;
  final Trucker userInfo;
  final String additionalInfo;
  final String uidAdvertisement;
  final String uidApplicator;
  final String uidCompany;
  final String dateSendApplication;
  String status; // Jezeli true to jest Rozpatrywana aplikacja w przeciwnym razie jest zakonczona.

  Application({
    this.applicationID,
    this.infoAdvertisement,
    //this.companyData,
    this.userInfo,
    this.additionalInfo,
    this.uidAdvertisement,
    this.uidApplicator,
    this.uidCompany,
    this.dateSendApplication,
    this.status,
  });
}
