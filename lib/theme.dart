import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      bodyText1: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      button: base.button.copyWith(
        color: Colors.black,
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Color.fromRGBO(82, 199, 184, 1),
    primaryColor: Color.fromRGBO(38, 50, 56, 1), // #263238
    canvasColor: Color.fromRGBO(82, 199, 184, 1),
    cardColor: Color.fromRGBO(82, 199, 184, 1),
    iconTheme: IconThemeData(
      color: Color.fromRGBO(82, 199, 184, 1),
    ),
    indicatorColor: Color.fromRGBO(82, 199, 184, 1),
    backgroundColor: Color.fromRGBO(38, 50, 56, 1),
    buttonColor: Color.fromRGBO(82, 199, 184, 1),
    scaffoldBackgroundColor: Color.fromRGBO(38, 50, 56, 1),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color.fromRGBO(38, 50, 56, 1),
    ),

    textTheme: _basicTextTheme(base.textTheme),
  );
}

// Gradient(kolory AppBar)
appBarLook({@required BuildContext context}) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        stops: [0.001, 1],
        colors: [
          Theme.of(context).textTheme.display1.color,
          Theme.of(context).textTheme.display2.color,
        ],
      ),
    ),
  );
}

// Gradient(kolory Body)
bodyLook({@required BuildContext context}) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      stops: [0.001, 1],
      colors: [
        Theme.of(context).textTheme.display1.color,
        Theme.of(context).textTheme.display2.color,
      ],
    ),
  );
}

Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}
