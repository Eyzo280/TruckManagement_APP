import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/user.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/application.dart';
import '../../providers/applications.dart' as providers;

class Applications extends StatefulWidget {
  static const routeName = '/Applications/';

  final String uidCompany;

  Applications({this.uidCompany});

  @override
  _ApplicationsState createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  bool _isData = false;
  bool _loadingData = false;
  ScrollController _scrollController = ScrollController();

  void didChangeDependencies() {
    if (!_isData) {
      Provider.of<providers.Applications>(context, listen: false)
          .loadApplications(uidCompany: widget.uidCompany)
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

          Provider.of<providers.Applications>(context, listen: false)
              .loadApplications(uidCompany: widget.uidCompany)
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
        Provider.of<providers.Applications>(context).fetchApplications ?? null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Zgloszenia'),
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
            onRefresh: () =>
                Provider.of<providers.Applications>(context, listen: false)
                    .refreshApplications(uidCompany: widget.uidCompany),
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: applications.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        // push do strony zwykłej aplikacji z przyciskami Zapros, Anuluj.
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
                      subtitle: Text(
                        'Dostarczono: ' +
                            DateFormat('dd-MM-yyy').format(
                              DateTime.parse(
                                  applications[index].dateSendApplication),
                            ),
                      ),
                      trailing: Text(
                        applications[index].infoAdvertisement.type == 'Trucker'
                            ? 'Kierowca'
                            : 'Spedytor',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor),
                      ),
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
