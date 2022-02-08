import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/service/plan_service.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/plan/plan_argument.dart';

part 'plan_bloc.freezed.dart';

part 'plan_event.dart';

part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc({
    required PlanArgument argument,
    required PlanService planService,
  })  : _planService = planService,
        super(PlanState.initial(argument: argument)) {
    on<PlanEvent>(handler, transformer: sequential());
  }

  final PlanService _planService;

  Future<void> handler(
    PlanEvent event,
    Emitter<PlanState> emit,
  ) async {
    await event.map(
      started: (_) async {
        emit(state.copyWith(type: StateType.loading));
        emit(await _loadPlan());
      },
    );
  }

  Future<PlanState> _loadPlan() {
    TaskEither<GeneralFailure, FullPlan> loadOrCreate;

    if (state.argument.id != null) {
      loadOrCreate = _planService.getPlan(id: state.argument.id);
    } else {
      loadOrCreate = _planService.getCurrentPlan();
    }

    return loadOrCreate
        .match(
          (l) => state.copyWith(type: StateType.error),
          (fullPlan) => state.copyWith(type: StateType.loaded, days: fullPlan.days),
        )
        .run();
  }
}
