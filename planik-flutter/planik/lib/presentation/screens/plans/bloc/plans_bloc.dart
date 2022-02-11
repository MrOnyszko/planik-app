import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planik/presentation/common/state_type.dart';
import 'package:planik/presentation/screens/plans/plans_argument.dart';

part 'plans_bloc.freezed.dart';

part 'plans_event.dart';

part 'plans_state.dart';

class PlansBloc extends Bloc<PlansEvent, PlansState> {
  PlansBloc({
    required PlansArgument argument,
  }) : super(PlansState.initial(argument: argument)) {
    on<PlansEvent>(handler, transformer: sequential());
  }

  Future<void> handler(
    PlansEvent event,
    Emitter<PlansState> emit,
  ) async {
    emit(state.copyWith(type: StateType.loaded));
  }
}
