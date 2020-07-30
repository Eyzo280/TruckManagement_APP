import 'package:flutter/material.dart';

class PreviewAdvertisementTrucker extends StatelessWidget {
  final String uid; // uid uzytkownika
  final String title;
  final Map<String, bool>
      requirements; // mapa wymagań np. {'karta kierowcy': true}
  final String description;
  final String userType;
  //final bool newPreview; // jezeli true to jest to podglad przy tworzeniu nowego ogloszenia lub edytowaniu

  PreviewAdvertisementTrucker({
    this.uid,
    this.title,
    this.requirements,
    this.description,
    this.userType,
    //this.newPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Szukam kierowcy Polska/Wlochy'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              //color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Image.asset('images/image-512.png'),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Stefania Trans',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      // shrinkWrap: true,
                      // padding: EdgeInsets.all(15),
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Text(
                                'Wymagania',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 25),
                              ),
                            ),
                            SizedBox(height: 15),
                            FittedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '\u2022 Karta Kierowcy: Tak',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    '\u2022 Zaswiadczenie o niekaralnosci: Tak',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(35)),
                            child: Container(
                              color: Theme.of(context).accentColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          'Opis',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                        'Witam, nasza firma poszukuję kierowcy międzynarodowego, który chciałby pracować w systemie 3/1.'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: userType != 'Trucker'
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                // funkcja zgloszenia się na ogloszenie
              },
              label: Text('Report back'),
            ),
    );
  }
}
