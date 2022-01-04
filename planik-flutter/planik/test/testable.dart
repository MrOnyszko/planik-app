import 'package:flutter/material.dart';
import 'package:planik/presentation/common/theme.dart';
import 'package:planik/presentation/l10n/translations.dart';

class Testable extends StatelessWidget {
  const Testable({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: Translations.localizationsDelegates,
      supportedLocales: Translations.supportedLocales,
      theme: AppTheme().theme(LightPalette()),
      home: Scaffold(body: child),
    );
  }
}
