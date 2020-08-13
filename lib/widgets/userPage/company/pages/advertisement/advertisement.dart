import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/widgets/userPage/company/models/adventisement.dart'
    as model;
import 'package:truckmanagement_app/widgets/userPage/company/models/company_Employees.dart';
import 'package:truckmanagement_app/widgets/userPage/company/pages/advertisement/addNew.dart';
import 'package:truckmanagement_app/widgets/userPage/company/providers/advetisement.dart';
import 'package:truckmanagement_app/widgets/userPage/company/widgets/advertisement/buttonsView.dart';
import 'package:truckmanagement_app/widgets/userPage/company/widgets/advertisement/itemAdvertisement.dart';

class Advertisement extends StatefulWidget {
  static const routeName = '/advertisement/';

  @override
  _AdvertisementState createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  @override
  bool _isData = false;
  ScrollController _scrollController = ScrollController();
  String _uidCompany;
  model.SelectedAdvertisement _selectedAdvertisement =
      model.SelectedAdvertisement.Active;
  bool _loadingData =
      false; // gdy dane sa pobierane po przewinieciu w dol to _loadingData jest ustawiany na true

  void changeSelectedAdvertisement({
    model.SelectedAdvertisement selectedAdvertisement,
  }) {
    Provider.of<CompanyAdvertisements>(context, listen: false)
        .viewCompanyAdvertisement(
      uidCompany: _uidCompany,
      selectedAdvertisement: selectedAdvertisement,
    );
    setState(() {
      _selectedAdvertisement = selectedAdvertisement;
    });
  }

  void didChangeDependencies() {
    if (!_isData) {
      _uidCompany = Provider.of<CompanyData>(context).uid;
      Provider.of<CompanyAdvertisements>(context, listen: false)
          .viewCompanyAdvertisement(
        uidCompany: _uidCompany,
        selectedAdvertisement: _selectedAdvertisement,
      );
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
          Provider.of<CompanyAdvertisements>(context, listen: false)
              .viewCompanyAdvertisement(
                  uidCompany: _uidCompany,
                  fetch: true,
                  selectedAdvertisement: _selectedAdvertisement)
              .whenComplete(() => _loadingData = false);
        } else {
          print('Ladowanie danych.');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<model.Advertisement> companyActiveAdvertisements =
        Provider.of<CompanyAdvertisements>(context, listen: true)
            .fetchActiveAdvertisement;

    List<model.Advertisement> companyFinishedAdvertisements =
        Provider.of<CompanyAdvertisements>(context, listen: true)
            .fetchFinishedAdvertisement;

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

    Widget advertisements({
      BuildContext context,
      List<model.Advertisement> selectedAdvertisementData,
    }) {
      return selectedAdvertisementData.isEmpty
          ? ListView(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.all(50),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            )
          : ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: selectedAdvertisementData.length,
              itemBuilder: (context, index) {
                return ItemAdvertisement(
                  advertisement: selectedAdvertisementData[index],
                  selectedAdvertisement: _selectedAdvertisement,
                );
              },
            );
    }

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Column(
          children: <Widget>[
            ButtonsView(
              changeSelectedAdvertisement: changeSelectedAdvertisement,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(35),
                ),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: RefreshIndicator(
                    color: Colors.white,
                    onRefresh: () => Provider.of<CompanyAdvertisements>(context,
                            listen: false)
                        .refreshAdvertisement(
                      uidCompany: _uidCompany,
                      selectedAdvertisement: _selectedAdvertisement,
                    ),
                    child: _selectedAdvertisement ==
                            model.SelectedAdvertisement.Active
                        ? advertisements(
                            context: context,
                            selectedAdvertisementData:
                                companyActiveAdvertisements)
                        : advertisements(
                            context: context,
                            selectedAdvertisementData:
                                companyFinishedAdvertisements),
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
