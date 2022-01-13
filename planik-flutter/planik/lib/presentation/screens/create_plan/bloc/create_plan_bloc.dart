import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/domain/model/day.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/create_plan/create_plan_argument.dart';

part 'create_plan_bloc.freezed.dart';

part 'create_plan_event.dart';

part 'create_plan_state.dart';

class CreatePlanBloc extends Bloc<CreatePlanEvent, CreatePlanState> {
  CreatePlanBloc({
    required CreatePlanArgument argument,
  }) : super(CreatePlanState.initial(argument: argument)) {
    on<CreatePlanEvent>(handler, transformer: sequential());
  }

  Future<void> handler(
    CreatePlanEvent event,
    Emitter<CreatePlanState> emit,
  ) async {
    await event.map(
      started: (_) async {
        emit(state.copyWith(type: StateType.loaded));
      },
    );
  }
}
