part of 'plan_bloc.dart';

@freezed
class PlanState with _$PlanState {
  const factory PlanState({
    required StateType type,
    required PlanArgument argument,
    @Default(true) bool isVertical,
    @Default(<Day>[]) List<Day> days,
  }) = _PlanState;

  factory PlanState.initial({
    required PlanArgument argument,
  }) {
    return PlanState(
      type: StateType.loading,
      argument: argument,
      isVertical: false,
      days: [],
    );
  }
}
