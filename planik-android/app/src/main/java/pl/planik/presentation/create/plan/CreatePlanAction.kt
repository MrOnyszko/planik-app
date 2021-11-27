package pl.planik.presentation.create.plan

sealed class CreatePlanAction {
  data class PlanNameTextChanges(val text: String = "") : CreatePlanAction()
  data class DayEntryNameTextChanges(val text: String = "") : CreatePlanAction()
  object UpdatePlanName : CreatePlanAction()
  object AddDayEntry : CreatePlanAction()
  object Done : CreatePlanAction()
}