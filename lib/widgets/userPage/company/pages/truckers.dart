import 'package:flutter/material.dart';

class Truckers extends StatelessWidget {
  static const routeName = '/Truckers/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moi kierowcy'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            margin: EdgeInsets.all(15),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding: EdgeInsets.all(15),
              onTap: () {},
              title: Text(
                'Andrzej',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Text('W trasie'),
            ),
          );
        },
      ),
    );
  }
}
