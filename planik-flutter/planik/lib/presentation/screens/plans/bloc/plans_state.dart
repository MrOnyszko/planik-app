part of 'plans_bloc.dart';

@freezed
class PlansState with _$PlansState {
  const factory PlansState({
    required StateType type,
    required PlansArgument argument,
  }) = _PlansState;

  factory PlansState.initial({
    required PlansArgument argument,
  }) {
    return PlansState(
      type: StateType.loading,
      argument: argument,
    );
  }
}
