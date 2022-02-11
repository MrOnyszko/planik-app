import 'package:flutter/material.dart';
import 'package:planik/presentation/common/theme.dart';
import 'package:planik/presentation/l10n/translations.dart';
import 'package:planik/presentation/router/app_route_factory.dart';

class Testable extends StatelessWidget {
  const Testable({
    required this.child,
    this.onGenerateRoute,
    this.navigatorObservers = const [],
    Key? key,
  }) : super(key: key);

  final Widget child;
  final RouteFactory? onGenerateRoute;
  final List<NavigatorObserver> navigatorObservers;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: Translations.localizationsDelegates,
      supportedLocales: Translations.supportedLocales,
      theme: AppTheme().theme(LightPalette()),
      home: Scaffold(body: child),
      onGenerateRoute: onGenerateRoute,
      navigatorObservers: navigatorObservers,
    );
  }
}
