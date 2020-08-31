import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/application.dart';
import 'package:truckmanagement_app/widgets/userPage/trucker_acc/providers/applications.dart';

class OperationButtons extends StatefulWidget {
  final String userUid;
  final Application application;

  OperationButtons({
    this.userUid,
    this.application,
  });

  @override
  _OperationButtonsState createState() => _OperationButtonsState();
}

class _OperationButtonsState extends State<OperationButtons> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    void snackBarError(String value) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }

    void snackBarSuccess(String value) {
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
    }

    return Consumer<Applications>(
      builder: (_, applications, __) {
        var check = applications.fetchApplications.firstWhere((element) =>
            element.applicationID == widget.application.applicationID);
        return check.status == 'Rozpatrywana' || check.status == 'Zakonczona'
            ? SizedBox()
            : Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            await Provider.of<Applications>(context,
                                    listen: false)
                                .acceptInvite(
                                  userUid: widget.userUid,
                                  applicationId:
                                      widget.application.applicationID,
                                  uidCompany: widget
                                      .application.infoAdvertisement.companyUid,
                                )
                                .whenComplete(
                                  () => snackBarSuccess(
                                      'Zaakceptowano zaproszenie.'),
                                );
                          } catch (err) {
                            setState(() {
                              loading = false;
                            });
                            snackBarError('Wystąpił problem. Sprobuj później.');
                          }
                        },
                        color: Theme.of(context).canvasColor,
                        child: const Text('Akceptuj'),
                      ),
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            await Provider.of<Applications>(context,
                                    listen: false)
                                .cancelInvite(
                                  applicationId:
                                      widget.application.applicationID,
                                )
                                .whenComplete(
                                  () => snackBarSuccess(
                                      'Odrzucono zaproszenie.'),
                                );
                            ;
                          } catch (err) {
                            setState(() {
                              loading = false;
                            });
                            snackBarError('Wystąpił problem. Sprobuj później.');
                          }
                        },
                        color: Theme.of(context).canvasColor,
                        child: const Text('Odrzuc'),
                      ),
                    ],
                  ),
                ],
              );
      },
    );
  }
}
