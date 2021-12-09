import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:planik/presentation/screens/splash/splash_screen.dart';

class AppRouteFactory {
  Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashScreen(),
        );
    }
  }
}
