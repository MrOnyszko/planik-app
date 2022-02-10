part of 'plan_bloc.dart';

@freezed
class PlanEvent with _$PlanEvent {
  const factory PlanEvent.started() = _PlanStarted;

  const factory PlanEvent.todayRequested() = _PlanTodayRequested;

  const factory PlanEvent.toggleViewTypeRequested() = _PlanToggleViewTypeRequested;
}
