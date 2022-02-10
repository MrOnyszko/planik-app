import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/common/theme.dart';
import 'package:planik/presentation/components/navigation_hub/bloc/navigation_hub_bloc.dart';
import 'package:planik/presentation/components/navigation_hub/navigation_hub.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              injector.get<NavigationHubBloc>()..add(const NavigationHubEvent.started()),
        ),
      ],
      child: AdaptiveTheme(
        light: appTheme.theme(LightPalette()),
        dark: appTheme.theme(DarkPalette()),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
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
      ),
    );
  }
}
