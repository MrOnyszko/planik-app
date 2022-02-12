import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/presentation/injector_container.dart';
import 'package:planik/presentation/screens/create_plan/bloc/create_plan_bloc.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_screen.dart';

Route<dynamic> createPlanRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider<CreatePlanBloc>(
          create: (context) => injector<CreatePlanBloc>(
            param1: settings.arguments,
          )..add(const CreatePlanEvent.started()),
        ),
      ],
      child: const CreatePlanScreen(),
    ),
  );
}
