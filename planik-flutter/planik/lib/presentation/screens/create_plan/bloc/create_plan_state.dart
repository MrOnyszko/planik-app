part of 'create_plan_bloc.dart';

@freezed
class CreatePlanState with _$CreatePlanState {
  const factory CreatePlanState({
    required StateType type,
    required CreatePlanArgument argument,
    @Default(<Day>[]) List<Day> days,
    @Default(null) Plan? plan,
  }) = _CreatePlanState;

  factory CreatePlanState.initial({
    required CreatePlanArgument argument,
  }) {
    return CreatePlanState(
      type: StateType.loading,
      argument: argument,
      days: [],
    );
  }
}
