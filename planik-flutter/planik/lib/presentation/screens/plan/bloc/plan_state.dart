part of 'plan_bloc.dart';

@freezed
class PlanState with _$PlanState {
  const factory PlanState({
    required StateType type,
    required PlanArgument argument,
    required int? indexOfToday,
    @Default(true) bool isVertical,
    @Default(<Day>[]) List<Day> days,
  }) = _PlanState;

  factory PlanState.initial({
    required PlanArgument argument,
  }) {
    return PlanState(
      type: StateType.loading,
      argument: argument,
      indexOfToday: null,
      isVertical: true,
      days: [],
    );
  }
}

extension $_PlanState on PlanState {
  int? entryIndexForDayOfWeek(int dayOfWeek) {
    final entries = days.flatMap((it) => it.entries).toList(growable: false);
    final entry = entries.firstWhereOrNull((element) => element.dayOfWeek == dayOfWeek);
    if (entry != null) {
      return entries.indexOf(entry);
    }
    return null;
  }

  int? dayIndexForDayOfWeek(int dayOfWeek) {
    var index = 0;
    for (final element in days) {
      if (element.date.weekday == dayOfWeek) {
        return index;
      }
      index++;
    }
    return null;
  }
}
