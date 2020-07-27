import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/shared/widgets/checkboxformfield.dart';

class AddAdvertisement extends StatelessWidget {
  static const routeName = '/advertisement/AddAdvertisement';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New advertisement'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    'Tytul',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
