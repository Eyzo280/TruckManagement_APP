import 'package:flutter/material.dart';

class ItemAdvertisement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {},
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
            iconEnabledColor: Theme.of(context).primaryColor,
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
                          Icon(Icons.delete_outline),
                          Text(value),
                        ],
                      )
                    : value == 'Edytuj'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.edit),
                              Text(value),
                            ],
                          )
                        : Center(
                            child: Text(value),
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
