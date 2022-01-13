import 'package:flutter/material.dart';
import 'package:planik/presentation/common/dimen.dart';
import 'package:planik/presentation/common/extensions.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_argument.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_screen.dart';

class CreatePlanIncentiveScreen extends StatelessWidget {
  static const String routeName = '/create-plan-incentive';

  const CreatePlanIncentiveScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.appTitle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Insets.huge),
          Text(
            context.strings.createPlanIncentiveScreenHeader,
            style: context.textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Insets.xxxLarge),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.xLarge),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  CreatePlanScreen.routeName,
                  (route) => false,
                  arguments: const CreatePlanArgument(),
                );
              },
              child: Text(context.strings.createPlanIncentiveScreenPrimaryAction),
            ),
          )
        ],
      ),
    );
  }
}
