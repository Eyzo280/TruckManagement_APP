import 'package:flutter/foundation.dart';

class FullTruckDriverData {
  //final String id; // powinno byc normalne ale to dopiero w Bazie danych sie zrobi
  final String firstNameDriver; // imie
  final String lastNameDriver; // nazwisko
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
    @required this.firstNameDriver,
    @required this.lastNameDriver,
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
  final String firstNameDriver; // imie
  final String lastNameDriver; // nazwisko
  final int salary; // pensja
  final int earned; // Zarobione pieniadze od dnia zaczecia pracy
  final int paid; // Zaplacone pieniadze
  final double distanceTraveled; // Przejechane kilometry w firmie
  final bool statusDriver; // status okresla czy kierowca jest w trasie czy nie

  BaseTruckDriverData({
    @required this.uidDriver,
    @required this.firstNameDriver,
    @required this.lastNameDriver,
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

  CompanyData({
    @required this.uidCompany,
    @required this.advertisement,
    @required this.nameCompany,
    @required this.employees,
    @required this.yearEstablishmentCompany,
  });
}

class InvBaseData {
  final String invUid; // uid
  final DateTime dateSentInv; // uid Select Company
  final String firstNameDriver; // ogloszenie
  final String knownLanguages; // nazwa firmy
  final String lastNameDriver; // ilosc pracownikow
  final String numberPhone; // rok zalozenia firmy
  final int totalDistanceTraveled; // rok zalozenia firmy

  InvBaseData({
    @required this.invUid,
    @required this.dateSentInv,
    @required this.firstNameDriver,
    @required this.knownLanguages,
    @required this.lastNameDriver,
    @required this.numberPhone,
    @required this.totalDistanceTraveled,
  });
}

class SearchEmployeesBaseData {
  final String driverUid;
  final DateTime drivingLicenseFrom;
  final String firstNameDriver;
  final String knownLanguages;
  final String lastNameDriver;
  final int totalDistanceTraveled;

    SearchEmployeesBaseData({
      this.driverUid,
      this.drivingLicenseFrom,
      this.firstNameDriver,
      this.knownLanguages,
      this.lastNameDriver,
      this.totalDistanceTraveled,
    });
}