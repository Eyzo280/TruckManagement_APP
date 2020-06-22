import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FullTruckDriverData {
  //final String id; // powinno byc normalne ale to dopiero w Bazie danych sie zrobi
  final String firstName; // imie
  final String lastName; // nazwisko
  final int salary; // pensja
  final int earned; // Zarobione pieniadze od dnia zaczecia pracy
  final int paid; // Zaplacone pieniadze
  final double distanceTraveled; // Przejechane kilometry w firmie
  final bool statusDriver; // status okresla czy kierowca jest w trasie czy nie
  final double costDriver; // koszty utrzymania kierowcy
  final String numberPhone; // numer telefonu
  final DateTime dateOfEmplotment; // Data zatrudnienia
  final DateTime payday; // dzien wyplaty

  FullTruckDriverData({
    //@required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.salary,
    @required this.earned,
    @required this.paid,
    @required this.distanceTraveled,
    @required this.statusDriver,
    @required this.costDriver,
    @required this.numberPhone,
    @required this.dateOfEmplotment,
    @required this.payday,
  });
}

class BaseTruckDriverData {
  final String uidDriver; // uid Driver
  final String firstName; // imie
  final String lastName; // nazwisko
  final int salary; // pensja
  final int earned; // Zarobione pieniadze od dnia zaczecia pracy
  final int paid; // Zaplacone pieniadze
  final double distanceTraveled; // Przejechane kilometry w firmie
  final bool statusDriver; // status okresla czy kierowca jest w trasie czy nie

  BaseTruckDriverData({
    @required this.uidDriver,
    @required this.firstName,
    @required this.lastName,
    @required this.salary,
    @required this.earned,
    @required this.paid,
    @required this.distanceTraveled,
    @required this.statusDriver,
  });
}

class CompanyData {
  final String uidCompany; // uid Select Company
  final bool advertisement; // ogloszenie
  final String nameCompany; // nazwa firmy
  final int employees; // ilosc pracownikow
  final DateTime yearEstablishmentCompany; // rok zalozenia firmy
  final String type;

  CompanyData({
    @required this.uidCompany,
    @required this.advertisement,
    @required this.nameCompany,
    @required this.employees,
    @required this.yearEstablishmentCompany,
    @required this.type,
  });
}

class InvData {
  final String invUid; // uid
  final DateTime dateSentInv; // uid Select Company
  final DateTime dateOfEmplotment; // Data utworzenia konta
  final String drivingLicense; // Prawo jazdy
  final DateTime drivingLicenseFrom; // od kiedy prawojazdy
  final String firstName; // Imie
  final String knownLanguages; // Jakie zna jezyki
  final String lastName; // Nazwisko
  final String numberPhone; // Nr tel
  final int totalDistanceTraveled; // Calkowita ilosc przejechanych km
  final String type; // typ Konta uzytkownika

  InvData({
    @required this.invUid,
    @required this.dateSentInv,
    @required this.dateOfEmplotment,
    @required this.firstName,
    @required this.lastName,
    @required this.numberPhone,
    @required this.drivingLicense,
    @required this.drivingLicenseFrom,
    @required this.knownLanguages,
    @required this.totalDistanceTraveled,
    @required this.type,
  });
}

class SearchDriverData {
  final String driverUid;
  final DateTime dateOfEmplotment;
  final String drivingLicense;
  final DateTime drivingLicenseFrom;
  final String firstName;
  final String knownLanguages;
  final String lastName;
  final String numberPhone;
  final int totalDistanceTraveled;
  final String type;

  SearchDriverData({
    this.driverUid,
    this.dateOfEmplotment,
    this.drivingLicense,
    this.drivingLicenseFrom,
    this.firstName,
    this.knownLanguages,
    this.lastName,
    this.numberPhone,
    this.totalDistanceTraveled,
    this.type,
  });

  calculationAccountActivityTime<String>({registerAccTime}) {
    int year;
    int month;
    int day;

    int yearNow = DateTime.now().year;
    int monthNow = DateTime.now().month;
    int dayNow = DateTime.now().day;

    int yearAcc = registerAccTime.year;
    int monthAcc = registerAccTime.month;
    int dayAcc = registerAccTime.day;

    year = yearNow - yearAcc;
    month = monthNow - monthAcc;
    day = dayNow - dayAcc;

    int amountDay = DateTime.now().difference(registerAccTime).inDays;

    if (year != 0 && amountDay > 365) {
      //                  Trzeba jeszcze sprawdzic
      int amount = (amountDay / 365).truncate();
      if (amount == 1) {
        print('Ponad roku');
        return 'Ponad roku';
      } // else if (amount < 5) {
      // print('Ponad ${amount.toString()} lata');
      // return 'Ponad ${amount.toString()} lata';
      // }
      else {
        print('Ponad ${amount.toString()} lat');
        return 'Ponad ${amount.toString()} lat';
      }
    } else if (dayNow >= dayAcc && month > 0) {
      print('Ponad ${month.toString()} mies');
      return 'Ponad ${month.toString()} mies';
    } else if (day > 0) {
      print('Ponad ${amountDay.toString()} dni');
      return 'Ponad ${amountDay.toString()} dni';
    } else {
      if (amountDay == 1) {
        print('Ponad ${amountDay.toString()} dzien');
        return 'Ponad ${amountDay.toString()} dzien';
      } else if (amountDay == 0) {
        print('Ponizej jednego dnia');
        return 'Ponizej jednego dnia';
      } else {
        print('Ponad ${amountDay.toString()} dni');
        return 'Ponad ${amountDay.toString()} dni';
      }
    }
  }
}

class Track {
  final String dodatkoweInfo;
  final int fracht;
  final String from;
  final bool status;
  final DateTime termin;
  final String to;
  final GeoPoint wspolrzedneDostawy;

  Track({
    this.dodatkoweInfo,
    this.fracht,
    this.from,
    this.status,
    this.termin,
    this.to,
    this.wspolrzedneDostawy,
  });
}
