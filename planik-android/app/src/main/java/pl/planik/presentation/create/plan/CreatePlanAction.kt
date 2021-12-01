package pl.planik.presentation.create.plan

import java.time.DayOfWeek
import java.time.OffsetTime

sealed class CreatePlanAction {
  data class PlanNameTextChanges(val text: String = "") : CreatePlanAction()
  data class DayEntryNameTextChanges(val text: String = "") : CreatePlanAction()
  data class DayEntryStartChanges(val value: OffsetTime) : CreatePlanAction()
  data class DayEntryEndChanges(val value: OffsetTime) : CreatePlanAction()
  data class DayOfWeekChanges(val value: DayOfWeek) : CreatePlanAction()
  object UpdatePlanName : CreatePlanAction()
  object AddDayEntry : CreatePlanAction()
  object Done : CreatePlanAction()
}