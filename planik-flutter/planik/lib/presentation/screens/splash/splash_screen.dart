import 'package:flutter/material.dart';
import 'package:planik/presentation/common/extensions.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Text(context.strings.appTitle),
      ),
    );
  }
}
