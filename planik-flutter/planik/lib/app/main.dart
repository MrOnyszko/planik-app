import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:planik/presentation/common/theme.dart';
import 'package:planik/presentation/injector_container.dart';
import 'package:planik/presentation/l10n/translations.dart';
import 'package:planik/presentation/router/app_route_factory.dart';
import 'package:planik/presentation/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    Application(
      appTheme: AppTheme(),
      appRouteFactory: AppRouteFactory(),
    ),
  );
}

class Application extends StatelessWidget {
  Application({
    required this.appTheme,
    required this.appRouteFactory,
    Key? key,
  }) : super(key: key);

  final AppTheme appTheme;
  final AppRouteFactory appRouteFactory;

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: appTheme.theme(LightPalette()),
      dark: appTheme.theme(DarkPalette()),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) {
        return MaterialApp(
          onGenerateTitle: (context) => Translations.of(context).appTitle,
          localizationsDelegates: Translations.localizationsDelegates,
          supportedLocales: Translations.supportedLocales,
          theme: theme,
          darkTheme: darkTheme,
          navigatorKey: navigatorKey,
          onGenerateRoute: appRouteFactory.route,
          home: const SplashScreen(),
          builder: (context, child) => Scaffold(
            body: NavigationHub(
              navigatorKey: navigatorKey,
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class NavigationHub extends StatelessWidget {
  const NavigationHub({
    required this.navigatorKey,
    required this.child,
    Key? key,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return child!;
  }
}
