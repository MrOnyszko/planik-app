part of 'create_plan_bloc.dart';

@freezed
class CreatePlanEvent with _$CreatePlanEvent {
  const factory CreatePlanEvent.started() = _CreatePlanStarted;
}
