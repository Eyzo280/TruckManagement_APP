import 'package:flutter/foundation.dart';

class TruckDriver {
  final String id; // powinno byc normalne ale to dopiero w Bazie danych sie zrobi
  final String nameDriver; // imie i nazwisko
  final double salary; // pensja
  final double costDriver; // koszty utrzymania kierowcy
  final String numberPhone; // numer telefonu
  final DateTime dateOfEmplotment; // Data zatrudnienia
  final DateTime payday; // dzien wyplaty

  TruckDriver({
    @required this.id,
    @required this.nameDriver,
    @required this.salary,
    @required this.costDriver,
    @required this.numberPhone,
    @required this.dateOfEmplotment,
    @required this.payday,
  });
}
