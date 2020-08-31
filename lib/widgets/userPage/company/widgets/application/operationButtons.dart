import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckmanagement_app/models/application.dart';
import 'package:truckmanagement_app/widgets/userPage/company/providers/applications.dart';

class OperationButtons extends StatefulWidget {
  final Application application;

  OperationButtons({this.application});

  @override
  _OperationButtonsState createState() => _OperationButtonsState();
}

class _OperationButtonsState extends State<OperationButtons> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    void snackBarError(String value) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
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
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              value,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green,
          ),
        );
    }

    void changeStatus({
      String text,
      Application check,
      bool endApplication = false,
    }) async {
      setState(() {
        loading = true;
      });
      try {
        await Provider.of<Applications>(context, listen: false)
            .changeStatus(
                applicationID: widget.application.applicationID,
                status: check.status,
                endApplication: endApplication)
            .whenComplete(
          () {
            snackBarSuccess(text);
            setState(() {
              loading = false;
            });
          },
        );
      } catch (err) {
        setState(() {
          loading = false;
        });
        return snackBarError(
          text,
        );
      }
    }

    return Consumer<Applications>(
      builder: (_, applications, __) {
        Application check = applications.fetchApplications.firstWhere(
            (element) =>
                element.applicationID == widget.application.applicationID);
        return loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : check.status == 'Zakonczona'
                ? SizedBox()
                : check.status == 'Zaproszenie'
                    ? Center(
                        child: FlatButton(
                          onPressed: () async => changeStatus(
                            text: 'Anulowano zaproszenie.',
                            check: check,
                          ),
                          color: Theme.of(context).canvasColor,
                          child: Text(
                            'Anuluj zaproszenie',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                            onPressed: () async => changeStatus(
                              text: 'Wysłano zaproszenie',
                              check: check,
                            ),
                            color: Theme.of(context).canvasColor,
                            child: Text(
                              'Zapros',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          FlatButton(
                            onPressed: () async => changeStatus(
                              text: 'Wystąpił problem. Sprobuj później.',
                              check: check,
                              endApplication: true,
                            ),
                            color: Theme.of(context).canvasColor,
                            child: Text(
                              'Odrzuc',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
      },
    );
  }
}
