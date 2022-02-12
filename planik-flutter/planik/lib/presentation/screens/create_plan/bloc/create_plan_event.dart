part of 'create_plan_bloc.dart';

@freezed
class CreatePlanEvent with _$CreatePlanEvent {
  const factory CreatePlanEvent.started() = CreatePlanStarted;
  const factory CreatePlanEvent.planNameChanged({required String name}) = CreatePlanNameChanged;
}
