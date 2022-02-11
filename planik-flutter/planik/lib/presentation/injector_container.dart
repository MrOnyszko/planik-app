import 'package:get_it/get_it.dart';
import 'package:planik/domain/domain_injector.dart';
import 'package:planik/domain/model/pageable.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/foundation/foundation.dart';
import 'package:planik/presentation/components/navigation_hub/bloc/navigation_hub_bloc.dart';
import 'package:planik/presentation/components/pagination/pagination.dart';
import 'package:planik/presentation/screens/create_plan/bloc/create_plan_bloc.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_argument.dart';
import 'package:planik/presentation/screens/plan/bloc/plan_bloc.dart';
import 'package:planik/presentation/screens/plan/plan_argument.dart';
import 'package:planik/presentation/screens/plans/bloc/plans_bloc.dart';
import 'package:planik/presentation/screens/plans/plan_pagination_manager.dart';
import 'package:planik/presentation/screens/plans/plans_argument.dart';
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
    )
    ..registerFactoryParam<PlansBloc, PlansArgument, void>(
      (argument, _) => PlansBloc(
        argument: argument,
      ),
    )
    ..registerPagination<Plan>(
      instanceNamePrefix: PlanPaginationManager.name,
      paginationManagerFactory: () => PlanPaginationManager(
        planService: injector.get(),
      ),
    );
}

extension GetItPagination on GetIt {
  String get paginationManagerPostFix => '_pagination_manager';

  String get paginationBlocPostFix => '_pagination_bloc';

  PaginationBloc<T> getPaginationBloc<T extends Pageable>({
    required String instanceNamePrefix,
  }) {
    return get(instanceName: '$instanceNamePrefix$paginationBlocPostFix');
  }

  void registerPagination<T extends Pageable>({
    required String instanceNamePrefix,
    required PaginationManager<T> Function() paginationManagerFactory,
  }) {
    this
      ..registerFactory<PaginationBloc<T>>(
        () => PaginationBloc<T>(
          paginationManager: get(instanceName: '$instanceNamePrefix$paginationManagerPostFix'),
        ),
        instanceName: '$instanceNamePrefix$paginationBlocPostFix',
      )
      ..registerFactory<PaginationManager<T>>(
        () => paginationManagerFactory(),
        instanceName: '$instanceNamePrefix$paginationManagerPostFix',
      );
  }
}
