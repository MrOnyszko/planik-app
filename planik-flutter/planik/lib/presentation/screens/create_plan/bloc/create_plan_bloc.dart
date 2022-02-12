import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/model/plan.dart';
import 'package:planik/domain/service/plan_service.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_argument.dart';

part 'create_plan_bloc.freezed.dart';

part 'create_plan_event.dart';

part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  CreatePlanBloc({
    required CreatePlanArgument argument,
    required PlanService planService,
  })  : _planService = planService,
        super(CreatePlanState.initial(argument: argument)) {
    on<CreatePlanEvent>(handler, transformer: sequential());
  }

  final PlanService _planService;

  Future<void> handler(
    CreatePlanEvent event,
    Emitter<CreatePlanState> emit,
  ) async {
    await event.map(
      started: (_) async {
        emit(state.copyWith(type: StateType.loading));
        emit(await _loadOrCreate());
      },
      planNameChanged: (value) async {
        emit(await _updatePlan(name: value.name));
      },
    );
  }

  Future<CreatePlanState> _loadOrCreate() {
    TaskEither<GeneralFailure, FullPlan> loadOrCreate;

    if (state.argument.id != null) {
      loadOrCreate = _planService.getPlan(id: state.argument.id);
    } else {
      loadOrCreate = _planService.addPlan();
    }

    return loadOrCreate
        .match(
          (l) => state.copyWith(type: StateType.error),
          (fullPlan) => state.copyWith(
            type: StateType.loaded,
            days: fullPlan.days,
            plan: fullPlan.plan,
          ),
        )
        .run();
  }

  Future<CreatePlanState> _updatePlan({required String name}) async {
    return _planService
        .updatePlan(id: state.plan!.id, name: name)
        .match(
          (l) => state.copyWith(type: StateType.error),
          (fullPlan) => state.copyWith(
            plan: fullPlan.plan,
            days: fullPlan.days,
          ),
        )
        .run();
  }
}
