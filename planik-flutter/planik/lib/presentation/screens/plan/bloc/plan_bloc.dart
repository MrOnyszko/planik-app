import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/failure/general_failure.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/domain/model/full_plan.dart';
import 'package:planik/domain/service/plan_service.dart';
import 'package:planik/foundation/extensions/dates.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/plan/plan_argument.dart';

part 'plan_bloc.freezed.dart';

part 'plan_event.dart';

part 'plan_state.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  PlanBloc({
    required PlanArgument argument,
    required PlanService planService,
    required Dates dates,
  })  : _planService = planService,
        _dates = dates,
        super(PlanState.initial(argument: argument)) {
    on<PlanEvent>(handler, transformer: sequential());
  }

  final PlanService _planService;
  final Dates _dates;

  Future<void> handler(
    PlanEvent event,
    Emitter<PlanState> emit,
  ) async {
    await event.map(
      started: (_) async {
        emit(state.copyWith(type: StateType.loading));
        emit(await _loadPlan());
      },
      todayRequested: (_) async {
        final weekday = _dates.now().weekday;
        int? indexOfToday;
        if (state.isVertical) {
          indexOfToday = state.entryIndexForDayOfWeek(weekday);
        } else {
          indexOfToday = state.dayIndexForDayOfWeek(weekday);
        }
        emit(state.copyWith(indexOfToday: indexOfToday));
        await const Duration(milliseconds: 50).delay;
        emit(state.copyWith(indexOfToday: null));
      },
      toggleViewTypeRequested: (_) {
        emit(state.copyWith(isVertical: !state.isVertical));
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
