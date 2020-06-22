import 'package:flutter/material.dart';

class LastTracksCompanyMain extends StatelessWidget {
  Widget track({@required context}) {
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.35,
      margin: EdgeInsets.all(
        MediaQuery.of(context).size.width * 0.01,
      ),
      padding: EdgeInsets.all(
        MediaQuery.of(context).size.width * 0.01,
      ),
      child: Card(
        margin: EdgeInsets.all(0),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.centerLeft,
              stops: [0.001, 0.2],
              colors: [
                Theme.of(context).textTheme.display1.color,
                Theme.of(context).textTheme.display2.color,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(
                child: FittedBox(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'icons/flags/png/pl.png',
                        package: 'country_icons',
                      ),
                      Icon(
                        Icons.arrow_downward,
                        color: Theme.of(context).textTheme.body1.color,
                      ),
                      Image.asset(
                        'icons/flags/png/nl.png',
                        package: 'country_icons',
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Zysk'),
                      Text(
                        '3250',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text('Kierowca'),
                      Text(
                        'Stasiek W.',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      fit: FlexFit.tight,
      child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Text(
                  'Ostatnie Kursy',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Container(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return
                          /*
                      Container(
                        color: Colors.grey,
                        height: double.infinity,
                        width: MediaQuery.of(context).size.width * 0.35,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /*
                            Text('Zlecone przez:'),
                            Icon(Icons.people),
                            Text('Fracht: 8000'),
                            */
                            Text('Warszawa - Krakow'),
                            FittedBox(child: Text('Zlecone przez: Damian W')),
                            FittedBox(child: Text('Kierowca: Wladymir S')),
                          ],
                        ),
                      );
                      */
                          track(context: context);
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
