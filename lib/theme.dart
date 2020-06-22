import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
      display1: base.display1.copyWith(
        color: Color.fromRGBO(16, 32, 39, 1),
      ),
      display2: base.display2.copyWith(
        color: Color.fromRGBO(98, 114, 123, 1),
      ),
      display3: TextStyle(color: Color.fromRGBO(255, 193, 7, 1)),
      body1: base.body1.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      body2: base.body2.copyWith(
        fontWeight: FontWeight.bold,
        
        /*
        shadows: [
          Shadow(
            offset: Offset(2.0, 2.0),
            blurRadius: 10.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ],
        */
      ),
      title: TextStyle(color: Colors.white),
      button: base.button.copyWith(
        color: Colors.white,
      ),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: Color.fromRGBO(255, 193, 7, 1),
    cardColor: Color.fromRGBO(98, 114, 123, 0.8),
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