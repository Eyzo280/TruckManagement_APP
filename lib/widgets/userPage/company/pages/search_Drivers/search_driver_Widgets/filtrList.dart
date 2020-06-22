import 'package:flutter/material.dart';

class FiltrList extends StatelessWidget {
  List filtrList = ['Przejechane km', 'Przejechane km', 'Przejechane km'];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
          child: Row(
            children: <Widget>[
              const Text('Filtry:'),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filtrList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: Card(
                          color: Theme.of(context).textTheme.display2.color,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).textTheme.display1.color,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Przejechane km: 50 - 100'),
                                  FittedBox(
                                    child: IconButton(
                                      icon: Icon(Icons.close),
                                      iconSize:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
