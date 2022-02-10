import 'package:get_it/get_it.dart';
import 'package:planik/domain/domain_injector.dart';
import 'package:planik/foundation/foundation.dart';
import 'package:planik/presentation/navigation_hub/bloc/navigation_hub_bloc.dart';
import 'package:planik/presentation/screens/create_plan/bloc/create_plan_bloc.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_argument.dart';
import 'package:planik/presentation/screens/plan/bloc/plan_bloc.dart';
import 'package:planik/presentation/screens/plan/plan_argument.dart';
import 'package:planik/presentation/screens/user_name/bloc/user_name_bloc.dart';
import 'package:planik/presentation/screens/user_name/user_name_argument.dart';

final injector = GetIt.instance;

Future<void> init() async {
  await injector.registerDomain();

  injector
    ..registerSingleton<Dates>(DatesImpl())
    ..registerFactory<NavigationHubBloc>(() => NavigationHubBloc(userService: injector.get()))
    ..registerFactoryParam<UserNameBloc, UserNameArgument, void>(
      (argument, _) => UserNameBloc(
        userService: injector.get(),
        argument: argument,
      ),
    )
    ..registerFactoryParam<CreatePlanBloc, CreatePlanArgument, void>(
      (argument, _) => CreatePlanBloc(argument: argument, planService: injector.get()),
    )
    ..registerFactoryParam<PlanBloc, PlanArgument, void>(
      (argument, _) => PlanBloc(
        argument: argument,
        planService: injector.get(),
        dates: injector.get(),
      ),
    );
}
