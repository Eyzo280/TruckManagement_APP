import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/management/truckers.dart';

class TopBodyCompanyMain extends StatelessWidget {
  final CompanyData companyData;

  TopBodyCompanyMain({@required this.companyData});

  Widget buttons({
    @required BuildContext context,
    @required String page,
    @required String name,
  }) {
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
            Navigator.of(context).pushNamed('/${page}');
            print(name);
          },
          child: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List topBodyWidgets = [
      // Management
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: Theme.of(context).accentColor,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    'Zarzadzanie',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                          fontSize: 25,
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
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Kierowcy'),
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Spedytorzy'),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Row(
                          children: <Widget>[
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Ciezarowki'),
                            buttons(
                                context: context,
                                page: 'TracksManagement',
                                name: 'Kursy'),
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
      ),
      // Stats
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: Theme.of(context).accentColor,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    'Statystyki',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                          fontSize: 25,
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
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Kierowcy'),
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Spedytorzy'),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Row(
                          children: <Widget>[
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Ciezarowki'),
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Kursy'),
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
      ),
      // Chart
      ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          color: Theme.of(context).accentColor,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    'Wykresy',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                          fontSize: 25,
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
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Kierowcy'),
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Spedytorzy'),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Row(
                          children: <Widget>[
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Ciezarowki'),
                            buttons(
                                context: context,
                                page: 'TruckerLook',
                                name: 'Kursy'),
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
