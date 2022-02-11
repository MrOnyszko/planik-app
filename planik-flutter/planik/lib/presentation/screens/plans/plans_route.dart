import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/presentation/components/pagination/pagination.dart';
import 'package:planik/presentation/injector_container.dart';
import 'package:planik/presentation/screens/plans/bloc/plans_bloc.dart';
import 'package:planik/presentation/screens/plans/plan_pagination_manager.dart';
import 'package:planik/presentation/screens/plans/plans_argument.dart';
import 'package:planik/presentation/screens/plans/plans_screen.dart';

Route<dynamic> plansRoute(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => MultiBlocProvider(
      providers: [
        BlocProvider<PaginationBloc<Plan>>(
          create: (context) => injector.getPaginationBloc<Plan>(
            instanceNamePrefix: PlanPaginationManager.name,
          )..add(const PaginationEvent.loadFirstPage()),
        ),
        BlocProvider<PlansBloc>(
          create: (context) => injector<PlansBloc>(
            param1: settings.arguments ?? const PlansArgument(),
          )..add(const PlansEvent.started()),
        ),
      ],
      child: const PlansScreen(),
    ),
  );
}
