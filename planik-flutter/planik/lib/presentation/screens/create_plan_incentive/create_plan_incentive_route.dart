import 'package:flutter/material.dart';
import 'package:planik/presentation/screens/create_plan_incentive/create_plan_incentive_screen.dart';

Route<dynamic> createPlanIncentiveRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => const CreatePlanIncentiveScreen(),
  );
}
