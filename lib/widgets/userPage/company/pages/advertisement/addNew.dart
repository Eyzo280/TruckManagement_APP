import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/company/widgets/advertisement/addNew/forwarders.dart';
import 'package:truckmanagement_app/widgets/userPage/company/widgets/advertisement/addNew/trucker.dart';

class AddAdvertisement extends StatefulWidget {
  static const routeName = '/advertisement/AddAdvertisement';

  @override
  _AddAdvertisementState createState() => _AddAdvertisementState();
}

class _AddAdvertisementState extends State<AddAdvertisement> {
  String selectedCategory = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New advertisement'),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Wybierz kategorie ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 9.0),
                      child: DropdownButton(
                        iconEnabledColor: Colors.white,
                        value: selectedCategory,
                        onChanged: (String selectedValue) {
                          // Zarzadzanie ogloszeniem
                          setState(() {
                            selectedCategory = selectedValue;
                          });
                        },
                        underline: Container(
                          height: 0,
                        ),
                        items: <String>[
                          'Kierowcy',
                          'Spedytorzy',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: selectedCategory == 'Kierowcy'
                  ? NewAdvertisementTrucker()
                  : selectedCategory == 'Spedytorzy'
                      ? NewAdvertisementForwarders()
                      : Center(
                          child: Text(
                            'Brak Kategorii',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
