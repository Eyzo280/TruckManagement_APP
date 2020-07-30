import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementTrucker.dart';

class ItemAdvertisement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) {
                return PreviewAdvertisementTrucker(
                  uid: 'Uid',
                  title: 'Szukam kierowcy Polska/Wlochy',
                  requirements: {'Karta Kierowcy': true},
                  description:
                      'Witam szukam doświadczonego kierowcy, który będzie pracował w wymiarze 3/1. Kursy w których się specjalizujemy to Polska/Wlochy.',
                );
              }),
            );
          },
          contentPadding: EdgeInsets.all(15),
          leading: Text('Logo'),
          title: Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(
              'Kierowca Wlochy/Niemcy',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black,
                  ),
            ),
          ),
          subtitle: Text('End: 20.08.2020'),
          trailing: DropdownButton(
            underline: Container(
              height: 0,
            ),
            icon: Icon(
              Icons.more_vert,
            ),
            onChanged: (String selectedValue) {
              // Zarzadzanie ogloszeniem
            },
            iconEnabledColor: Theme.of(context).buttonColor,
            items: <String>[
              'Przedluz',
              'Edytuj',
              'Usun',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: value == 'Usun'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                          Text(value),
                        ],
                      )
                    : value == 'Edytuj'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              Text(value),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(
                                Icons.replay,
                                color: Colors.white,
                              ),
                              Text(value),
                            ],
                          ),
              );
            }).toList(),
          ),
        ),
        Divider()
      ],
    );
  }
}
