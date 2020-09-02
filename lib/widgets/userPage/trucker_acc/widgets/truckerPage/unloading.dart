import 'package:flutter/material.dart';

class Unloading extends StatefulWidget {
  @override
  _UnloadingState createState() => _UnloadingState();
}

class _UnloadingState extends State<Unloading> {
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
                        'Rozładunek',
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
                    'Stary Rynek 13, 06-500 Mława',
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
