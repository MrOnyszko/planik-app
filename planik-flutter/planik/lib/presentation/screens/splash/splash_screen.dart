import 'package:flutter/material.dart';
import 'package:planik/presentation/screens/user_name/user_name_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UserNameScreen.routeName,
              );
            },
            child: const Text('abc'),
          ),
        ),
      ),
    );
  }
}
