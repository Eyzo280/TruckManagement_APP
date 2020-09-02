import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).canvasColor,
          child: Center(
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Załadunek',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        // oznacza że nie kierowca nie był na załadunku.
                        Icons.check_box_outline_blank,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    'Westfalendamm 272, Dortmund, Niemcy',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
