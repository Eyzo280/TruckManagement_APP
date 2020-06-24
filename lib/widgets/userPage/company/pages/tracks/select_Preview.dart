import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/theme.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/tracks/Active/preview.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/tracks/Finished/preview.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/tracks/add_New_Track.dart';

class TracksManagement extends StatelessWidget {
  static const routeName = '/TracksManagement';

  void _openPreview(BuildContext ctx, String preview) {
    if (preview == 'Active') {
      Navigator.of(ctx).pushNamed(TracksActive.routeName);
    } else {
      Navigator.of(ctx).pushNamed(TracksFinished.routeName);
    }
  }

  Widget cardSelected({
    BuildContext context,
    String namePage,
    String name,
  }) {
    return Center(
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: FlatButton(
            onPressed: () {
              _openPreview(context, namePage);
            },
            child: Text(name, style: TextStyle(color: Theme.of(context).textTheme.subhead.color, fontSize: 20)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CompanyData companyData = Provider.of<CompanyData>(context);

    final appBar = AppBar(
      title: Text('Kursy'),
      centerTitle: true,
      flexibleSpace: appBarLook(context: context),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AddNewTrack(companyData: companyData);
                }),
              );
            })
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: bodyLook(context: context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            cardSelected(
              context: context,
              namePage: 'Active',
              name: 'Aktywne',
            ),
            cardSelected(
              context: context,
              namePage: 'Finished',
              name: 'Zakonczone',
            ),
          ],
        ),
      ),
    );
  }
}
