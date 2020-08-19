import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';

class Application {
  final Advertisement infoAdvertisement; // Dane ogloszenia
  //final CompanyInfoAdvertisement companyData;
  final Trucker userInfo;
  final String additionalInfo;
  final String uidAdvertisement;
  final String uidApplicator;
  final String uidCompany;
  final String dateSendApplication;

  Application({
    this.infoAdvertisement,
    //this.companyData,
    this.userInfo,
    this.additionalInfo,
    this.uidAdvertisement,
    this.uidApplicator,
    this.uidCompany,
    this.dateSendApplication,
  });
}
