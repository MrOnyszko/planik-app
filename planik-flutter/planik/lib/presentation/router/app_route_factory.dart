import 'package:flutter/material.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_route.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_screen.dart';
import 'package:planik/presentation/screens/create_plan_incentive/create_plan_incentive_route.dart';
import 'package:planik/presentation/screens/create_plan_incentive/create_plan_incentive_screen.dart';
import 'package:planik/presentation/screens/plan/plan_route.dart';
import 'package:planik/presentation/screens/plan/plan_screen.dart';
import 'package:planik/presentation/screens/plans/plans_route.dart';
import 'package:planik/presentation/screens/plans/plans_screen.dart';
import 'package:planik/presentation/screens/splash/splash_screen.dart';
import 'package:planik/presentation/screens/user_name/user_name_route.dart';
import 'package:planik/presentation/screens/user_name/user_name_screen.dart';

class AppRouteFactory {
  Route<dynamic> route(RouteSettings settings) {
    switch (settings.name) {
      case UserNameScreen.routeName:
        return userNameRoute(settings);
      case CreatePlanIncentiveScreen.routeName:
        return createPlanIncentiveRoute(settings);
      case CreatePlanScreen.routeName:
        return createPlanRoute(settings);
      case PlanScreen.routeName:
        return planRoute(settings);
      case PlansScreen.routeName:
        return plansRoute(settings);
      case SplashScreen.routeName:
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashScreen(),
        );
    }
  }
}
