import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/injector_container.dart';
import 'package:planik/presentation/screens/plan/bloc/plan_bloc.dart';
import 'package:planik/presentation/screens/plan/plan_argument.dart';
import 'package:planik/presentation/screens/plan/plan_screen.dart';

Route<dynamic> planRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider<PlanBloc>(
          create: (context) => injector<PlanBloc>(
            param1: settings.arguments ?? const PlanArgument(),
          )..add(const PlanEvent.started()),
        ),
      ],
      child: const PlanScreen(),
    ),
  );
}
