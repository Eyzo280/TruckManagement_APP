import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_Drivers/search_driver_Widgets/filterWidget.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_Drivers/search_driver_Widgets/filtrList.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/search_Drivers/search_driver_Widgets/searchingList.dart';

class SearchDriver extends StatefulWidget {
  static const routeName = '/SearchDriver';

  @override
  _SearchDriverState createState() => _SearchDriverState();
}

class _SearchDriverState extends State<SearchDriver> {
  final kmOd = TextEditingController();
  final kmDo = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        centerTitle: true,
        flexibleSpace: appBarLook(context: context),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                print('Filtr');
                Future<void> future = showModalBottomSheet<void>(
                    context: context,
                    builder: (_) {
                      return FilterWidget(kmOd, kmDo);
                    });
                future.then((void value) {
                  setState(() {});
                });
              })
        ],
      ),
      body: Container(
        decoration: bodyLook(context: context),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            FiltrList(),
            /* Linia oddzielajaca
            Divider(
              color: Colors.black,
              height: 10,
              thickness: 5,
              indent: 20,
              endIndent: 0,
            ),
            */
            SearchingList()
          ],
        ),
      ),
    );
  }
}
