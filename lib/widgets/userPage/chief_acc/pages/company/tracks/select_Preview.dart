import 'package:flutter/material.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/tracks/Active/preview.dart';
import 'package:truckmanagement_app/widgets/userPage/chief_acc/pages/company/tracks/Finished/preview.dart';

class TracksSelect extends StatelessWidget {
  final companyData;

  TracksSelect({this.companyData});

  void _openPreview(BuildContext ctx, String preview) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      if (preview == 'Active') {
        return TracksActive();
      } else {
        return TracksFinished(companyData: companyData);
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Kursy'),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                child: FlatButton(
                  onPressed: () {
                    _openPreview(context, 'Active');
                  },
                  child: Text('Aktywne'),
                ),
              ),
            ),
          ),
          Center(
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.5,
                child: FlatButton(
                  onPressed: () {
                    _openPreview(context, 'Finished');
                  },
                  child: Text('Zakonczone'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
