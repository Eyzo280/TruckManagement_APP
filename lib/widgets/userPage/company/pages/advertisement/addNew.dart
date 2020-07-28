import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/checkboxformfield.dart';

class AddAdvertisement extends StatefulWidget {
  static const routeName = '/advertisement/AddAdvertisement';

  @override
  _AddAdvertisementState createState() => _AddAdvertisementState();
}

class _AddAdvertisementState extends State<AddAdvertisement> {
  String selectedCategory = null;

  Widget trucker(BuildContext context) {
    return Form(
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(
                  'Tytul',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 30,
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                  ),
                ),
                Divider(),
                Text(
                  'Wymagania',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                CheckboxFormField(
                  title: Text('Karta Kierowcy'),
                ),
                CheckboxFormField(
                  title: Text('Zaswiadczenie o niekaralnosci'),
                ),
                Divider(),
                Text(
                  'Opis',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: null,
                    maxLength: 300,
                    decoration: new InputDecoration(
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Dalej'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New advertisement'),
        centerTitle: true,
      ),
      body:GestureDetector(
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
                    Text('Wybierz kategorie ', style: Theme.of(context).textTheme.bodyText1,),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    ? trucker(context)
                    : selectedCategory == 'Spedytorzy'
                        ? Center(
                            child: Text('Trzeba dodac', style: Theme.of(context).textTheme.bodyText1,),
                          )
                        : Center(
                            child: Text('Brak Kategorii', style: Theme.of(context).textTheme.bodyText1,),
                          ),
              ),
            ],
          ),
        ),
      
    );
  }
}
