import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/trucker.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/models/application.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/providers/applications.dart';

class MyApplications extends StatefulWidget {
  static const routeName = '/MyApplications/';

  @override
  _MyApplicationsState createState() => _MyApplicationsState();
}

class _MyApplicationsState extends State<MyApplications> {
  String _userUid = '';
  bool _isData = false;
  bool _loadingData = false;
  ScrollController _scrollController = ScrollController();

  void didChangeDependencies() {
    if (!_isData) {
      if (_userUid == '') {
        _userUid = Provider.of<UserData>(context).data.uid;
      }
      Provider.of<Applications>(context, listen: false)
          .loadApplications(userUid: _userUid)
          .catchError((onError) {
        print(onError);
      });
      setState(() {
        _isData = true;
      });
    }

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 25;

      if (maxScroll - currentScroll <= delta) {
        if (!_loadingData) {
          _loadingData = true;

          Provider.of<Applications>(context, listen: false)
              .loadApplications(userUid: _userUid)
              .whenComplete(() => _loadingData = false);
        } else {
          print('Ladowanie danych.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Application> applications =
        Provider.of<Applications>(context).fetchApplications ?? null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Moje Aplikacje'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: RefreshIndicator(
            color: Colors.white,
            onRefresh: () => null,
            //Provider.of<Applications>(context, listen: false).refreshApplications(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: applications.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        /*
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) {
                                return PreviewAdvertisementTrucker(
                                  advertisement: applications[index],
                                );
                              }),
                            );
                            */
                      },
                      contentPadding: EdgeInsets.all(15),
                      leading: Hero(
                        tag: applications[index].uidAdvertisement + '-Image',
                        child: applications[index]
                                    .infoAdvertisement
                                    .companyInfo
                                    .logoUrl ==
                                ''
                            ? Image.asset('images/default.jpg')
                            : Image.network(applications[index]
                                .infoAdvertisement
                                .companyInfo
                                .logoUrl),
                      ),
                      title: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          applications[index].infoAdvertisement.title,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                      subtitle:
                          applications[index].infoAdvertisement.endDate == ''
                              ? Text(
                                  'Zakonczone',
                                  style: TextStyle(
                                      color: Theme.of(context).errorColor),
                                )
                              : Text(
                                  'Do: ' +
                                      DateFormat('dd-MM-yyy').format(
                                        DateTime.parse(applications[index]
                                            .infoAdvertisement
                                            .endDate),
                                      ),
                                ),
                      trailing: Text(''),
                    ),
                    Divider()
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
