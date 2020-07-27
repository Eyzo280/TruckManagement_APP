import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      bodyText1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      button: base.button.copyWith(
        color: Colors.black,
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Color.fromRGBO(38, 50, 56, 1), // #263238
    canvasColor: Color.fromRGBO(178, 223, 219, 1), // #b2dfdb
    cardColor: Color.fromRGBO(98, 114, 123, 0.8),
    dividerColor: Colors.black45,
    disabledColor: Colors.grey,
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
