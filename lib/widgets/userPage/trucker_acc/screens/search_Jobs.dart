import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/adventisement.dart';
import 'package:truckmanagement_app/widgets/shared/screens/advertisementTrucker.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/providers/advertisements.dart';

class SearchJobs extends StatefulWidget {
  static const routeName = '/searchJobs/';

  @override
  _SearchJobsState createState() => _SearchJobsState();
}

class _SearchJobsState extends State<SearchJobs> {
  bool _isData = false;
  bool _loadingData = false;
  ScrollController _scrollController = ScrollController();

  void didChangeDependencies() {
    if (!_isData) {
      Provider.of<TruckerAdvertisements>(context, listen: false)
          .loadAdvertisements();
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
          Provider.of<TruckerAdvertisements>(context, listen: false)
              .loadAdvertisements(
                  fetchNew: true)
              .whenComplete(() => _loadingData = false);
        } else {
          print('Ladowanie danych.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Advertisement> advertisements =
        Provider.of<TruckerAdvertisements>(context).fetchAdvertisements ?? null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ogloszenia'),
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
                Provider.of<TruckerAdvertisements>(context, listen: false)
                    .refreshAdvertisements(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: advertisements.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) {
                            return PreviewAdvertisementTrucker(
                              advertisement: advertisements[index],
                            );
                          }),
                        );
                      },
                      contentPadding: EdgeInsets.all(15),
                      leading: advertisements[index].companyInfo.logoUrl == ''
                          ? Image.asset('images/default.jpg')
                          : Image.network(
                              advertisements[index].companyInfo.logoUrl),
                      title: Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: Text(
                          advertisements[index].title,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ),
                      subtitle: advertisements[index].endDate == ''
                          ? Text(
                              'Zakonczone',
                              style: TextStyle(
                                  color: Theme.of(context).errorColor),
                            )
                          : Text(
                              'Do: ' +
                                  DateFormat('dd-MM-yyy').format(
                                    DateTime.parse(
                                        advertisements[index].endDate),
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
