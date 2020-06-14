import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopBodyCompanyMain extends StatelessWidget {
  Widget topBodyButtons(BuildContext context, String button) {
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            border:
                Border.all(color: Color.fromRGBO(55, 71, 79, 0.5), width: 1)),
        child: FlatButton(
          onPressed: () {
            print(button);
          },
          child: Text(
            button,
            style: TextStyle(color: Theme.of(context).textTheme.button.color),
          ),
        ),
      ),
    );
  }

  @override
 

  Widget build(BuildContext context) {
    List topBodyWidgets = [
      // Stats
      Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  'Statystyki',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                width: double.infinity,
                // color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          topBodyButtons(context, 'Kierowcy'),
                          topBodyButtons(context, 'Spedytorzy'),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          topBodyButtons(context, 'Ciezarowki'),
                          topBodyButtons(context, 'Kursy'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Chart
      Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  'Wykresy',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                width: double.infinity,
                // color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          topBodyButtons(context, 'Kierowcow'),
                          topBodyButtons(context, 'Spedytorow'),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          topBodyButtons(context, 'Ciezarowek'),
                          topBodyButtons(context, 'Kursow'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Management
      Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Center(
                child: Text(
                  'Zarzadzanie',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                width: double.infinity,
                // color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          topBodyButtons(context, 'Kierowcy'),
                          topBodyButtons(context, 'Spedytorzy'),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        children: <Widget>[
                          topBodyButtons(context, 'Ciezarowki'),
                          topBodyButtons(context, 'Kursy'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];

     Widget chartSlider = CarouselSlider.builder(
    itemCount: topBodyWidgets.length,
    itemBuilder: (context, index) {
      return topBodyWidgets[index];
    },
    options: CarouselOptions(autoPlay: false, enlargeCenterPage: true),
  );

    return Flexible(
      flex: 5,
      fit: FlexFit.tight,
      child: Center(
        child: Container(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 10,
            ),
            width: double.infinity,
            child: chartSlider),
      ),
    );
  }
}
