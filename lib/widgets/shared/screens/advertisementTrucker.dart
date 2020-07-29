import 'package:flutter/material.dart';

class PreviewAdvertisementTrucker extends StatelessWidget {
  final String uid; // uid uzytkownika
  final String title;
  final Map<String, bool> requirements; // mapa wymagań np. {'karta kierowcy': true}
  final String description;
  //final bool newPreview; // jezeli true to jest to podglad przy tworzeniu nowego ogloszenia lub edytowaniu

  PreviewAdvertisementTrucker({
    this.uid,
    this.title,
    this.requirements,
    this.description,
    //this.newPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Text('s'),
        ],
      ),
    );
  }
}
