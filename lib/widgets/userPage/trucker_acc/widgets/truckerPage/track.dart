import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/truckerPage/loading.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/widgets/truckerPage/unloading.dart';

class Track extends StatefulWidget {
  @override
  _TrackState createState() => _TrackState();
}

class _TrackState extends State<Track> {
  // Animation Settings

  double _opacity = 0.0;

  Widget termAndInfo(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).canvasColor,
                child: Center(
                  child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Terminy:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Załadunek: 02.09.2020',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Rozładunek: 05.09.2020',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).canvasColor,
                child: Center(
                  child: Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Pozostałe info:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          children: [
                            Text(
                              'Waga: 23.5 t',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Ładunek: Kawa',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(seconds: 1),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Card(
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            margin: EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Theme.of(context).canvasColor,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Obecny Kurs: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Dortmund / Warszawa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Row(
                              children: [
                                // Punkty Zaladunek oraz Rozładunek
                                Loading(),
                                Unloading(),
                              ],
                            ),
                          ),
                          termAndInfo(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
