import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/screens/newApplication.dart';

class PreviewAdvertisementTrucker extends StatelessWidget {
  Advertisement advertisement;
  bool application;
  /*
  final String uid; // uid uzytkownika
  final String companyName;
  final String title;
  final Map<String, bool>
      requirements; // mapa wymagań np. {'karta kierowcy': true}
  final String description;
  final String userType;
  
  final String logoUrl;
  */
  //final bool newPreview; // jezeli true to jest to podglad przy tworzeniu nowego ogloszenia lub edytowaniu

  PreviewAdvertisementTrucker({
    this.advertisement,
    this.application = true,
    /*
    this.uid,
    this.companyName,
    this.title,
    this.requirements,
    this.description,
    this.userType,
    
    this.logoUrl,
    */
    //this.newPreview,
  });

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Szukam kierowcy Polska/Wlochy'),
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
                      child: Hero(
                        tag: advertisement.advertisementUid + '-Image',
                        child: advertisement.companyInfo.logoUrl == ''
                            ? Image.asset('images/default.jpg')
                            : Image.network(advertisement.companyInfo.logoUrl),
                      ),
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
                              advertisement.companyInfo.name,
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
              borderRadius: const BorderRadius.vertical(
                top: const Radius.circular(35),
              ),
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
                            const SizedBox(
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
                            const SizedBox(height: 15),
                            Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  advertisement.requirements.kartaKierowcy ==
                                          true
                                      ? const Text(
                                          '\u2022 Karta Kierowcy',
                                          style: TextStyle(fontSize: 20),
                                        )
                                      : const SizedBox(),
                                  advertisement.requirements
                                              .zaswiadczenieoniekaralnosci ==
                                          true
                                      ? const Text(
                                          '\u2022 Zaswiadczenie o niekaralnosci',
                                          style: TextStyle(fontSize: 20),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            const SizedBox(
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
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    advertisement.description == ''
                                        ? const Center(
                                            child: const Text('Brak'),
                                          )
                                        : Text(advertisement.description),
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
      floatingActionButton:
          userData.data.type != 'Trucker' || application == false
              ? null
              : FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      TruckerNewApplication.routeName,
                      arguments: advertisement,
                    );
                    // funkcja zgloszenia się na ogloszenie
                  },
                  label: const Text('Aplikuj'),
                ),
    );
  }
}
