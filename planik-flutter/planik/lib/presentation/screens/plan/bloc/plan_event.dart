part of 'plan_bloc.dart';

@freezed
class PlanEvent with _$PlanEvent {
  const factory PlanEvent.started() = _PlanStarted;
}
