package pl.planik.presentation.create.plan

import java.time.DayOfWeek

sealed class CreatePlanAction {
  data class PlanNameTextChanges(val text: String = "") : CreatePlanAction()
  data class DayOfWeekChanges(val value: DayOfWeek) : CreatePlanAction()
  object UpdatePlanName : CreatePlanAction()
  object Done : CreatePlanAction()
}