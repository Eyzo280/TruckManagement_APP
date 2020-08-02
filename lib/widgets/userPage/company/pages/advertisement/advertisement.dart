import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/advertisement/addNew.dart';
import 'package:truckmanagement_app/widgets/userPage/company/widgets/advertisement/buttonsView.dart';
import 'package:truckmanagement_app/widgets/userPage/company/widgets/advertisement/itemAdvertisement.dart';
import '../../models/adventisement.dart';

class Advertisement extends StatelessWidget {
  static const routeName = '/advertisement/';

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      title: Text('Advertisement'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          color: Theme.of(context).buttonColor,
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            print('Add new advertisement.');
            Navigator.of(context).pushNamed(AddAdvertisement.routeName);
          },
        ),
      ],
    );

    final bodyHeight =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;
    final bodyWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            ButtonsView(),
            Flexible(
              fit: FlexFit.loose,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return ItemAdvertisement();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
